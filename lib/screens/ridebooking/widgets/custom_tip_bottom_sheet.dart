import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class CustomTipBottomSheet extends StatefulWidget {
  final Function(double) onSubmit;

  const CustomTipBottomSheet({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<CustomTipBottomSheet> createState() => _CustomTipBottomSheetState();
}

class _CustomTipBottomSheetState extends State<CustomTipBottomSheet> {
  final TextEditingController _amountController = TextEditingController();
  double _tipAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _amountController.text = '00.00';
    _tipAmount = 0.0;
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _updateAmount(String value) {
    final amount = double.tryParse(value);
    if (amount != null) {
      setState(() {
        _tipAmount = amount;
      });
    }
  }

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
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 32,
          bottom: MediaQuery.of(context).viewInsets.bottom + 32,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'Custom Tip',
              style: AppTextStyles.custom(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              'Insert the amount you would like to tip.',
              style: AppTextStyles.custom(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Amount Display/Input
            GestureDetector(
              onTap: () {
                // Focus on text field when tapped
                showDialog(
                  context: context,
                  builder: (context) => _buildAmountInputDialog(),
                );
              },
              child: Text(
                '\$${_tipAmount.toStringAsFixed(2)}',
                style: AppTextStyles.custom(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textSecondary,
                  letterSpacing: -1,
                ),
              ),
            ),
            const SizedBox(height: 50),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_tipAmount > 0) {
                    widget.onSubmit(_tipAmount);
                    Navigator.pop(context);
                  }
                },
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
                child: Text(
                  'Submit',
                  style: AppTextStyles.custom(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Bottom indicator
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

  Widget _buildAmountInputDialog() {
    final tempController = TextEditingController(
      text: _tipAmount.toStringAsFixed(2),
    );

    return AlertDialog(
      title: Text(
        'Enter Tip Amount',
        style: AppTextStyles.custom(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: TextField(
        controller: tempController,
        autofocus: true,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        style: AppTextStyles.custom(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixText: '\$',
          prefixStyle: AppTextStyles.custom(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: AppTextStyles.custom(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final amount = double.tryParse(tempController.text);
            if (amount != null && amount > 0) {
              setState(() {
                _tipAmount = amount;
                _amountController.text = amount.toStringAsFixed(2);
              });
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.black,
          ),
          child: const Text('Set'),
        ),
      ],
    );
  }
}