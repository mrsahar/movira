import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movira/utils/constants/colors.dart'; 
import 'package:movira/utils/text_style.dart';

class FindingDriverBottomSheet extends StatelessWidget {
  final String pickupAddress;
  final String dropOffAddress;
  final String estimatedTime;
  final String distance;
  final double baseFare;
  final double platformCharges;
  final VoidCallback onCancel;

  const FindingDriverBottomSheet({
    Key? key,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.estimatedTime,
    required this.distance,
    required this.baseFare,
    required this.platformCharges,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final approximatePrice = baseFare + platformCharges;

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with animated dots
            Center(
              child: Text(
                'Finding riders near your location.....',
                style: AppTextStyles.custom(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Locations and Info Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side - Locations
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pickup Location
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 4),
                            decoration: const BoxDecoration(
                              color: AppColors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              pickupAddress,
                              style: AppTextStyles.custom(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Drop-off Location
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/bold_location.svg',
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              AppColors.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              dropOffAddress,
                              style: AppTextStyles.custom(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 20),

                // Right side - Time and Distance
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Time
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/clock.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                            AppColors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          estimatedTime,
                          style: AppTextStyles.custom(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Distance
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/bold_location.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(
                            AppColors.textSecondary,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          distance,
                          style: AppTextStyles.custom(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Divider
            Container(
              height: 1,
              color: AppColors.greyLight.withOpacity(0.3),
            ),
            const SizedBox(height: 16),

            // Base Fare
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Base Fare',
                  style: AppTextStyles.custom(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '\$${baseFare.toStringAsFixed(0)}',
                  style: AppTextStyles.custom(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Platform Charges
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Platform Charges',
                  style: AppTextStyles.custom(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  '\$${platformCharges.toStringAsFixed(0)}',
                  style: AppTextStyles.custom(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Divider
            Container(
              height: 1,
              color: AppColors.greyLight.withOpacity(0.3),
            ),
            const SizedBox(height: 12),

            // Approximate Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Approximate Price',
                  style: AppTextStyles.custom(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  '\$${approximatePrice.toStringAsFixed(0)}',
                  style: AppTextStyles.custom(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Cancel Booking Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCancel,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red.withOpacity(0.1),
                  foregroundColor: AppColors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Cancel Booking',
                  style: AppTextStyles.custom(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}