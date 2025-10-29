import 'package:flutter/material.dart';
import 'package:movira/screens/home/history/widget/ride_history_card.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/widgets/my_app_bar.dart';

class RideDetailScreen extends StatelessWidget {
  final String driverName;
  final String driverImage;
  final double driverRating;
  final String carModel;
  final String carPlate;
  final String pickupLocation;
  final String dropLocation;
  final String duration;
  final String distance;
  final String price;
  final String statusText;
  final RideStatus status;
  final String date;
  final String time;
  final String totalDistance;
  final String timeTaken;
  final String baseFare;
  final String tax;
  final String paymentMethod;
  final double? userRating;
  final String? userReview;

  const RideDetailScreen({
    super.key,
    required this.driverName,
    required this.driverImage,
    required this.driverRating,
    required this.carModel,
    required this.carPlate,
    required this.pickupLocation,
    required this.dropLocation,
    required this.duration,
    required this.distance,
    required this.price,
    required this.statusText,
    required this.status,
    required this.date,
    required this.time,
    required this.totalDistance,
    required this.timeTaken,
    required this.baseFare,
    required this.tax,
    this.paymentMethod = 'Card',
    this.userRating,
    this.userReview,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MAppBar(
      title: 'Ride Details',
      showBackButton: true,
    ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Ride History Card (Reused component)
              RideHistoryCard(
                driverName: driverName,
                driverImage: driverImage,
                driverRating: driverRating,
                carModel: carModel,
                carPlate: carPlate,
                pickupLocation: pickupLocation,
                dropLocation: dropLocation,
                duration: duration,
                distance: distance,
                price: price,
                statusText: statusText,
                status: status,
              ),

              const SizedBox(height: 16),

              // Payment Through Section
              _buildInfoCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment Through',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 14,color: AppColors.black,
                      ),
                    ),
                    Row(
                      children: [
                        // Mastercard logo
                        Container(
                          width: 32,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Image.asset(
                            'assets/images/master.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.red.shade100,
                                child: Icon(
                                  Icons.credit_card,
                                  size: 16,
                                  color: Colors.red,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          paymentMethod,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Ride Details Section
              _buildInfoCard(
                child: Column(
                  children: [
                    _buildDetailRow('Date', date),
                    const SizedBox(height: 12),
                    _buildDetailRow('Time', time),
                    const SizedBox(height: 12),
                    _buildDetailRow('Total Distance', totalDistance),
                    const SizedBox(height: 12),
                    _buildDetailRow('Time Taken', timeTaken),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Price Breakdown Section
              _buildInfoCard(
                child: Column(
                  children: [
                    _buildDetailRow('Base Fare', baseFare),
                    const SizedBox(height: 12),
                    _buildDetailRow('Tax', tax),
                    const SizedBox(height: 12),
                    Divider(
                      color: AppColors.greyLight.withValues(alpha: 0.5),
                      height: 1,
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Approximate Price',
                      price,
                      isBold: true,
                    ),
                  ],
                ),
              ),

              if (userRating != null) ...[
                const SizedBox(height: 16),

                // Ratings & Review Section
                _buildInfoCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ratings & Review Given',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ...List.generate(5, (index) {
                            return Icon(
                              index < userRating!.floor()
                                  ? Icons.star
                                  : Icons.star_border,
                              color: AppColors.primary,
                              size: 20,
                            );
                          }),
                          const SizedBox(width: 8),
                          Text(
                            '(${userRating!.toStringAsFixed(1)})',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      if (userReview != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          userReview!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }
}