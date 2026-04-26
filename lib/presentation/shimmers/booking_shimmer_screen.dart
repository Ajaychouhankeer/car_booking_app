import 'package:flutter/cupertino.dart';

import 'booking_history_shimmer.dart';

class BookingShimmerScreen extends StatelessWidget {
  const BookingShimmerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: 5,
      itemBuilder: (_, __) => const BookingCardShimmer(),
    );
  }
}