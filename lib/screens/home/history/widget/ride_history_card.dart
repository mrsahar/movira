import 'package:flutter/material.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart'; 

class RideHistoryCard extends StatelessWidget {
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

  const RideHistoryCard({
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main content with padding
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Driver Info Section - Split into two parts
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFE0E0E0),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Top part - White background with driver details
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(11),
                            topRight: Radius.circular(11),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Driver Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                driverImage,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 55,
                                    height: 55,
                                    color: AppColors.greyLight,
                                    child: Icon(
                                      Icons.person,
                                      size: 28,
                                      color: AppColors.textSecondary,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 12),

                            // Driver Name and Rating
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    driverName,
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 14,
                                        color: AppColors.primary,
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        '$driverRating',
                                        style: AppTextStyles.bodyMedium.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Car Model and Plate
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  carModel,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  carPlate,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Bottom part - Gray background with status text
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(11),
                            bottomRight: Radius.circular(11),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_car,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              statusText,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // Route Section with vertical line
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side with line
                    Column(
                      children: [
                        // Red circle for pickup
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Vertical line
                        Container(
                          width: 2,
                          height: 35,
                          margin: const EdgeInsets.symmetric(vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.textSecondary.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        // Location pin for drop
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: AppColors.black,
                        ),
                      ],
                    ),

                    const SizedBox(width: 10),

                    // Right side with locations and info
                    Expanded(
                      child: Column(
                        children: [
                          // Pickup Location Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  pickupLocation,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    duration,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 35),

                          // Drop Location Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  dropLocation,
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.navigation,
                                    size: 13,
                                    color: AppColors.textSecondary,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    distance,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: AppColors.textSecondary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Divider(
                  color: AppColors.greyLight.withValues(alpha: 0.5),
                  height: 1,
                ),

                const SizedBox(height: 14),

                // Price Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Approximate price',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontSize: 13,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      price,
                      style: AppTextStyles.h4.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: status == RideStatus.cancelled
                            ? AppColors.textSecondary
                            : AppColors.black,
                        decoration: status == RideStatus.cancelled
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status Badge - Full width at bottom
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: _getStatusBackgroundColor(),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Status : ',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 13,
                    color: AppColors.black,
                  ),
                ),
                Icon(
                  _getStatusIcon(),
                  size: 14,
                  color: _getStatusTextColor(),
                ),
                const SizedBox(width: 3),
                Text(
                  _getStatusLabel(),
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontSize: 13,
                    color: _getStatusTextColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusBackgroundColor() {
    switch (status) {
      case RideStatus.inProgress:
        return const Color(0xFFE3F2FD);
      case RideStatus.completed:
        return const Color(0xFFE8F5E9);
      case RideStatus.cancelled:
        return const Color(0xFFFFEBEE);
    }
  }

  Color _getStatusTextColor() {
    switch (status) {
      case RideStatus.inProgress:
        return const Color(0xFF1976D2);
      case RideStatus.completed:
        return const Color(0xFF388E3C);
      case RideStatus.cancelled:
        return const Color(0xFFD32F2F);
    }
  }

  IconData _getStatusIcon() {
    switch (status) {
      case RideStatus.inProgress:
        return Icons.access_time;
      case RideStatus.completed:
        return Icons.check_circle;
      case RideStatus.cancelled:
        return Icons.cancel;
    }
  }

  String _getStatusLabel() {
    switch (status) {
      case RideStatus.inProgress:
        return 'In Progress';
      case RideStatus.completed:
        return 'Completed';
      case RideStatus.cancelled:
        return 'Cancelled';
    }
  }
}

enum RideStatus {
  inProgress,
  completed,
  cancelled,
}