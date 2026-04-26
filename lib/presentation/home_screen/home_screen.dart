import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:bloc_project_basic/presentation/home_screen/vehical_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/profile_bloc/profile_bloc.dart';
import '../../logic/profile_bloc/profile_state.dart';
import 'annimation_tours.dart';
import 'banner_slider.dart';
import 'category_list_widget.dart';
import 'home_vehicle_section.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {


    List<String> categories = [
      "Family Trip",
      "Darshan",
      "One Way Trip",
      "Airport Transfer",
      "Tourist Trip",
      "Business Trip",
      "Wedding Trip ",
      "Transport Service"
    ];

    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        titleColor: AppColors.blue,
          titleWidget: Image.asset(
            ImageConstants.logoName,
            height: 40,
          ),
        wantBackButton: false
      ),

      /// Body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {

                  String name = "User";

                  if (state is ProfileLoaded) {
                    name = state.profile.data?.name ?? "User";
                  }

                  return Text(
                    "Welcome, $name 👋",
                    style: AppTextStyle.titleStyleLB18bb,
                  );
                },
              ),

              SizedBox(height: 5.h),

              Text(
                StringConstants.BookyourNextTripWithUs,
                style: AppTextStyle.titleStyleLB24bb,
              ),

              SizedBox(height: 15.h),

             SizedBox(height: 10.h),

              SizedBox(
                height: 410.h,
                width: double.infinity,
                child: Column(
                  children: [

                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: PageView(
                          controller: _pageController,
                          children: [
                            Image.asset(ImageConstants.saleImg, fit: BoxFit.cover),
                            Image.asset(ImageConstants.saleImg, fit: BoxFit.cover),
                            Image.asset(ImageConstants.saleImg, fit: BoxFit.cover),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    /// Dots Indicator
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: AppColors.MainBlueColor,
                        dotColor: Colors.grey,
                        dotHeight: 8,
                        dotWidth: 8,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),

              // CategoryListWidget(),
              /// Vehicle Title
              Text(
                StringConstants.popularDarshanTrip,
                style: AppTextStyle.titleStyleLB18bb,
              ),
              SizedBox(height:  10.h),

              BannerSlider(),

              SizedBox(height: 15.h),

              Text(
                "Explore Tours",
                style: AppTextStyle.titleStyleLB18bb,
              ),

              const SizedBox(height: 10),

              const AnimatedTourSection(),
              SizedBox(height: 25.h),

              HomeVehicleSection(),
            ],
          ),
        ),
      ),
    );
  }
}
