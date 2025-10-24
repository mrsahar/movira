import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movira/screens/authentication/login.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/widgets/my_text_box.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  // Title
                  Text(
                    'Hello! Register to get started',
                    style: AppTextStyles.h4,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Create an account by filling in the information below',
                    style: AppTextStyles.bodyMedium,
                  ),

                  const SizedBox(height: 20),

                  // Email Field
                  MTextField(
                    label: 'Email address',
                    hintText: 'name@example.com',
                    iconPath: 'assets/icons/email.svg',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  MTextField(
                    label: 'Password',
                    hintText: 'Enter password',
                    iconPath: 'assets/icons/lock.svg',
                    isPassword: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Confirm Password Field
                  MTextField(
                    label: 'Confirm Password',
                    hintText: 'Confirm password',
                    iconPath: 'assets/icons/lock.svg',
                    isPassword: true,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 30),

                  // Terms and Conditions Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            children: [
                              const TextSpan(
                                text: 'By signing up, I agree to the ',
                              ),
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to Terms and Conditions
                                    // Get.toNamed(Routes.termsAndConditions);
                                  },
                              ),
                              const TextSpan(
                                text: ' and ',
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigate to Privacy Policy
                                    // Get.toNamed(Routes.privacyPolicy);
                                  },
                              ),
                              const TextSpan(
                                text: '.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Signup Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (!_agreeToTerms) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please agree to Terms and Conditions',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          // Handle signup
                          // Get.toNamed(Routes.home);
                        }
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
                        'Signup',
                        style: AppTextStyles.button,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Login Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to login
                             Get.back();
                            //Get.to(LoginScreen());
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Login',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}