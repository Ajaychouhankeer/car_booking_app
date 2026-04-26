import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:bloc_project_basic/core/themes/app_text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors/colors.dart';
import '../../core/widgets/common_widgets.dart';
import 'onboardingIndegator.dart';


class OnboardingPage extends StatelessWidget {
  final String topTitle;
  final String image;
  final String title;
  final String subtitle;
  final Color bgColor;
  final int currentIndex;
  final VoidCallback onNext;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.currentIndex,
    required this.onNext,
    required this.topTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey(title), // important for animation
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          colors: [
            Color(0xFF1565C0),
            Color(0xFF90CAF9),
          ],
        ),
      ),
      child: Column(
        children: [
          //SizedBox(height: 20.h),
          Spacer(),

          Text(
            topTitle,
            style:
            AppTextStyle.titleStyle18bb.copyWith(color: AppColors.white),
          ),

          CommonWidgets.verticalSpace(height: 10.h),

          /// 🔥 IMAGE ANIMATION
          Expanded(
            flex: 5,
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Image.asset(
                  image,
                  key: ValueKey(image),
                  width: 350.w,
                ),
              ),
            ),
          ),

          Expanded(
            flex: 5,
            child: Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 30),
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
                  /// 🔥 TEXT ANIMATION
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Column(
                      key: ValueKey(title),
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.titleStyle34bb
                              .copyWith(color: AppColors.MainBlueColor),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          subtitle,
                          textAlign: TextAlign.start,
                          style: AppTextStyle.titleStyle16bb
                              .copyWith(color: AppColors.greysMate),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                  const Spacer(),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      OnboardingIndicator(
                        currentIndex: currentIndex,
                        total: 3,
                      ),

                      ElevatedButton(
                        onPressed: onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.MainBlueColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                              vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(30),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          currentIndex == 2
                              ? StringConstants
                              .OnBoardingBtnGetStarted
                              : StringConstants
                              .OnBoardingBtnNext,
                          style: AppTextStyle.titleStyle16bb
                              .copyWith(
                              color: AppColors.white),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
