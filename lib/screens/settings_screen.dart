import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/widgets/my_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MAppBar(
        title: 'Settings',
        showBackButton: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 8),

                // Profile Card
                _buildProfileCard(
                  profileImage: 'assets/images/profile_user.png', // Add your profile image
                  name: 'Brooklyn Simmons',
                  email: 'nathan.roberts@example.com',
                  onTap: () {
                    // Navigate to profile edit
                    // Get.toNamed(Routes.editProfile);
                  },
                ),

                const SizedBox(height: 16),

                // Become a Driver
                _buildSettingTile(
                  icon: 'assets/icons/app_icon.png',
                  title: 'Become a Driver',
                  isPng: true,
                  onTap: () {
                    // Navigate to become driver
                  },
                ),

                const SizedBox(height: 16),

                // Rate Us
                _buildSettingTile(
                  icon: 'assets/icons/star.svg',
                  title: 'Rate Us',
                  onTap: () {
                    // Open app store rating
                  },
                ),

                const SizedBox(height: 16),

                // Contact Us
                _buildSettingTile(
                  icon: 'assets/icons/call.svg',
                  title: 'Contact Us',
                  onTap: () {
                    // Navigate to contact us
                  },
                ),

                const SizedBox(height: 16),

                // Reset Password
                _buildSettingTile(
                  icon: 'assets/icons/lock.svg',
                  title: 'Reset Password',
                  onTap: () {
                    // Show change password bottom sheet
                    // ChangePasswordBottomSheet.show(context);
                  },
                ),

                const SizedBox(height: 16),

                // Payment Method
                _buildSettingTile(
                  icon: 'assets/icons/card.svg',
                  title: 'Payment Method',
                  onTap: () {
                    // Navigate to payment method
                    // Get.toNamed(Routes.paymentMethod);
                  },
                ),

                const SizedBox(height: 16),

                // Privacy Policy
                _buildSettingTile(
                  icon: 'assets/icons/info.svg',
                  title: 'Privacy Policy',
                  onTap: () {
                    // Navigate to privacy policy
                  },
                ),

                const SizedBox(height: 16),

                // Terms & Conditions
                _buildSettingTile(
                  icon: 'assets/icons/document.svg',
                  title: 'Terms & Conditions',
                  onTap: () {
                    // Navigate to terms
                  },
                ),

                const SizedBox(height: 16),

                // Delete Account
                _buildSettingTile(
                  icon: 'assets/icons/trash.svg',
                  title: 'Delete Account',
                  onTap: () {
                    // Show delete confirmation dialog
                    //_showDeleteAccountDialog(context);
                  },
                ),

                const SizedBox(height: 24),

                // Logout Button
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.red.withValues(alpha: 0.15), // Light peachy/pink background
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.red, // Coral red border
                      width: 2,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Show logout confirmation
                      _showLogoutDialog(context);
                    },
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Logout',
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.red, // Coral red text
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard({
    required String profileImage,
    required String name,
    required String email,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(profileImage),
              backgroundColor: AppColors.greyLight,
            ),

            const SizedBox(width: 16),

            // Name and Email
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.h4.copyWith(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: AppColors.black,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool isPng = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              child: isPng
                  ? Image.asset(
                icon,
                width: 24,
                height: 24,
              )
                  : SvgPicture.asset(
                icon,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  AppColors.black,
                  BlendMode.srcIn,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Title
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // Arrow Icon
            Icon(
              Icons.chevron_right,
              color: AppColors.black,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Logout',
          style: AppTextStyles.h4,
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle logout
              // Get.offAllNamed(Routes.login);
            },
            child: Text(
              'Logout',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }}