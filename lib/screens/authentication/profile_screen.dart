import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movira/screens/payment/card_add_screen.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/widgets/my_app_bar.dart';
import 'package:movira/utils/widgets/my_text_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileController = TextEditingController();

  String? _selectedCountry;
  String? _selectedGender;

  final List<String> _countries = [
    'United States',
    'United Kingdom',
    'Canada',
    'Australia',
    'India',
    'Pakistan',
  ];

  final List<String> _genders = [
    'Male',
    'Female',
    'Other',
  ];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Country',
                style: AppTextStyles.h4,
              ),
              const SizedBox(height: 20),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _countries.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        _countries[index],
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedCountry = _countries[index];
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showGenderPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Gender',
                style: AppTextStyles.h4,
              ),
              const SizedBox(height: 20),
              ...List.generate(
                _genders.length,
                    (index) => ListTile(
                  title: Text(
                    _genders[index],
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _selectedGender = _genders[index];
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MAppBar(
        title: 'Complete Your Profile',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // Profile Picture
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/profile.svg',
                            width: 60,
                            height: 60,
                            colorFilter: ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            // Handle image picker
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/icons/plus.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.black,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // First Name
                  MTextField(
                    label: 'First Name',
                    hintText: 'Enter first name',
                    iconPath: 'assets/icons/profile.svg',
                    controller: _firstNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Last Name
                  MTextField(
                    label: 'Last Name',
                    hintText: 'Enter last name',
                    iconPath: 'assets/icons/profile.svg',
                    controller: _lastNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Country Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Country',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _showCountryPicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColors.greyLight,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/global.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.textSecondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  _selectedCountry ?? 'Select country',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: _selectedCountry != null
                                        ? AppColors.black
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/arrow_down.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.textSecondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Mobile Number
                  MTextField(
                    label: 'Mobile Number',
                    hintText: 'Enter number',
                    iconPath: 'assets/icons/call.svg',
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Gender Dropdown
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: _showGenderPicker,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColors.greyLight,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/gender.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.textSecondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  _selectedGender ?? 'Select gender',
                                  style: AppTextStyles.bodyMedium.copyWith(
                                    color: _selectedGender != null
                                        ? AppColors.black
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/arrow_down.svg',
                                width: 20,
                                height: 20,
                                colorFilter: ColorFilter.mode(
                                  AppColors.textSecondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // Continue Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // if (_formKey.currentState!.validate()) {
                        //   if (_selectedCountry == null) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(
                        //           'Please select a country',
                        //           style: AppTextStyles.bodyMedium.copyWith(
                        //             color: AppColors.white,
                        //           ),
                        //         ),
                        //         backgroundColor: Colors.red,
                        //       ),
                        //     );
                        //     return;
                        //   }
                        //   if (_selectedGender == null) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //         content: Text(
                        //           'Please select a gender',
                        //           style: AppTextStyles.bodyMedium.copyWith(
                        //             color: AppColors.white,
                        //           ),
                        //         ),
                        //         backgroundColor: Colors.red,
                        //       ),
                        //     );
                        //     return;
                        //   }
                        //   // Handle continue
                        //   Get.to(CardAddScreen());
                        // }
                        Get.to(CardAddScreen());
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