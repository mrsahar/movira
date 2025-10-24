import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movira/screens/authentication/profile_completed_screen.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/widgets/my_app_bar.dart';
import 'package:movira/utils/widgets/my_text_box.dart';

class CardAddScreen extends StatefulWidget {
  const CardAddScreen({super.key});

  @override
  State<CardAddScreen> createState() => _CardAddScreenState();
}

class _CardAddScreenState extends State<CardAddScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardHolderNameController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expirationDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardHolderNameController.dispose();
    _cardNumberController.dispose();
    _expirationDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  String _formatCardNumber(String value) {
    // Remove all spaces
    value = value.replaceAll(' ', '');

    // Add space every 4 digits
    String formatted = '';
    for (int i = 0; i < value.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formatted += ' ';
      }
      formatted += value[i];
    }
    return formatted;
  }

  String _formatExpirationDate(String value) {
    // Remove all slashes
    value = value.replaceAll('/', '');

    // Add slash after 2 digits
    if (value.length > 2) {
      return '${value.substring(0, 2)}/${value.substring(2)}';
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MAppBar(
        title: 'Payment Method',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Card Holder Name
                        MTextField(
                          label: 'Card Holder Name',
                          hintText: 'Enter name',
                          iconPath: 'assets/icons/profile.svg',
                          controller: _cardHolderNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter card holder name';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // Card Number
                        MTextField(
                          label: 'Card Number',
                          hintText: 'Enter number',
                          iconPath: 'assets/icons/card.svg',
                          controller: _cardNumberController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter card number';
                            }
                            String cleanValue = value.replaceAll(' ', '');
                            if (cleanValue.length < 16) {
                              return 'Card number must be 16 digits';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // Expiration Date
                        MTextField(
                          label: 'Expiration Date',
                          hintText: 'Enter date',
                          iconPath: 'assets/icons/calendar.svg',
                          controller: _expirationDateController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter expiration date';
                            }
                            if (!value.contains('/') || value.length < 5) {
                              return 'Please enter valid date (MM/YY)';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        // CVV Code
                        MTextField(
                          label: 'CVV Code',
                          hintText: 'Enter number',
                          iconPath: 'assets/icons/pin_code.svg',
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter CVV code';
                            }
                            if (value.length < 3) {
                              return 'CVV must be 3 or 4 digits';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Continue Button - Fixed at bottom
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   // Handle payment method save
                    //   // Get.back();
                    //   // or Get.toNamed(Routes.home);
                    // }
                    Get.to(ProfileCompletedScreen());
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
            ),
          ],
        ),
      ),
    );
  }
}