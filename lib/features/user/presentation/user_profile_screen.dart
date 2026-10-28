import 'package:flutter/material.dart';
import 'user_center_screen.dart';

class UserProfileScreen extends StatelessWidget {
  final int userId;
  const UserProfileScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return UserCenterScreen(userId: userId);
  }
}
