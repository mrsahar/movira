import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class OtpVerificationBottomSheet extends StatefulWidget {
  final String? email;
  final Function(String)? onVerify;

  const OtpVerificationBottomSheet({
    super.key,
    this.email,
    this.onVerify,
  });

  // Static method to show the bottom sheet
  static void show(
      BuildContext context, {
        String? email,
        Function(String)? onVerify,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (context) => OtpVerificationBottomSheet(
        email: email,
        onVerify: onVerify,
      ),
    );
  }

  @override
  State<OtpVerificationBottomSheet> createState() =>
      _OtpVerificationBottomSheetState();
}

class _OtpVerificationBottomSheetState
    extends State<OtpVerificationBottomSheet> {
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes =
  List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  String _getOtp() {
    return _controllers.map((controller) => controller.text).join();
  }

  bool _isOtpComplete() {
    return _controllers.every((controller) => controller.text.isNotEmpty);
  }

  void _handleVerify() {
    if (_isOtpComplete()) {
      String otp = _getOtp();

      // Call the callback if provided
      if (widget.onVerify != null) {
        widget.onVerify!(otp);
      }

      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'OTP Verified Successfully!',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please enter complete OTP',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.white,
            ),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleResendOtp() {
    // Clear all fields
    for (var controller in _controllers) {
      controller.clear();
    }

    // Focus first field
    _focusNodes[0].requestFocus();

    // Show resend message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'OTP has been resent to ${widget.email ?? "your email"}',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
    );

    // TODO: Call your API to resend OTP
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
            'OTP Verification',
            style: AppTextStyles.h4,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Description
          Text(
            'We\'ve sent an email with an activation code to your email address',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 40),

          // OTP Input Fields
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                width: 60,
                height: 60,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.black,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyLight,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    if (value.isNotEmpty && index < 3) {
                      // Move to next field
                      _focusNodes[index + 1].requestFocus();
                    } else if (value.isEmpty && index > 0) {
                      // Move to previous field on backspace
                      _focusNodes[index - 1].requestFocus();
                    }
                    setState(() {});
                  },
                  onTap: () {
                    // Select all text when tapped
                    _controllers[index].selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: _controllers[index].text.length,
                    );
                  },
                ),
              );
            }),
          ),

          const SizedBox(height: 40),

          // Verify Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _handleVerify,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text(
                'Verify',
                style: AppTextStyles.button,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Resend OTP
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't receive OTP? ",
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              TextButton(
                onPressed: _handleResendOtp,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Resend OTP',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}