import 'package:flutter/material.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notification data
    final List<Map<String, dynamic>> notifications = [
      {
        'type': 'accepted',
        'title': 'Requested Accepted !',
        'description': 'Driver Martin Guptal have accepted your request',
        'time': '2 min ago',
        'hasImage': true,
        'image': 'assets/images/profile_user.png',
        'icon': Icons.check,
        'iconColor': Colors.green,
      },
      {
        'type': 'reached',
        'title': 'Driver Reached',
        'description': 'Driver Martin Guptal have reached your location',
        'time': '6 min ago',
        'hasImage': true,
        'image': 'assets/images/profile_user.png',
        'icon': Icons.location_on,
        'iconColor': AppColors.primary,
      },
      {
        'type': 'completed',
        'title': 'Ride Completed',
        'description': 'Your Ride has been Completed',
        'time': '8 min ago',
        'hasImage': false,
        'emoji': '🚗',
        'icon': Icons.check_circle,
        'iconColor': AppColors.black,
      },
      {
        'type': 'payment',
        'title': 'Ride Completed',
        'description': 'Your Payment \$543 has been Done',
        'time': '8 min ago',
        'hasImage': false,
        'emoji': '💰',
        'icon': Icons.attach_money,
        'iconColor': AppColors.black,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.black,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notification',
          style: AppTextStyles.h3.copyWith(
            fontSize: 18,
          ),
        ),
        centerTitle: true,
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
        child: ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildNotificationCard(notification),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notification) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar/Icon Section
          Stack(
            children: [
              // Main avatar or emoji circle
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: notification['hasImage']
                      ? Colors.transparent
                      : AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: notification['hasImage']
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    notification['image'],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.greyLight,
                        child: Icon(
                          Icons.person,
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                )
                    : Center(
                  child: Text(
                    notification['emoji'],
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),
              // Status icon badge
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: notification['iconColor'],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    notification['icon'],
                    size: 12,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 12),

          // Content Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'],
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      notification['time'],
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Description
                _buildDescriptionText(notification['description']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionText(String description) {
    // Split text to find bold parts (names or amounts)
    final RegExp exp = RegExp(r'(Martin Guptal|\$\d+)');
    final matches = exp.allMatches(description);

    if (matches.isEmpty) {
      return Text(
        description,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          fontSize: 13,
          height: 1.4,
        ),
      );
    }

    List<TextSpan> spans = [];
    int currentPosition = 0;

    for (final match in matches) {
      // Add text before match
      if (match.start > currentPosition) {
        spans.add(
          TextSpan(
            text: description.substring(currentPosition, match.start),
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        );
      }

      // Add matched text (bold)
      spans.add(
        TextSpan(
          text: match.group(0),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      );

      currentPosition = match.end;
    }

    // Add remaining text
    if (currentPosition < description.length) {
      spans.add(
        TextSpan(
          text: description.substring(currentPosition),
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      );
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}