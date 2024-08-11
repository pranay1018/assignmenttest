import 'package:assignmenttest/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogoutPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onLogoutPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyColors.primary,
      leading: const Padding(
        padding: EdgeInsets.all(MySizes.md),
        child: Icon(Icons.person, color: MyColors.secondary),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: MyColors.secondary),
          onPressed: onLogoutPressed,
        ),
      ],
    );
  }
}
