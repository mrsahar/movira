import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:movira/screens/ridebooking/widgets/destination_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/pickup_bottom_sheet.dart';
import 'package:movira/screens/ridebooking/widgets/type_select_bottom_sheet.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/map_theme.dart';

// Bottom Sheet Types Enum
enum BottomSheetType {
  pickup,
  destination,
  typeSelection,
  // TODO: Add more bottom sheet types here as needed
  // payment,
  // rideDetails,
  // driverInfo,
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
      }
      // TODO: Add more bottom sheet navigation logic here
      // else if (_currentBottomSheet == BottomSheetType.typeSelection) {
      //   _currentBottomSheet = BottomSheetType.payment;
      // }
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
      }
      // TODO: Add more bottom sheet navigation logic here
      // else if (_currentBottomSheet == BottomSheetType.payment) {
      //   _currentBottomSheet = BottomSheetType.typeSelection;
      // }
    });
  }

  // Switch to specific bottom sheet
  void _switchToBottomSheet(BottomSheetType type) {
    setState(() {
      _currentBottomSheet = type;
      _showSearchResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black, size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Ride Booking',
          style: AppTextStyles.custom(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
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
            initialCameraPosition: CameraPosition(
              target: _currentPosition,
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _mapController?.setMapStyle(lightMapTheme);
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
          Positioned(
            right: 16,
            bottom: 220,
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
                onPressed: () {
                  _mapController?.animateCamera(
                    CameraUpdate.newLatLngZoom(_currentPosition, 15),
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
      case BottomSheetType.pickup:
        return PickupBottomSheet(
          searchController: _pickupSearchController,
          onSearchChanged: _searchLocation,
          onConfirm: _goToNextBottomSheet, // Go to destination
          searchResults: _searchResults,
          onResultTap: _selectSearchResult,
          showSearchResults: _showSearchResults,
        );

      case BottomSheetType.destination:
        return DestinationBottomSheet(
          searchController: _destinationSearchController,
          onSearchChanged: _searchLocation,
          onConfirm: _goToNextBottomSheet, // Go to type selection
          searchResults: _searchResults,
          onResultTap: _selectSearchResult,
          showSearchResults: _showSearchResults,
        );

      case BottomSheetType.typeSelection:
        return TypeSelectionBottomSheet(
          pickupAddress: _pickupAddress,
          dropOffAddress: _destinationAddress,
          onPickupTap: () => _switchToBottomSheet(BottomSheetType.pickup),
          onDropOffTap: () => _switchToBottomSheet(BottomSheetType.destination),
          onConfirm: () {
            // Final confirmation
            Navigator.pop(context, {
              'pickup': _pickupPosition,
              'destination': _destinationPosition,
              'pickupAddress': _pickupAddress,
              'destinationAddress': _destinationAddress,
            });
          },
        );

    // TODO: Add more bottom sheet cases here
    // case BottomSheetType.payment:
    //   return PaymentBottomSheet(
    //     onConfirm: _goToNextBottomSheet,
    //     onBack: _goToPreviousBottomSheet,
    //   );

    // case BottomSheetType.rideDetails:
    //   return RideDetailsBottomSheet(
    //     onConfirm: _goToNextBottomSheet,
    //     onBack: _goToPreviousBottomSheet,
    //   );

    // case BottomSheetType.driverInfo:
    //   return DriverInfoBottomSheet(
    //     onConfirm: () {
    //       // Complete booking
    //     },
    //   );

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