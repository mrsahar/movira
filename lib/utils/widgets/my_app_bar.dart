import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movira/utils/constants/colors.dart';
import 'package:movira/utils/text_style.dart';

class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showBackButton;

  const MAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      centerTitle: true,
      leading: showBackButton
          ? IconButton(
        icon: SvgPicture.asset(
          'assets/icons/arrow_back.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(
            AppColors.black,
            BlendMode.srcIn,
          ),
        ),
        onPressed: onBackPressed ?? () => Navigator.pop(context),
      )
          : null,
      title: Text(
        title,
        style: AppTextStyles.h4,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}