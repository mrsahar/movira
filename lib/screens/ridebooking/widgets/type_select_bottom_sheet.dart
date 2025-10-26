import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class TypeSelectionBottomSheet extends StatefulWidget {
  final String? pickupAddress;
  final String? dropOffAddress;
  final VoidCallback onPickupTap;
  final VoidCallback onDropOffTap;
  final VoidCallback onConfirm;

  const TypeSelectionBottomSheet({
    Key? key,
    this.pickupAddress,
    this.dropOffAddress,
    required this.onPickupTap,
    required this.onDropOffTap,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<TypeSelectionBottomSheet> createState() =>
      _TypeSelectionBottomSheetState();
}

class _TypeSelectionBottomSheetState extends State<TypeSelectionBottomSheet> {
  String _selectedType = 'ride'; // 'ride' or 'package'
  String _selectedCar = 'mini'; // 'mini', 'sedan', 'suv'

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              'Pickup & Drop Location',
              style: AppTextStyles.custom(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 16),

            // Location Selection
            _buildLocationSection(),

            const SizedBox(height: 20),

            // Ride/Package Toggle
            _buildTypeToggle(),

            const SizedBox(height: 20),

            // Choose Preference
            Text(
              'Choose Preference',
              style: AppTextStyles.custom(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 12),

            // Car Options
            _buildCarOptions(),

            const SizedBox(height: 20),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onConfirm,
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
                  'Confirm',
                  style: AppTextStyles.custom(
                    fontSize: 16,
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

  Widget _buildLocationSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          // Icons Column
          Column(
            children: [
              SvgPicture.asset(
                'assets/icons/bold_location.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),
              Container(
                width: 2,
                height: 30,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: AppColors.greyLight,
              ),
              SvgPicture.asset(
                'assets/icons/bold_gps.svg',
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),

          // Text Column
          Expanded(
            child: Column(
              children: [
                // Pickup Location
                InkWell(
                  onTap: widget.onPickupTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.pickupAddress ?? 'Choose Pickup Location',
                            style: AppTextStyles.custom(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: widget.pickupAddress != null
                                  ? AppColors.black
                                  : AppColors.textHint,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/location_pin.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Drop-off Location
                InkWell(
                  onTap: widget.onDropOffTap,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.dropOffAddress ??
                                'Choose Drop-Off Location',
                            style: AppTextStyles.custom(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: widget.dropOffAddress != null
                                  ? AppColors.black
                                  : AppColors.textHint,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SvgPicture.asset(
                          'assets/icons/location_pin.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeToggle() {
    return Row(
      children: [
        // Ride Button
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedType = 'ride';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _selectedType == 'ride'
                    ? AppColors.black
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: _selectedType == 'ride'
                      ? AppColors.black
                      : AppColors.greyLight,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/red_car.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Ride',
                    style: AppTextStyles.custom(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selectedType == 'ride'
                          ? AppColors.primary
                          : AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Package Button
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                _selectedType = 'package';
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: _selectedType == 'package'
                    ? AppColors.black
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: _selectedType == 'package'
                      ? AppColors.black
                      : AppColors.greyLight,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/package.svg',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Package',
                    style: AppTextStyles.custom(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _selectedType == 'package'
                          ? AppColors.primary
                          : AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.greyLight,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildCarOption(
            icon: 'assets/icons/min_car.svg',
            name: 'Mini Car',
            price: '\$80.00',
            value: 'mini',
          ),
          const SizedBox(height: 12),
          _buildCarOption(
            icon: 'assets/icons/orange_car.svg',
            name: 'Sedan Car',
            price: '\$100.00',
            value: 'sedan',
          ),
          const SizedBox(height: 12),
          _buildCarOption(
            icon: 'assets/icons/yellow_car.svg',
            name: 'SUV Car',
            price: '\$120.00',
            value: 'suv',
          ),
        ],
      ),
    );
  }

  Widget _buildCarOption({
    required String icon,
    required String name,
    required String price,
    required String value,
  }) {
    final isSelected = _selectedCar == value;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCar = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.background : AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: AppTextStyles.custom(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ),
            Text(
              price,
              style: AppTextStyles.custom(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.black : AppColors.greyLight,
                  width: 2,
                ),
                color: AppColors.white,
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.black,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}