import 'package:flutter/material.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/widgets/my_text_box.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  final Function(String)? onReset;

  const ChangePasswordBottomSheet({
    super.key,
    this.onReset,
  });

  // Static method to show the bottom sheet
  static void show(
      BuildContext context, {
        Function(String)? onReset,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChangePasswordBottomSheet(
        onReset: onReset,
      ),
    );
  }

  @override
  State<ChangePasswordBottomSheet> createState() =>
      _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleReset() {
    if (_formKey.currentState!.validate()) {
      String password = _passwordController.text;

      // Call the callback if provided
      if (widget.onReset != null) {
        widget.onReset!(password);
      }

      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password changed successfully!',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Drag Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.greyLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              'Change Password',
              style: AppTextStyles.h4,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              'Please create a new, secure password below',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

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

            const SizedBox(height: 24),

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

            const SizedBox(height: 32),

            // Reset Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _handleReset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  'Reset',
                  style: AppTextStyles.button,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}