import 'package:flutter/material.dart';
import 'package:movira/screens/home/history/widget/ride_history_card.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class HistoryCancelledScreen extends StatelessWidget {
  const HistoryCancelledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data with 2 rides
    final List<Map<String, dynamic>> rides = [
      {
        'driverName': 'David Miller',
        'driverImage': 'assets/images/profile_user.png',
        'driverRating': 4.3,
        'carModel': 'Nissan Altima',
        'carPlate': 'NX-456-QW8',
        'pickupLocation': 'North Station, Mexico City',
        'dropLocation': 'South Beach, Cancun',
        'duration': '2 hrs',
        'distance': '75.3 KM',
        'price': '\$280.00',
        'statusText': 'Ride was cancelled.',
      },
      {
        'driverName': 'Emily Davis',
        'driverImage': 'assets/images/profile_user.png',
        'driverRating': 4.6,
        'carModel': 'Hyundai Elantra',
        'carPlate': 'HY-789-ZX2',
        'pickupLocation': 'City Center, Puebla',
        'dropLocation': 'Airport, Puebla',
        'duration': '35 mins',
        'distance': '18.7 KM',
        'price': '\$95.00',
        'statusText': 'Cancelled by driver.',
      },
    ];

    if (rides.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cancel_outlined,
              size: 80,
              color: AppColors.greyLight,
            ),
            const SizedBox(height: 16),
            Text(
              'No cancelled rides',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: RideHistoryCard(
            driverName: ride['driverName'],
            driverImage: ride['driverImage'],
            driverRating: ride['driverRating'],
            carModel: ride['carModel'],
            carPlate: ride['carPlate'],
            pickupLocation: ride['pickupLocation'],
            dropLocation: ride['dropLocation'],
            duration: ride['duration'],
            distance: ride['distance'],
            price: ride['price'],
            statusText: ride['statusText'],
            status: RideStatus.cancelled,
          ),
        );
      },
    );
  }
}