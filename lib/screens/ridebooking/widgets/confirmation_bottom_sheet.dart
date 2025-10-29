import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  final String pickupAddress;
  final String dropOffAddress;
  final String carType;
  final double baseFare;
  final double platformCharges;
  final VoidCallback onConfirm;

  const ConfirmationBottomSheet({
    Key? key,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.carType,
    required this.baseFare,
    required this.platformCharges,
    required this.onConfirm,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with car icon and title
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/gray_car.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Booked ride to travel.',
                    style: AppTextStyles.custom(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(height: 12),

            // Drop-off Location
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
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
            const SizedBox(height: 16),

            // Payment Through
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment Through',
                  style: AppTextStyles.custom(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                        'assets/images/master.png', width: 24, height: 24),
                    const SizedBox(width: 8),
                    Text(
                      'Card',
                      style: AppTextStyles.custom(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

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
            const SizedBox(height: 16),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onConfirm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Confirm',
                  style: AppTextStyles.custom(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
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