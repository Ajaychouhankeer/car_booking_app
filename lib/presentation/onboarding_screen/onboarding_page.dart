import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
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
    //  color: bgColor,
        decoration: BoxDecoration(
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

          const Spacer(),
          Text(
            topTitle,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white, // gradient pe acha lagega
            ),
          ),


          const SizedBox(height: 10),

          Expanded(
            flex: 5,
            child: Center(
              child: Image.asset(image, width: 400),
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

                  Text(
                    title,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    subtitle,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
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

                      ElevatedButton(
                        onPressed: onNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.MainBlueColor,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          currentIndex == 2 ? "Get Started" : "Next",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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