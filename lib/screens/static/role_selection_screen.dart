import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movira/screens/authentication/login.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole; // 'rider' or 'driver'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),

              // Title
              Text(
                'Choose your role',
                style: AppTextStyles.h1,
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                'Lorem ipsum dolor sit amet consectetur. Dictum in in mauris congue ac. Tellus consectetur arcu eget.',
                style: AppTextStyles.bodyMedium.copyWith(height: 1.5),
              ),

              const SizedBox(height: 40),

              // Role Selection
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Rider Option
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedRole = 'rider';
                            });
                            // Navigate to rider screen
                            // Get.toNamed(Routes.riderHome);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/select_rider.png',
                                width: double.infinity,
                                fit: BoxFit.contain,
                              ),
                              // Text overlay
                              Text(
                                'Rider',
                                style: AppTextStyles.h1.copyWith(
                                  color: AppColors.primary,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(alpha: 0.5),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Transform.translate(
                          offset: const Offset(0, -8),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedRole = 'driver';
                              });
                              // Navigate to driver screen
                              Get.to(LoginScreen());
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/select_driver.png',
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                                // Text overlay
                                Text(
                                  'Driver',
                                  style: AppTextStyles.h1.copyWith(
                                    color: AppColors.white,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withValues(alpha: 0.5),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    // OR Badge
                    Positioned(
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'OR',
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Continue Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedRole != null
                      ? () {
                    // Navigate based on selected role
                    if (_selectedRole == 'rider') {
                      Get.to(LoginScreen());
                    } else {
                      Get.to(LoginScreen());
                    }
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedRole != null
                        ? AppColors.primary
                        : AppColors.greyLight,
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
    );
  }
}