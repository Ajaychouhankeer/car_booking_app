import 'package:bloc_project_basic/core/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../core/constants/string_constants.dart';


import 'package:flutter/material.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/string_constants.dart';

class BottomNavbarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavbarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        bottom: 12,
      ),

      decoration: BoxDecoration(
        color: AppColors.bottomBarColor,

        // 🔥 TOP ROUND CORNERS (PRO LOOK)
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),

        // 🔥 BORDER STYLE (center bold, sides thin feel)
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),

        // 🔥 SHADOW (floating effect)
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, -2),
          ),
        ],
      ),

      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),

        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,

          currentIndex: currentIndex,
          onTap: onTap,

          type: BottomNavigationBarType.fixed,

          selectedItemColor: AppColors.MainBlueColor,
          unselectedItemColor: AppColors.bottomBarIconColor,

          showSelectedLabels: true,
          showUnselectedLabels: true,

          selectedFontSize: 12,
          unselectedFontSize: 11,

          elevation: 0,

          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: StringConstants.home,
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.car_crash_rounded),
              label: StringConstants.vehicles,
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.touch_app_rounded),
              label: StringConstants.bookings,
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.shopping_cart),
              label: StringConstants.map,
            ),

            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: StringConstants.profile,
            ),
          ],
        ),
      ),
    );
  }
}

// class BottomNavbarWidget extends StatelessWidget {
//
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const BottomNavbarWidget({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BottomNavigationBar(
//       backgroundColor: AppColors.bottomBarColor,
//
//       currentIndex: currentIndex,
//       onTap: onTap,
//
//       type: BottomNavigationBarType.fixed,
//
//       selectedItemColor: AppColors.MainBlueColor,
//       unselectedItemColor: AppColors.bottomBarIconColor,
//
//       items:  [
//
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: StringConstants.home,
//         ),
//
//         BottomNavigationBarItem(
//           icon: Icon(Icons.car_crash_rounded),
//           label: StringConstants.vehicles,
//         ),
//
//         BottomNavigationBarItem(
//           icon: Icon(Icons.touch_app_rounded),
//           label: StringConstants.bookings,
//         ),
//
//         BottomNavigationBarItem(
//           icon: Icon(Icons.shopping_cart),
//           label: StringConstants.map,
//         ),
//
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: StringConstants.profile,
//         ),
//       ],
//     );
//   }
// }