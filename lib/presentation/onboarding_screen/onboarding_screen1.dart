import 'package:bloc_project_basic/core/colors/colors.dart';
import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:bloc_project_basic/core/navigations/navigation_service.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/icons_constant.dart';
import '../../core/constants/image_constant.dart';
import '../../core/widgets/common_widgets.dart';
import 'onboardingIndegator.dart';

class OnboardingScreen1 extends StatelessWidget {
  const OnboardingScreen1({super.key});


  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Scaffold(
      backgroundColor: AppColors.lightYellow,
      body: Column(
        children: [

         const Spacer(),

          Expanded(
            flex: 5,
            child: Center(
              child: Image.asset(ImageConstants.familyTripHomeImage,width: 400,)
            ),
            ),

          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                // boxShadow: [
                //   BoxShadow(
                //     color: AppColors.black87,
                //     blurRadius: 20,
                //     spreadRadius: 1,
                //     offset: Offset(0, -5), // 👈 TOP shadow
                //   ),
                // ],
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    StringConstants.onlinePayment1,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,

                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    StringConstants.firstOnlinePayment,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  CommonWidgets.verticalSpace(height: 150),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      OnboardingIndicator(
                        currentIndex: currentIndex,
                        total: 3,
                      ),

                      GestureDetector(
                        onTap: () {
                          NavigationService.pushNamed(AppRoutes.onboarding2);
                        },
                        child: Image.asset(
                          ImageConstants.nextArrow,
                          width: 60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

