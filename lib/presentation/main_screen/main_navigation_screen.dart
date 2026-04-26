import 'package:bloc_project_basic/presentation/booking_history_screen/booking_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bottom_nav/bottom_nav_bloc.dart';
import '../../logic/bottom_nav/bottom_nav_event.dart';
import '../../logic/bottom_nav/bottom_nav_state.dart';
import '../../logic/distance_bloc/distance_bloc.dart';
import '../cart_screen/cart_screen.dart';
import '../home_screen/bottom_navbar_widget.dart';
import '../home_screen/home_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../vehicles_screen/vehicles_screen.dart';


class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;
  const MainNavigationScreen({super.key, this.initialIndex = 0});


  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();

}

class _MainNavigationScreenState extends State<MainNavigationScreen> {

  @override
  void initState() {
    super.initState();

    /// 👇 YE YAHI ADD KARNA HAI
    context.read<BottomNavBloc>().add(
      ResetTabEvent(widget.initialIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const VehiclesScreen(),
      const BookingHistoryScreen(),
      const DistanceScreen(),
      const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async {
        final bloc = context.read<BottomNavBloc>();

        if (bloc.state.history.length > 1) {
          bloc.add(BackTabEvent());
          return false;
        }

        return true; // exit app
      },
      child: Scaffold(

        body: BlocListener<BottomNavBloc, BottomNavState>(
          listener: (context, state) {

            if (state.currentIndex != 3) { // 👈 DistanceScreen index
            }
          },
          child: BlocBuilder<BottomNavBloc, BottomNavState>(
            builder: (context, state) {
              return IndexedStack(
                index: state.currentIndex,
                children: pages,
              );
            },
          ),
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
      ),
    );
  }
}