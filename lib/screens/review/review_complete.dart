import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movira/screens/home/main_screen.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class RatingSubmittedScreen extends StatelessWidget {
  const RatingSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),

                // Title
                Text(
                  'Rating Submitted',
                  style: AppTextStyles.h3,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Rating and review submitted successfully. Thank you for your feedback!',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const Spacer(),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to home screen
                      // Get.offAllNamed(Routes.home);
                      Get.off(MainNavigationScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: AppTextStyles.button,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}