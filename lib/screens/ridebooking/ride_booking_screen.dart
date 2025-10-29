import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:movira/screens/review/rating_screen.dart';
import 'package:movira/screens/ridebooking/widgets/confirmation_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/destination_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/destination_reached_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/driver_arriving_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/finding_driver_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/pickup_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/sos_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/trip_progress_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/type_select_bottom_sheet.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/map_theme.dart';
import 'package:movira/utils/widgets/my_app_bar.dart';

// Bottom Sheet Types Enum
enum BottomSheetType {
  pickup,
  destination,
  typeSelection,
  confirmation,
  findingDriver,
  driverArriving,
  tripProgress,
  sos,
  destinationReached,
  // TODO: Add more bottom sheet types here as needed
  // rating,
  // paymentDetails,
  // tripHistory,
  // etc.
}

class RideBookingScreen extends StatefulWidget {
  const RideBookingScreen({super.key});

  @override
  State<RideBookingScreen> createState() => _RideBookingScreenState();
}

class _RideBookingScreenState extends State<RideBookingScreen> {
  GoogleMapController? _mapController;
  LatLng _currentPosition = const LatLng(37.7749, -122.4194);
  LatLng _pickupPosition = const LatLng(37.7749, -122.4194);
  LatLng? _destinationPosition;
  final Set<Marker> _markers = {};
  bool _isLoading = true;

  // Search controllers for different bottom sheets
  final TextEditingController _pickupSearchController = TextEditingController();
  final TextEditingController _destinationSearchController = TextEditingController();

  List<Map<String, dynamic>> _searchResults = [];
  bool _showSearchResults = false;

  // Current bottom sheet being displayed
  BottomSheetType _currentBottomSheet = BottomSheetType.pickup;

  // Addresses
  String? _pickupAddress;
  String? _destinationAddress;

  // Booking details
  String _selectedCarType = 'Mini Car';
  double _baseFare = 95.0;
  double _platformCharges = 5.0;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _pickupSearchController.dispose();
    _destinationSearchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _isLoading = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoading = false);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _pickupPosition = _currentPosition;
        _isLoading = false;
        _updateMarkers();
      });

      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(_currentPosition, 15),
      );
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error getting location: $e');
    }
  }

  void _updateMarkers() {
    _markers.clear();

    // Current location marker (yellow)
    _markers.add(
      Marker(
        markerId: const MarkerId('current_location'),
        position: _currentPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        anchor: const Offset(0.5, 0.5),
      ),
    );

    // Pickup location marker (black pin)
    if (_pickupPosition != _currentPosition) {
      _markers.add(
        Marker(
          markerId: const MarkerId('pickup_location'),
          position: _pickupPosition,
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
    }

    // Destination marker (red)
    if (_destinationPosition != null) {
      _markers.add(
        Marker(
          markerId: const MarkerId('destination_location'),
          position: _destinationPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    setState(() {});
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty || query.length < 3) {
      setState(() {
        _showSearchResults = false;
        _searchResults = [];
      });
      return;
    }

    try {
      List<Location> locations = await locationFromAddress(query);
      List<Map<String, dynamic>> results = [];

      for (var location in locations) {
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            location.latitude,
            location.longitude,
          );

          if (placemarks.isNotEmpty) {
            final placemark = placemarks.first;
            String name = '';

            if (placemark.name != null && placemark.name!.isNotEmpty) {
              name = placemark.name!;
            }
            if (placemark.street != null && placemark.street!.isNotEmpty) {
              name += name.isEmpty ? placemark.street! : ', ${placemark.street}';
            }
            if (placemark.locality != null && placemark.locality!.isNotEmpty) {
              name += name.isEmpty ? placemark.locality! : ', ${placemark.locality}';
            }
            if (placemark.country != null && placemark.country!.isNotEmpty) {
              name += name.isEmpty ? placemark.country! : ', ${placemark.country}';
            }

            results.add({
              'name': name.isEmpty ? 'Unknown Location' : name,
              'location': location,
            });
          }
        } catch (e) {
          print('Error getting placemark: $e');
        }
      }

      setState(() {
        _searchResults = results;
        _showSearchResults = results.isNotEmpty;
      });
    } catch (e) {
      print('Error searching location: $e');
      setState(() {
        _searchResults = [];
        _showSearchResults = false;
      });
    }
  }

  void _selectSearchResult(int index) async {
    final result = _searchResults[index];
    final Location location = result['location'];
    final selectedPosition = LatLng(location.latitude, location.longitude);

    if (_currentBottomSheet == BottomSheetType.pickup) {
      _pickupSearchController.text = result['name'];
      _pickupAddress = result['name'];
      setState(() {
        _pickupPosition = selectedPosition;
        _showSearchResults = false;
        _updateMarkers();
      });
    } else if (_currentBottomSheet == BottomSheetType.destination) {
      _destinationSearchController.text = result['name'];
      _destinationAddress = result['name'];
      setState(() {
        _destinationPosition = selectedPosition;
        _showSearchResults = false;
        _updateMarkers();
      });
    }

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(selectedPosition, 16),
    );
  }

  void _onMapTapped(LatLng position) {
    if (_currentBottomSheet == BottomSheetType.pickup) {
      setState(() {
        _pickupPosition = position;
        _updateMarkers();
      });
      _updateSearchFieldWithAddress(position, true);
    } else if (_currentBottomSheet == BottomSheetType.destination) {
      setState(() {
        _destinationPosition = position;
        _updateMarkers();
      });
      _updateSearchFieldWithAddress(position, false);
    }
  }

  Future<void> _updateSearchFieldWithAddress(LatLng position, bool isPickup) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        String address = '';

        if (placemark.street != null && placemark.street!.isNotEmpty) {
          address = placemark.street!;
        }
        if (placemark.locality != null && placemark.locality!.isNotEmpty) {
          address += address.isEmpty ? placemark.locality! : ', ${placemark.locality}';
        }

        final finalAddress = address.isEmpty ? 'Selected Location' : address;

        if (isPickup) {
          _pickupSearchController.text = finalAddress;
          _pickupAddress = finalAddress;
        } else {
          _destinationSearchController.text = finalAddress;
          _destinationAddress = finalAddress;
        }
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  // Navigate to next bottom sheet
  void _goToNextBottomSheet() {
    setState(() {
      if (_currentBottomSheet == BottomSheetType.pickup) {
        _currentBottomSheet = BottomSheetType.destination;
        _showSearchResults = false;
      } else if (_currentBottomSheet == BottomSheetType.destination) {
        _currentBottomSheet = BottomSheetType.typeSelection;
        _showSearchResults = false;
      } else if (_currentBottomSheet == BottomSheetType.typeSelection) {
        _currentBottomSheet = BottomSheetType.confirmation;
      } else if (_currentBottomSheet == BottomSheetType.confirmation) {
        _currentBottomSheet = BottomSheetType.findingDriver;
        _simulateFindingDriver();
      }
      // TODO: Add more bottom sheet navigation logic here
    });
  }

  // Navigate to previous bottom sheet
  void _goToPreviousBottomSheet() {
    setState(() {
      if (_currentBottomSheet == BottomSheetType.destination) {
        _currentBottomSheet = BottomSheetType.pickup;
        _showSearchResults = false;
      } else if (_currentBottomSheet == BottomSheetType.typeSelection) {
        _currentBottomSheet = BottomSheetType.destination;
        _showSearchResults = false;
      } else if (_currentBottomSheet == BottomSheetType.confirmation) {
        _currentBottomSheet = BottomSheetType.typeSelection;
      }
      // TODO: Add more bottom sheet navigation logic here
    });
  }

  // Switch to specific bottom sheet
  void _switchToBottomSheet(BottomSheetType type) {
    setState(() {
      _currentBottomSheet = type;
      _showSearchResults = false;
    });
  }

  // Simulate finding driver
  void _simulateFindingDriver() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _currentBottomSheet == BottomSheetType.findingDriver) {
        setState(() {
          _currentBottomSheet = BottomSheetType.driverArriving;
        });
        _simulateDriverArrival();
      }
    });
  }

  // Simulate driver arrival to trip start
  void _simulateDriverArrival() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted && _currentBottomSheet == BottomSheetType.driverArriving) {
        setState(() {
          _currentBottomSheet = BottomSheetType.tripProgress;
        });
        _simulateTripCompletion();
      }
    });
  }

  // Simulate trip completion
  void _simulateTripCompletion() {
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted && _currentBottomSheet == BottomSheetType.tripProgress) {
        setState(() {
          _currentBottomSheet = BottomSheetType.destinationReached;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MAppBar(
        title: 'Ride Booking',
        showBackButton: true,
      ),
      body: Stack(
        children: [
          // Google Map
          _isLoading
              ? const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          )
              : GoogleMap(
            style: lightMapTheme, // Use style parameter instead of setMapStyle
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              // Removed deprecated setMapStyle call
            },
            markers: _markers,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            onTap: _onMapTapped,
          ),

          // Bottom Sheet - Dynamic based on current state
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _buildCurrentBottomSheet(),
          ),

          // My Location Button
          if (_currentBottomSheet == BottomSheetType.pickup ||
              _currentBottomSheet == BottomSheetType.destination)
            Positioned(
              right: 16,
              top: 20,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.my_location,
                    color: AppColors.black,
                    size: 20,
                  ),
                  onPressed: () async {
                    await _mapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(_currentPosition, 12),
                    );

                    // Small delay for effect
                    await Future.delayed(Duration(milliseconds: 300));

                    // Zoom back in
                    await _mapController!.animateCamera(
                      CameraUpdate.newLatLngZoom(_currentPosition, 14),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Build current bottom sheet based on state
  Widget _buildCurrentBottomSheet() {
    switch (_currentBottomSheet) {
    // 1. Pickup Location Selection
      case BottomSheetType.pickup:
        return PickupBottomSheet(
          searchController: _pickupSearchController,
          onSearchChanged: _searchLocation,
          onConfirm: _goToNextBottomSheet,
          searchResults: _searchResults,
          onResultTap: _selectSearchResult,
          showSearchResults: _showSearchResults,
        );

    // 2. Destination Selection
      case BottomSheetType.destination:
        return DestinationBottomSheet(
          searchController: _destinationSearchController,
          onSearchChanged: _searchLocation,
          onConfirm: _goToNextBottomSheet,
          searchResults: _searchResults,
          onResultTap: _selectSearchResult,
          showSearchResults: _showSearchResults,
        );

    // 3. Type Selection (Ride/Package + Car Type)
      case BottomSheetType.typeSelection:
        return TypeSelectionBottomSheet(
          pickupAddress: _pickupAddress,
          dropOffAddress: _destinationAddress,
          onPickupTap: () => _switchToBottomSheet(BottomSheetType.pickup),
          onDropOffTap: () => _switchToBottomSheet(BottomSheetType.destination),
          onConfirm: _goToNextBottomSheet,
        );

    // 4. Confirmation Screen
      case BottomSheetType.confirmation:
        return ConfirmationBottomSheet(
          pickupAddress: _pickupAddress ?? 'Unknown Location',
          dropOffAddress: _destinationAddress ?? 'Unknown Location',
          carType: _selectedCarType,
          baseFare: _baseFare,
          platformCharges: _platformCharges,
          onConfirm: _goToNextBottomSheet,
        );

    // 5. Finding Driver
      case BottomSheetType.findingDriver:
        return FindingDriverBottomSheet(
          pickupAddress: _pickupAddress ?? 'Unknown Location',
          dropOffAddress: _destinationAddress ?? 'Unknown Location',
          estimatedTime: '30 mins',
          distance: '14.2 KM',
          baseFare: _baseFare,
          platformCharges: _platformCharges,
          onCancel: () {
            setState(() {
              _currentBottomSheet = BottomSheetType.typeSelection;
            });
          },
        );

    // 6. Driver Arriving
      case BottomSheetType.driverArriving:
        return DriverArrivingBottomSheet(
          driverName: 'Marvin McKinney',
          driverImage: 'assets/images/driver.png',
          rating: 4.5,
          carModel: 'Chevrolet Tornado',
          carPlate: 'ES-345-LJ5',
          arrivalTime: '5 minutes',
          approximatePrice: _baseFare + _platformCharges,
          onMessage: () {
            print('Message driver');
            // TODO: Implement messaging
          },
          onCall: () {
            print('Call driver');
            // TODO: Implement calling
          },
        );

    // 7. Trip in Progress
      case BottomSheetType.tripProgress:
        return TripProgressBottomSheet(
          driverName: 'Marvin McKinney',
          driverImage: 'assets/images/driver.png',
          rating: 4.5,
          carModel: 'Chevrolet Tornado',
          carPlate: 'ES-345-LJ5',
          approximatePrice: _baseFare + _platformCharges,
          onMessage: () {
            print('Message driver');
          },
          onCall: () {
            print('Call driver');
          },
          onEmergencySOS: () {
            _switchToBottomSheet(BottomSheetType.sos);
          },
        );

    // 8. Emergency SOS
      case BottomSheetType.sos:
        return SosBottomSheet(
          onCall911: () {
            print('Calling 911...');
            // TODO: Implement emergency call
          },
          onShareLocation: () {
            print('Sharing live location...');
            // TODO: Implement location sharing
          },
          onAlertSupport: () {
            print('Alerting Movira support...');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Support team has been alerted!'),
                backgroundColor: AppColors.green,
              ),
            );
            // Go back to trip progress
            setState(() {
              _currentBottomSheet = BottomSheetType.tripProgress;
            });
          },
        );

    // 9. Destination Reached
      case BottomSheetType.destinationReached:
        return DestinationReachedBottomSheet(
          driverName: 'Marvin McKinney',
          driverImage: 'assets/images/driver.png',
          rating: 4.5,
          carModel: 'Chevrolet Tornado',
          carPlate: 'ES-345-LJ5',
          approximatePrice: _baseFare + _platformCharges,
          onRateExperience: () {
            print('Rate experience tapped');
            // TODO: Navigate to rating screen
            Get.to(RatingReviewScreen());
          },
        );
 

      default:
        return PickupBottomSheet(
          searchController: _pickupSearchController,
          onSearchChanged: _searchLocation,
          onConfirm: _goToNextBottomSheet,
          searchResults: _searchResults,
          onResultTap: _selectSearchResult,
          showSearchResults: _showSearchResults,
        );
    }
  }
}