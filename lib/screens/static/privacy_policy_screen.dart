import 'package:flutter/material.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:movira/utils/widgets/my_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MAppBar(
        title: 'Privacy Policy',
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
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1
                  Text(
                    'Lorem ipsum dolor sit amet consectetur.',
                    style: AppTextStyles.h4.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Tristique sollicitudin dictum lacinia tristique rhoncus adipiscing. Diam facilisis sed pharetra ormet et risus. Laoreet pulvinar id duis nunc in ac eget morbi elit. Cum tincidunt donec nulla orci volutpat. Orci convallis sit massa eget. Massa amet nam purus egestas cursus nunc. Mauris risus turpis cursibtur mi hendrerit faucibus pharetra pharetra. Faucibus quis aliquam mattis mattis vel. Commodo tristique ultricies commodo proin mollit orci sollicitudin convallis nam.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      height: 1.6,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Cras sed sit tristique sed nunc ultrices amet. Neque fermentum ullamcorper sed non ut rutrum. Lorem tellus nam ultrices sed vitae sodales dui neque. Consectetur natoque ut diam tortor venenatis pretium. Bibendum massa felis arcu nam. Nulla nibh malesuada adipiscing ac tellus nunc malesuada. Eget mattis pharetra nibh at eras. Pellentesque habitant venenatis at tristique.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      height: 1.6,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Section 2
                  Text(
                    'Lorem ipsum dolor sit amet consectetur.',
                    style: AppTextStyles.h4.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Tristique sollicitudin dictum lacinia tristique rhoncus adipiscing. Diam facilisis sed pharetra ormet et risus. Laoreet pulvinar id duis nunc in ac eget morbi elit. Cum tincidunt donec nulla orci volutpat. Orci convallis sit massa eget. Massa amet nam purus egestas cursus nunc. Mauris risus turpis cursibtur mi hendrerit faucibus pharetra pharetra. Faucibus quis aliquam mattis mattis vel. Commodo tristique ultricies commodo proin mollit orci sollicitudin convallis nam.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      height: 1.6,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Cras sed sit tristique sed nunc ultrices amet. Neque fermentum ullamcorper sed non ut rutrum. Lorem tellus nam ultrices sed vitae sodales dui neque. Consectetur natoque ut diam tortor venenatis pretium. Bibendum massa felis arcu nam. Nulla nibh malesuada adipiscing ac tellus nunc malesuada. Eget mattis pharetra nibh at eras. Pellentesque habitant venenatis at tristique.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      height: 1.6,
                      color: AppColors.textSecondary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    'Fringilla cursus lacinia purus dictus a. Mi gravida mattis in vel nibh. Est dui sit volutpat semper arci lectus. Aliquam scelerisque nunc proin molestie velit felis parturient turpis scelerisque.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      height: 1.6,
                      color: AppColors.textSecondary,
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