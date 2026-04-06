import 'package:flutter/material.dart';

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

    return BottomNavigationBar(

      currentIndex: currentIndex,
      onTap: onTap,

      type: BottomNavigationBarType.fixed,

      selectedItemColor: Colors.orangeAccent,
      unselectedItemColor: Colors.grey,

      items:  [

        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: StringConstants.home,
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.car_crash_rounded),
          label: StringConstants.vehicles,
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.touch_app_rounded),
          label: StringConstants.bookings,
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: StringConstants.map,
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: StringConstants.profile,
        ),
      ],
    );
  }
}