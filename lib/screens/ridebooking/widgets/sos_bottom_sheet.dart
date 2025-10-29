import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movira/utils/constants/colors.dart'; 
import 'package:movira/utils/text_style.dart';

class SosBottomSheet extends StatelessWidget {
  final VoidCallback onCall911;
  final VoidCallback onShareLocation;
  final VoidCallback onAlertSupport;

  const SosBottomSheet({
    Key? key,
    required this.onCall911,
    required this.onShareLocation,
    required this.onAlertSupport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SOS Icon with coordinates
            Column(
              children: [
                // SOS Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppColors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Animated rings
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.red.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                      ),
                      // SOS Icon
                      SvgPicture.asset(
                        'assets/icons/sos.svg',
                        width: 40,
                        height: 40,
                        colorFilter: const ColorFilter.mode(
                          AppColors.red,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Coordinates
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '43.7 × 45.64',
                    style: AppTextStyles.custom(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Title
            Text(
              'Emergency SOS',
              style: AppTextStyles.custom(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Choose this emergency services option for\nimmediate help',
              style: AppTextStyles.custom(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),

            // Call 911 Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCall911,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/call.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Call 911',
                      style: AppTextStyles.custom(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Share Live Location Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onShareLocation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/map_push_pin.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Share live location',
                      style: AppTextStyles.custom(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Alert Movira Support Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAlertSupport,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/group_help.svg',
                      width: 20,
                      height: 20,
                      colorFilter: const ColorFilter.mode(
                        AppColors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Alert movira support',
                      style: AppTextStyles.custom(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bottom indicator (optional drag handle)
            Container(
              width: 120,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}