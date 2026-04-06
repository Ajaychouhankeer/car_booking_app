import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../router/app_router.dart';
import 'onboarding_page.dart';

class OnboardingMainScreen extends StatefulWidget {
  const OnboardingMainScreen({super.key});

  @override
  State<OnboardingMainScreen> createState() => _OnboardingMainScreenState();
}

class _OnboardingMainScreenState extends State<OnboardingMainScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  void nextPage() {
    if (currentIndex < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // last page
      NavigationService.pushNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          OnboardingPage(
            image: ImageConstants.familyTripHomeImage,
            title: StringConstants.onlinePayment1,
            subtitle: StringConstants.firstOnlinePayment,
            bgColor: AppColors.lightYellow,
            currentIndex: currentIndex,
            onNext: nextPage,
            topTitle: StringConstants.familyTripTextTop,
          ),

          OnboardingPage(
            image: ImageConstants.darshanTripHomeImage,
            title: StringConstants.onlineShoping2,
            subtitle: StringConstants.onlineShopping,
            bgColor: AppColors.lightYellow,
            currentIndex: currentIndex,
            onNext: nextPage,
            topTitle: StringConstants.darshanTripTextTop,
          ),

          OnboardingPage(
            image: ImageConstants.transportTripHomeImage,
            title: StringConstants.onlineHomeDelivery3,
            subtitle: StringConstants.homeDeliveryService,
            bgColor:  AppColors.lightYellow,
            currentIndex: currentIndex,
            onNext: nextPage,
            topTitle: StringConstants.transportTripTextTop,
          ),
        ],
      ),
    );
  }
}