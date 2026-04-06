import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/themes/app_text_style.dart';

class VehicleCard extends StatelessWidget {
  final String carName;
  final String imageUrl;
  final String price;
  final String seats;
  final String time;
  final VoidCallback onBook;

  const VehicleCard({
    super.key,
    required this.carName,
    required this.imageUrl,
    required this.price,
    required this.seats,
    required this.time,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightDarkCardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.lightDarkBorderColor,width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Top Row (Car Name + Price)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                carName,
                style: AppTextStyle.titleStyleLB20bb,
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.backGroundColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  price,
                  style: AppTextStyle.titleStyleLB14bb,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Car Image
          Center(
            child: Image.network(
              imageUrl,
              height: 180,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.car_rental, size: 80);
              },
            )
          ),

          const SizedBox(height: 12),

          /// Bottom Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightDarkCardColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: AppColors.lightDarkBorderColor,width: 1),
            ),
            child: Column(
              children: [

                /// Row 1 → Seats, AC, Music
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _feature(Icons.event_seat, "$seats Seats"),
                    _feature(Icons.ac_unit, "AC"),
                    _feature(Icons.music_note, "Music System"),
                  ],
                ),

                const SizedBox(height: 8),

                /// Time Row
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                /// Row 2 → Book Button (Moved Down)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Feature Widget
  Widget _feature(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.lightDarkIconColors),
        const SizedBox(width: 5),
        Text(text,style: AppTextStyle.titleStyleLB12bb,),
      ],
    );
  }
}