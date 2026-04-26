import 'package:bloc_project_basic/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  const CommonSearchBar({
    super.key,
    this.hintText = "Search...",
    this.controller,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // ✅ Responsive width (mobile, tablet, desktop)
    double maxWidth;
    if (screenWidth < 600) {
      maxWidth = screenWidth; // mobile
    } else if (screenWidth < 1024) {
      maxWidth = 500; // tablet
    } else {
      maxWidth = 600; // desktop
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          height: 50.h.clamp(45, 60), // ✅ responsive height limit
          padding: EdgeInsets.symmetric(horizontal: 10.w),

          decoration: BoxDecoration(
            color: AppColors.lightDarkCardColor,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: AppColors.lightDarkBorderColor,
              width: 1,
            ),
          ),

          child: Row(
            children: [

              /// 🔍 Icon
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20.sp.clamp(18, 24),
                ),
              ),

              /// ✍️ TextField
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  onTap: onTap,
                  style: TextStyle(fontSize: 14.sp),

                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.sp,
                    ),

                    border: InputBorder.none,
                    isDense: true, // ✅ compact

                    contentPadding: EdgeInsets.symmetric(
                      vertical: 12.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
