import 'package:flutter/material.dart';
import 'package:movira/screens/home/history/widget/ride_history_card.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

import 'package:flutter/material.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class HistoryCompletedScreen extends StatelessWidget {
  const HistoryCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data with 3 rides
    final List<Map<String, dynamic>> rides = [
      {
        'driverName': 'Marvin McKinney',
        'driverImage': 'assets/images/profile_user.png',
        'driverRating': 4.5,
        'carModel': 'Chevrolet Tornado',
        'carPlate': 'ES-345-IJ5',
        'pickupLocation': 'Lomas de Zamora, Mexico City',
        'dropLocation': 'North Las Vegas (NV), Guanajuato',
        'duration': '30 mins',
        'distance': '14.2 KM',
        'price': '\$120.00',
        'statusText': 'Booked a ride to travel.',
      },
      {
        'driverName': 'Robert Fox',
        'driverImage': 'assets/images/profile_user.png',
        'driverRating': 4.7,
        'carModel': 'Honda Civic',
        'carPlate': 'CD-567-XY9',
        'pickupLocation': 'Central Park, Mexico City',
        'dropLocation': 'Shopping Mall, Guadalajara',
        'duration': '1 hr 15 mins',
        'distance': '45.8 KM',
        'price': '\$200.00',
        'statusText': 'Ride completed successfully.',
      },
      {
        'driverName': 'Sarah Johnson',
        'driverImage': 'assets/images/profile_user.png',
        'driverRating': 4.9,
        'carModel': 'Tesla Model 3',
        'carPlate': 'TX-123-EV5',
        'pickupLocation': 'Business District, Monterrey',
        'dropLocation': 'University Campus, Monterrey',
        'duration': '20 mins',
        'distance': '8.5 KM',
        'price': '\$85.00',
        'statusText': 'Quick city ride.',
      },
    ];

    if (rides.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: AppColors.greyLight,
            ),
            const SizedBox(height: 16),
            Text(
              'No completed rides',
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
            status: RideStatus.completed,
          ),
        );
      },
    );
  }
}