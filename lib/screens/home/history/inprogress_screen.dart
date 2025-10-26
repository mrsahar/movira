import 'package:flutter/material.dart';
import 'package:movira/screens/home/history/ride_detail_screen.dart';
import 'package:movira/screens/home/history/widget/ride_history_card.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class HistoryInProgressScreen extends StatelessWidget {
  const HistoryInProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data with 2 rides
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
        'driverName': 'Jane Cooper',
        'driverImage': 'assets/images/profile_user.png',
        'driverRating': 4.8,
        'carModel': 'Toyota Camry',
        'carPlate': 'MX-789-AB3',
        'pickupLocation': 'Downtown Plaza, Mexico City',
        'dropLocation': 'Airport Terminal 2, Mexico City',
        'duration': '45 mins',
        'distance': '22.5 KM',
        'price': '\$150.00',
        'statusText': 'Driver is on the way.',
      },
    ];

    if (rides.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 80,
              color: AppColors.greyLight,
            ),
            const SizedBox(height: 16),
            Text(
              'No rides in progress',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    // In your history screens, wrap the card with GestureDetector
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RideDetailScreen(
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
                    date: '09 May 2023',
                    time: '12:00 PM',
                    totalDistance: '12 km',
                    timeTaken: '30 min',
                    baseFare: '\$95',
                    tax: '\$5',
                    paymentMethod: 'Card',
                    userRating: 4.0,
                    userReview: 'Great service! The driver was punctual, courteous, and drove safely.',
                  ),
                ),
              );
            },
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
          ),
        );
      },
    );
  }
}