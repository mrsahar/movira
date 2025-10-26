import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movira/screens/home/history/widget/ride_history_card.dart';
import 'package:movira/screens/messages/notification_screen.dart';
import 'package:movira/screens/ridebooking/ride_booking_screen.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen> {
  bool _isOngoingDeliveryExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          titleSpacing: 16,
          title: GestureDetector(
            onTap: () {
              setState(() {
                _isOngoingDeliveryExpanded = !_isOngoingDeliveryExpanded;
              });
            },
            child: Row(
              children: [
                // Profile Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/user.png',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.person,
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 12),

                // Name and Location
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Jacob Jones',
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            'Naperville, USA',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 4),
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: _isOngoingDeliveryExpanded ? 0.5 : 0,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              size: 18,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // Notification Bell
            Center(
              child: Container(
                height: 35,
                width: 35,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.notifications,
                    color: AppColors.black,
                    size: 18,
                  ),
                  onPressed: () {
                    // Navigate to notifications
                    Get.to(NotificationScreen());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Ongoing Delivery Section (Expandable)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isOngoingDeliveryExpanded ? 110 : 0,
            child: _isOngoingDeliveryExpanded
                ? GestureDetector(
              onTap: () {
                // Navigate to location/tracking screen
                print('Navigate to ongoing delivery details');
              },
              child: Container(
                color: AppColors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  children: [
                    // Header with "Ongoing Delivery" and Time
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping,
                          color: Colors.green.shade400,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Ongoing Delivery',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: Colors.green.shade400,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.access_time,
                          color: AppColors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '12:24',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Pickup and Drop-off Locations
                    Row(
                      children: [
                        // Pickup
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pickup',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.white.withValues(alpha: 0.7),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Lomas de Zamora, Mex...',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Dotted line with arrow
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: AppColors.white.withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              ...List.generate(
                                8,
                                    (index) => Container(
                                  width: 4,
                                  height: 1,
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  color: AppColors.white.withValues(alpha: 0.5),
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.white.withValues(alpha: 0.5),
                                size: 14,
                              ),
                            ],
                          ),
                        ),

                        // Drop-off
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Drop Off',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.white.withValues(alpha: 0.7),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'North Las Vegas (NV), Gua...',
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.white,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                : const SizedBox.shrink(),
          ),

          // Main Content
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Where to? Card
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            image: AssetImage('assets/images/bg_gold.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Title
                              Text(
                                'Where to?',
                                style: AppTextStyles.h3.copyWith(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Location Fields Container
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Left side with icons and line
                                Column(
                                  children: [
                                    Container(
                                      width: 2,
                                      margin: const EdgeInsets.symmetric(vertical: 10),
                                      color: AppColors.transparent,
                                    ),
                                    // Pickup location icon - Using SVG
                                    SvgPicture.asset(
                                      'assets/icons/location.svg',
                                      width: 18,
                                      height: 18,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    // Connecting line
                                    Container(
                                      width: 2,
                                      height: 40,
                                      margin: const EdgeInsets.symmetric(vertical: 12),
                                      color: AppColors.black.withValues(alpha: 0.3),
                                    ),
                                    // Drop-off GPS icon (crosshair)
                                    SvgPicture.asset(
                                      'assets/icons/gps.svg',
                                      width: 18,
                                      height: 18,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.black,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(width: 12),

                                // Right side - Single white container with both fields
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(14),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      children: [
                                        // Pickup Location Field
                                        GestureDetector(
                                          onTap: () {
                                            // Navigate to location picker for pickup
                                            Get.to(RideBookingScreen());
                                            print('Open pickup location picker');
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Choose Pickup Location',
                                                  style: AppTextStyles.bodyMedium.copyWith(
                                                    color: AppColors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                onPressed: () {
                                                  // Navigate to location picker for pickup
                                                  Get.to(RideBookingScreen());
                                                  print('Open pickup location picker');
                                                },
                                                icon: SvgPicture.asset(
                                                  'assets/icons/location_pin.svg',
                                                  width: 18,
                                                  height: 18,
                                                  colorFilter: ColorFilter.mode(
                                                    AppColors.black,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Divider
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Divider(
                                            color: AppColors.greyLight,
                                            height: 1,
                                          ),
                                        ),

                                        // Drop-off Location Field
                                        GestureDetector(
                                          onTap: () {
                                            // Navigate to location picker for drop-off
                                            Get.to(RideBookingScreen());
                                            print('Open drop-off location picker');
                                          },
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Choose Drop-Off Location',
                                                  style: AppTextStyles.bodyMedium.copyWith(
                                                    color: AppColors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                onPressed: () {
                                                  // Navigate to location picker for drop-off
                                                  Get.to(RideBookingScreen());
                                                  print('Open drop-off location picker');
                                                },
                                                icon: SvgPicture.asset(
                                                  'assets/icons/location_pin.svg',
                                                  width: 18,
                                                  height: 18,
                                                  colorFilter: ColorFilter.mode(
                                                    AppColors.black,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),

                              const SizedBox(height: 24),

                              // Book Now Button
                              Center(
                                child: SizedBox(
                                  width: 180,
                                  height: 48,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Navigate to booking
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.black,
                                      foregroundColor: AppColors.primary,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                    ),
                                    child: Text(
                                      'Book Now',
                                      style: AppTextStyles.button.copyWith(
                                        color: AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Recent Activity Title
                      Text(
                        'Recent Activity',
                        style: AppTextStyles.h4.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Recent Activity Card - Using RideHistoryCard widget
                      RideHistoryCard(
                        driverName: 'Marvin McKinney',
                        driverImage: 'assets/images/profile_user.png',
                        driverRating: 4.5,
                        carModel: 'Chevrolet Tornado',
                        carPlate: 'ES-345-IJ5',
                        pickupLocation: 'Lomas de Zamora, Mexico City',
                        dropLocation: 'North Las Vegas (NV), Guanajuato',
                        duration: '30 mins',
                        distance: '14.2 KM',
                        price: '\$120.00',
                        statusText: 'Booked ride to travel.',
                        status: RideStatus.inProgress,
                      ),

                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}