// import 'package:bloc_project_basic/core/constants/string_constants.dart';
// import 'package:flutter/material.dart';
//
// import '../../core/colors/colors.dart';
// import '../../core/themes/app_text_style.dart';
//
// class VehicleCard extends StatelessWidget {
//   final String carName;
//   final String imageUrl;
//   final String price;
//   final String seats;
// //  final String time;
//   final VoidCallback onBook;
//
//   const VehicleCard({
//     super.key,
//     required this.carName,
//     required this.imageUrl,
//     required this.price,
//     required this.seats,
//    // required this.time,
//     required this.onBook,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: AppColors.lightDarkCardColor,
//         borderRadius: BorderRadius.circular(20),
//         border: Border.all(color: AppColors.lightDarkBorderColor,width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.15),
//             blurRadius: 10,
//             spreadRadius: 2,
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//
//           /// Top Row (Car Name + Price)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 carName,
//                 style: AppTextStyle.titleStyleLB20bb,
//               ),
//
//               Container(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 12, vertical: 6),
//                 decoration: BoxDecoration(
//                   color: AppColors.MainBlueColor,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Text(
//                   price,
//                   style: AppTextStyle.titleStyleLB14bb.copyWith(
//                     color: AppColors.white
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 10),
//
//           /// Car Image
//           Center(
//             child: Image.network(
//               imageUrl,
//               height: 180,
//               fit: BoxFit.contain,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Icon(Icons.car_rental, size: 80);
//               },
//             )
//           ),
//
//           const SizedBox(height: 12),
//
//           /// Bottom Container
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: AppColors.lightDarkCardColor,
//
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: AppColors.lightDarkBorderColor,width: 1),
//             ),
//             child: Column(
//               children: [
//
//                 /// Row 1 → Seats, AC, Music
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _feature(Icons.event_seat, "$seats Seats"),
//                     _feature(Icons.ac_unit, "AC"),
//                     _feature(Icons.music_note, "Music System"),
//                   ],
//                 ),
//
//                 const SizedBox(height: 8),
//                 const SizedBox(height: 12),
//
//                 /// Row 2 → Book Button (Moved Down)
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: onBook,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.blue,
//                       padding: const EdgeInsets.symmetric(vertical: 14),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text(
//                       StringConstants.bookNow,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Feature Widget
//   Widget _feature(IconData icon, String text) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: AppColors.lightDarkIconColors),
//         const SizedBox(width: 5),
//         Text(text,style: AppTextStyle.titleStyleLB12bb,),
//       ],
//     );
//   }
// }

import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';
import '../../core/themes/app_text_style.dart';

class VehicleCard extends StatelessWidget {
  final String carName;
  final String imageUrl;
  final String price;
  final String seats;
  final VoidCallback onBook;

  const VehicleCard({
    super.key,
    required this.carName,
    required this.imageUrl,
    required this.price,
    required this.seats,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient:  LinearGradient(
          colors: [
            AppColors.lightDarkCardColor,
            AppColors.lightDarkCardColor,
         //   Color(0xFFF8FAFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔥 Top Row (Car Name + Price Tag)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                carName,
                style: AppTextStyle.titleStyleLB20bb.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF42A5F5),
                      // Color(0xFF1E88E5),
                      AppColors.MainBlueColor
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Text(
                  price,
                  style: AppTextStyle.titleStyleLB14bb.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 🚗 Car Image with subtle glow
          Center(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.08),
                    blurRadius: 25,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Image.network(
                imageUrl,
                height: 180,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.car_rental, size: 80);
                },
              ),
            ),
          ),

          const SizedBox(height: 14),

          /// 🔥 Bottom Container (Features + Button)
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.VehicleCardBottomContainerColor1, // light orange
                  AppColors.VehicleCardBottomContainerColor2, // light blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.6),
              ),
            ),
            child: Column(
              children: [

                /// Features Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _feature(Icons.event_seat, "$seats Seats"),
                    _feature(Icons.ac_unit, "AC"),
                    _feature(Icons.music_note, "Music"),
                  ],
                ),

                const SizedBox(height: 14),

                /// 🔘 Book Button (Modern)
                Container(
                  width: double.infinity,
                 // color: AppColors.MainBlueColor,
                  child: ElevatedButton(
                    onPressed: onBook,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                       backgroundColor: AppColors.orrangeMain,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),

                    child: Text(
                      StringConstants.bookNow,
                      style: const TextStyle(
                        color: Colors.white,
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

  /// Feature Widget (clean modern)
  Widget _feature(IconData icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: Colors.blue,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: AppTextStyle.titleStyleLB12bb.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}