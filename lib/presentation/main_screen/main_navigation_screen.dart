import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bottom_nav/bottom_nav_bloc.dart';
import '../../logic/bottom_nav/bottom_nav_event.dart';
import '../../logic/bottom_nav/bottom_nav_state.dart';
import '../cart_screen/cart_screen.dart';
import '../home_screen/bottom_navbar_widget.dart';
import '../home_screen/home_screen.dart';
import '../message_screen/message_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../vehicles_screen/vehicles_screen.dart';


class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final pages = [
      const HomeScreen(),
      const VehiclesScreen(),
      const MessageScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(

      body: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.currentIndex,
            children: pages,
          );
        },
      ),

      bottomNavigationBar: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {

          return BottomNavbarWidget(
            currentIndex: state!.currentIndex,
            onTap: (index) {
              context.read<BottomNavBloc>().add(ChangeTabEvent(index));
            },
          );

        },
      ),
    );
  }
}