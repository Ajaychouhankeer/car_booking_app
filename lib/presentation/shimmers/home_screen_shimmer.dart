import 'package:bloc_project_basic/presentation/shimmers/vehicle_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/colors/colors.dart';

class HomeShimmerScreen extends StatelessWidget {
  const HomeShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const SizedBox(height: 10),

          /// 👋 Greeting
          _box(width: 150, height: 20),
          const SizedBox(height: 5),
          _box(width: 220, height: 25),

          const SizedBox(height: 20),

          /// 🎯 Banner Slider
          _box(height: 200, radius: 20),

          const SizedBox(height: 10),

          /// Dots
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
                  (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _box(width: 8, height: 8, radius: 10),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// 🔥 Popular Title
          _box(width: 180, height: 20),

          const SizedBox(height: 10),

          /// BannerSlider shimmer (horizontal cards)
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: _box(width: 200, height: 120, radius: 15),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// 📂 Category Title
          _box(width: 120, height: 20),

          const SizedBox(height: 15),

          /// Categories Grid
          GridView.builder(
            itemCount: 8,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (_, __) => Column(
              children: [
                _box(width: 60, height: 60, radius: 15),
                const SizedBox(height: 5),
                _box(width: 50, height: 10),
              ],
            ),
          ),

          const SizedBox(height: 25),

          /// 🚗 Vehicle Section Title
          _box(width: 150, height: 20),

          const SizedBox(height: 10),

          /// Vehicle Cards shimmer
          ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, __) => const VehicleCardShimmer(),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _box({
    double width = double.infinity,
    double height = 20,
    double radius = 8,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}