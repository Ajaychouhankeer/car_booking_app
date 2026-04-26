import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BookingCardShimmer extends StatelessWidget {
  const BookingCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// LEFT CONTENT
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Title + Status
                  Row(
                    children: [
                      _box(width: 120, height: 20),
                      const SizedBox(width: 10),
                      _box(width: 60, height: 20, radius: 20),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// Date
                  _box(width: 100, height: 14),

                  const SizedBox(height: 6),

                  /// Time
                  _box(width: 80, height: 14),

                  const SizedBox(height: 12),

                  /// From
                  Row(
                    children: [
                      _circle(20),
                      const SizedBox(width: 8),
                      _box(width: 150, height: 14),
                    ],
                  ),

                  /// Line
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 20,
                      width: 2,
                      color: Colors.white,
                    ),
                  ),

                  /// To
                  Row(
                    children: [
                      _circle(20),
                      const SizedBox(width: 8),
                      _box(width: 150, height: 14),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Price
                  _box(width: 80, height: 18),

                  const SizedBox(height: 12),

                  /// Buttons
                  Row(
                    children: [
                      Expanded(child: _box(height: 40, radius: 12)),
                      const SizedBox(width: 10),
                      Expanded(child: _box(height: 40, radius: 12)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            /// Right Image
            _box(width: 110, height: 85, radius: 12),
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

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }
}