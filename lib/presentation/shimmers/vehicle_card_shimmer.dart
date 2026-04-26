import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VehicleCardShimmer extends StatelessWidget {
  const VehicleCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Top Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(width: 120, height: 20),
                _box(width: 70, height: 25, radius: 12),
              ],
            ),

            const SizedBox(height: 10),

            /// Image
            Center(
              child: _box(height: 180, width: double.infinity, radius: 12),
            ),

            const SizedBox(height: 12),

            /// Bottom Container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Column(
                children: [

                  /// Features Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _box(width: 60, height: 15),
                      _box(width: 40, height: 15),
                      _box(width: 80, height: 15),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Button
                  _box(height: 45, width: double.infinity, radius: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _box({double width = double.infinity, double height = 20, double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}