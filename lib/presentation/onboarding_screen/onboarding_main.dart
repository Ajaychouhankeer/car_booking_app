import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../router/app_router.dart';
import 'onboarding_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OnboardingMainScreen extends StatefulWidget {
  const OnboardingMainScreen({super.key});

  @override
  State<OnboardingMainScreen> createState() =>
      _OnboardingMainScreenState();
}

class _OnboardingMainScreenState
    extends State<OnboardingMainScreen> {
  int currentIndex = 0;

  // void nextPage() {
  //   if (currentIndex < 2) {
  //     setState(() {
  //       currentIndex++;
  //     });
  //   } else {
  //     NavigationService.pushNamed(AppRoutes.login);
  //   }
  // }

  void nextPage() async {
    if (currentIndex < 2) {
      setState(() {
        currentIndex++;
      });
    } else {

      /// 🔥 SAVE FIRST TIME FLAG
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isFirstTime", false);

      /// 🔥 GO TO LOGIN
      NavigationService.pushAndRemoveUntil(AppRoutes.login);
    }
  }

  void previousPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  OnboardingPage _getPage(int index) {
    switch (index) {
      case 0:
        return OnboardingPage(
          key: const ValueKey(0),
          image: ImageConstants.familyTripHomeImage,
          title: StringConstants.onlinePayment1,
          subtitle: StringConstants.firstOnlinePayment,
          bgColor: AppColors.lightYellow,
          currentIndex: currentIndex,
          onNext: nextPage,
          topTitle: StringConstants.familyTripTextTop,
        );

      case 1:
        return OnboardingPage(
          key: const ValueKey(1),
          image: ImageConstants.darshanTripHomeImage,
          title: StringConstants.onlineShoping2,
          subtitle: StringConstants.onlineShopping,
          bgColor: AppColors.lightYellow,
          currentIndex: currentIndex,
          onNext: nextPage,
          topTitle: StringConstants.darshanTripTextTop,
        );

      case 2:
        return OnboardingPage(
          key: const ValueKey(2),
          image: ImageConstants.transportTripHomeImage,
          title: StringConstants.onlineHomeDelivery3,
          subtitle: StringConstants.homeDeliveryService,
          bgColor: AppColors.lightYellow,
          currentIndex: currentIndex,
          onNext: nextPage,
          topTitle: StringConstants.transportTripTextTop,
        );

      default:
        return _getPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            nextPage(); // swipe left
          } else if (details.primaryVelocity! > 0) {
            previousPage(); // swipe right
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: _getPage(currentIndex),
        ),
      ),
    );
  }
}



// class OnboardingMainScreen extends StatefulWidget {
//   const OnboardingMainScreen({super.key});
//
//   @override
//   State<OnboardingMainScreen> createState() => _OnboardingMainScreenState();
// }
//
// class _OnboardingMainScreenState extends State<OnboardingMainScreen> {
//   final PageController _controller = PageController();
//   int currentIndex = 0;
//
//   void nextPage() {
//     if (currentIndex < 2) {
//       _controller.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//     } else {
//       // last page
//       NavigationService.pushNamed(AppRoutes.login);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _controller,
//         onPageChanged: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//         children: [
//           OnboardingPage(
//             image: ImageConstants.familyTripHomeImage,
//             title: StringConstants.onlinePayment1,
//             subtitle: StringConstants.firstOnlinePayment,
//             bgColor: AppColors.lightYellow,
//             currentIndex: currentIndex,
//             onNext: nextPage,
//             topTitle: StringConstants.familyTripTextTop,
//           ),
//
//           OnboardingPage(
//             image: ImageConstants.darshanTripHomeImage,
//             title: StringConstants.onlineShoping2,
//             subtitle: StringConstants.onlineShopping,
//             bgColor: AppColors.lightYellow,
//             currentIndex: currentIndex,
//             onNext: nextPage,
//             topTitle: StringConstants.darshanTripTextTop,
//           ),
//
//           OnboardingPage(
//             image: ImageConstants.transportTripHomeImage,
//             title: StringConstants.onlineHomeDelivery3,
//             subtitle: StringConstants.homeDeliveryService,
//             bgColor:  AppColors.lightYellow,
//             currentIndex: currentIndex,
//             onNext: nextPage,
//             topTitle: StringConstants.transportTripTextTop,
//           ),
//         ],
//       ),
//     );
//   }
// }