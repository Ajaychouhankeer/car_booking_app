import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:bloc_project_basic/core/navigations/navigation_service.dart';
import 'package:bloc_project_basic/core/themes/app_text_style.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/colors.dart';
import '../../logic/banners/banner_bloc.dart';
import '../../logic/banners/banner_event.dart';
import '../../logic/banners/banner_state.dart';

import 'dart:async';

import 'package:bloc_project_basic/core/themes/app_text_style.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/colors/colors.dart';
import '../../logic/banners/banner_bloc.dart';
import '../../logic/banners/banner_state.dart';
import 'full_screen_banner.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {

  late PageController _controller;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    // 🔥 start from middle for smooth infinite
    _controller = PageController(initialPage: 1000);
    _currentPage = 1000;
  }

  void startAutoScroll(int itemCount) {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      _currentPage++;

      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  void stopAutoScroll() {
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerBloc, BannerState>(
      builder: (context, state) {

        if (state is BannerLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BannerLoaded) {
          final banners = state.banners;

          if (banners.isEmpty) return const SizedBox();

          startAutoScroll(banners.length);

          return Column(
            children: [

              /// 🔥 Slider
              GestureDetector(
                onPanDown: (_) => stopAutoScroll(), // pause
                onPanCancel: () => startAutoScroll(banners.length),
                onPanEnd: (_) => startAutoScroll(banners.length),

                child: SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _controller,
                    itemBuilder: (context, index) {

                      final realIndex = index % banners.length;
                      final banner = banners[realIndex];

                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black87, // 🔥 dark background
                            builder: (context) => FullScreenBanner(
                              imageUrl: banner.image,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              imageUrl: banner.image,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: 10.h),

              /// 🔥 Dots Indicator
              SmoothPageIndicator(
                controller: _controller,
                count: banners.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.MainBlueColor,
                  dotColor: Colors.grey,
                  dotHeight: 6,
                  dotWidth: 6,
                ),
                onDotClicked: (index) {
                  _controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              ),

              SizedBox(height: 10.h),

              /// Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.MainBlueColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () {
                    NavigationService.pushNamed(AppRoutes.allVehicles);
                  },
                  child: Text(
                    StringConstants.bookNow,
                    style: AppTextStyle.titleStyle16bb
                        .copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}


// class BannerSlider extends StatelessWidget {
//   const BannerSlider({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<BannerBloc, BannerState>(
//       builder: (context, state) {
//
//         if (state is BannerLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         if (state is BannerLoaded) {
//           final banners = state.banners;
//
//           return Column(
//             children: [
//               SizedBox(
//                 height: 180,
//                 child: PageView.builder(
//                   itemCount: banners.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         image: DecorationImage(
//                           image: NetworkImage(banners[index].image),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//
//               SizedBox(height: 10.h,),
//
//               SizedBox(
//               width: double.infinity,
//                 child: ElevatedButton(
//
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.MainBlueColor,
//                     padding: EdgeInsets.symmetric(vertical: 14.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.r),
//                     ),
//                   ),
//
//                  onPressed: () {  },
//                  child: Text("Book Now",style: AppTextStyle.titleStyle16bb.copyWith(color: AppColors.white),),
//                 ),
//               ),
//             ],
//           );
//         }
//
//         return const SizedBox();
//       },
//     );
//   }
// }
