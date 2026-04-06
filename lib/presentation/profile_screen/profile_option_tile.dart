import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/colors/colors.dart';
import '../../../core/themes/app_text_style.dart';
import '../../logic/profile_bloc/profile_bloc.dart';
import '../../logic/profile_bloc/profile_event.dart';
import '../../logic/profile_bloc/profile_state.dart';

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final ProfileOptionAction action;
  final bool isLogout;

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.action,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProfileBloc>().add(ProfileOptionTapped(action));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isLogout ? Colors.red : AppColors.lightDarkWhiteColor,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.titleStyleLB14bb.copyWith(
                  color: isLogout ? Colors.red : null,
                ),
              ),
            ),
            if (!isLogout)
              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey)
          ],
        ),
      ),
    );
  }
}