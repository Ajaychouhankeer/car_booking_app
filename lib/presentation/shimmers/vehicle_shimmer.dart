import 'package:bloc_project_basic/presentation/shimmers/vehicle_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/colors/colors.dart';
import '../../core/widgets/common_widgets.dart';

class VehicleShimmerScreen extends StatelessWidget {
  const VehicleShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// 🔍 SEARCH BAR SHIMMER
        Padding(
          padding: const EdgeInsets.all(10),
          child: _shimmerBox(height: 50, radius: 30),
        ),

        /// 🎯 BANNER SHIMMER
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _shimmerBox(height: 140, radius: 20),
        ),

        const SizedBox(height: 10),

        /// 🚗 VEHICLE LIST SHIMMER
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: 5,
            itemBuilder: (_, __) => const VehicleCardShimmer(),
          ),
        ),
      ],
    );
  }

  /// Common shimmer box
  Widget _shimmerBox({double height = 20, double width = double.infinity, double radius = 10}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}