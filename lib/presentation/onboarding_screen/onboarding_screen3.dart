import 'package:flutter/material.dart';
import 'package:bloc_project_basic/core/navigations/navigation_service.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/widgets/common_widgets.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightYellow,
      body: Column(
        children: [

          const Spacer(),
          Expanded(
            flex: 5,
            child: Center(
              child: Text('Heelo')
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
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    StringConstants.onlineHomeDelivery3,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    StringConstants.homeDeliveryService,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 20),

                  CommonWidgets.verticalSpace(height: 150),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      Image.asset(ImageConstants.skipTextIcon),

                      GestureDetector(
                        onTap: () {
                          NavigationService.pushNamed(AppRoutes.login);
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