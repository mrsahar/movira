import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movira/screens/ridebooking/widgets/custom_tip_bottom_sheet.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class DestinationReachedBottomSheet extends StatefulWidget {
  final String driverName;
  final String driverImage;
  final double rating;
  final String carModel;
  final String carPlate;
  final double approximatePrice;
  final VoidCallback onRateExperience;

  const DestinationReachedBottomSheet({
    Key? key,
    required this.driverName,
    required this.driverImage,
    required this.rating,
    required this.carModel,
    required this.carPlate,
    required this.approximatePrice,
    required this.onRateExperience,
  }) : super(key: key);

  @override
  State<DestinationReachedBottomSheet> createState() =>
      _DestinationReachedBottomSheetState();
}

class _DestinationReachedBottomSheetState
    extends State<DestinationReachedBottomSheet> {
  double _selectedTip = 0;
  bool _isCustomTip = false;
  final TextEditingController _customTipController = TextEditingController();

  @override
  void dispose() {
    _customTipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = widget.approximatePrice + _selectedTip;

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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              'Destination Reached',
              style: AppTextStyles.custom(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Driver Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Driver Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.driverImage,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Driver Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.driverName,
                          style: AppTextStyles.custom(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: AppColors.primary,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.rating.toString(),
                              style: AppTextStyles.custom(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Car Details
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.carModel,
                        style: AppTextStyles.custom(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.carPlate,
                        style: AppTextStyles.custom(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Booked Ride Info
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Add Tip Section
            Row(
              children: [
                Text(
                  'Add Tip:',
                  style: AppTextStyles.custom(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(width: 8),
                _buildTipButton('\$5', 5),
                const SizedBox(width: 8),
                _buildTipButton('\$10', 10),
                const SizedBox(width: 8),
                _buildTipButton('\$15', 15),
                const SizedBox(width: 8),
                _buildCustomTipButton(),
              ],
            ),
            const SizedBox(height: 20),

            // Approximate Price with Checkmark
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Approximate price',
                  style: AppTextStyles.custom(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$${totalPrice.toStringAsFixed(0)}',
                      style: AppTextStyles.custom(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Rate Your Experience Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onRateExperience,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.background,
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
                    Text(
                      'Rate Your Experience',
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
          ],
        ),
      ),
    );
  }

  Widget _buildTipButton(String label, double amount) {
    final isSelected = _selectedTip == amount && !_isCustomTip;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTip = amount;
            _isCustomTip = false;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.black : AppColors.greyLight,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: AppTextStyles.custom(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTipButton() {
    final isSelected = _isCustomTip;

    return Expanded(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => CustomTipBottomSheet(
              onSubmit: (amount) {
                setState(() {
                  _selectedTip = amount;
                  _isCustomTip = true;
                });
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.black : AppColors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected ? AppColors.black : AppColors.greyLight,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              '+ Custom',
              style: AppTextStyles.custom(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? AppColors.white : AppColors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

}