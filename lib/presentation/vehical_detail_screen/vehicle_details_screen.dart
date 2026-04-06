import 'package:bloc_project_basic/core/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/string_constants.dart';
import '../../core/themes/app_text_style.dart';
import '../booking_screen/booking_screen.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData;

  const VehicleDetailScreen({super.key, required this.vehicleData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
            titleColor: AppColors.primary,
            title: 'Vehicle details',
            centerTitle: false,
            wantBackButton: true
          ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookingScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            "Book Now",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // CommonWidgets.verticalSpace(height: 40.h),

            /// 🔷 IMAGE (FIXED)
            Stack(
              children: [
                Image.network(
                  vehicleData["imageUrl"] ?? "",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 250,
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported, size: 50),
                    );
                  },
                ),

                Positioned(
                  top: 40,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            /// 🔽 CONTENT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🚗 Name + Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        vehicleData["vehicleName"] ?? "",
                        style: AppTextStyle.titleStyleLB24bb,
                      ),
                      Text(
                        "₹${vehicleData["pricePerKm"] ?? 0}/km",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  /// ⭐ Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        "${vehicleData["rating"] ?? 0} (${vehicleData["totalTrips"] ?? 0} trips)",
                        style: AppTextStyle.titleStyleLB12bb,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// 🔷 INFO CARDS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoCard(Icons.event_seat, "${vehicleData["seats"] ?? 0} Seats"),
                      _infoCard(Icons.local_gas_station, vehicleData["fuelType"] ?? ""),
                      _infoCard(Icons.ac_unit, (vehicleData["ac"] ?? false) ? "AC" : "Non-AC"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// 🔷 FEATURES
                  Text(
                    "Features",
                    style: AppTextStyle.titleStyleLB18bb,
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 10,
                    children: (vehicleData["features"] ?? [])
                        .map<Widget>((e) => Chip(
                      label: Text(e.toString()),
                      backgroundColor: AppColors.pieCardLightDark,
                      labelStyle: TextStyle(
                        color: AppColors.lightDarkTextDarkColor,
                      ),
                    ))
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  /// 🔷 DESCRIPTION
                  Text(
                    "Description",
                    style: AppTextStyle.titleStyleLB18bb,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    vehicleData["description"] ?? "",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  /// 🔷 AVAILABILITY
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 12,
                        color: (vehicleData["available"] ?? false)
                            ? Colors.green
                            : Colors.red,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        (vehicleData["available"] ?? false)
                            ? "Available Now"
                            : "Not Available",
                        style: TextStyle(
                          color: (vehicleData["available"] ?? false)
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.pieCardLightDark,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.orange),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(color: AppColors.lightDarkTextDarkColor),
          ),
        ],
      ),
    );
  }
}

// class VehicleDetailScreen extends StatelessWidget {
//   final Map<String, dynamic> vehicleData;
//
//   const VehicleDetailScreen({super.key, required this.vehicleData});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightDarkBackgroundColor,
//
//       /// 🔽 Bottom Book Button
//       bottomNavigationBar: Container(
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           onPressed: () {
//             print("Book Now Clicked");
//
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const BookingScreen()),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.orange,
//             padding: const EdgeInsets.symmetric(vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14),
//             ),
//           ),
//           child: const Text(
//             "Book Now",
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ),
//
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//             /// 🔷 IMAGE SECTION
//             Stack(
//               children: [
//                 Image.asset(
//                   vehicleData["imageUrl"],
//                   height: 250,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//
//                 Positioned(
//                   top: 40,
//                   left: 16,
//                   child: CircleAvatar(
//                     backgroundColor: Colors.black54,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//
//             /// 🔽 CONTENT
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//
//                   /// 🚗 Vehicle Name + Price
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         vehicleData["vehicleName"],
//                         style: AppTextStyle.titleStyleLB24bb,
//                       ),
//                       Text(
//                         "₹${vehicleData["pricePerKm"]}/km",
//                         style: const TextStyle(
//                           fontSize: 18,
//                           color: Colors.orange,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   /// ⭐ Rating
//                   Row(
//                     children: [
//                       const Icon(Icons.star, color: Colors.orange, size: 18),
//                       const SizedBox(width: 5),
//                       Text(
//                         "${vehicleData["rating"]} (${vehicleData["totalTrips"]} trips)",
//                         style: AppTextStyle.titleStyleLB12bb,
//                       ),
//                     ],
//                   ),
//
//                   const SizedBox(height: 16),
//
//                   /// 🔷 INFO CARDS
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       _infoCard(Icons.event_seat, "${vehicleData["seats"]} Seats"),
//                       _infoCard(Icons.local_gas_station, vehicleData["fuelType"]),
//                       _infoCard(Icons.ac_unit, vehicleData["ac"] ? "AC" : "Non-AC"),
//                     ],
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   /// 🔷 FEATURES
//                   Text(
//                     "Features",
//                     style: AppTextStyle.titleStyleLB18bb,
//                   ),
//
//                   const SizedBox(height: 10),
//
//                   Wrap(
//                     spacing: 10,
//                     children: (vehicleData["features"] as List)
//                         .map((e) => Chip(
//                       label: Text(e),
//                       backgroundColor: AppColors.pieCardLightDark,
//                       labelStyle: TextStyle(color: AppColors.lightDarkTextDarkColor),
//                     ))
//                         .toList(),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   /// 🔷 DESCRIPTION
//                    Text(
//                     "Description",
//                     style: AppTextStyle.titleStyleLB18bb,
//                   ),
//
//                   const SizedBox(height: 8),
//
//                   Text(
//                     vehicleData["description"],
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   /// 🔷 AVAILABILITY
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.circle,
//                         size: 12,
//                         color: vehicleData["available"]
//                             ? Colors.green
//                             : Colors.red,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         vehicleData["available"]
//                             ? "Available Now"
//                             : "Not Available",
//                         style: TextStyle(
//                           color: vehicleData["available"]
//                               ? Colors.green
//                               : Colors.red,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// 🔹 Small Info Card
//   Widget _infoCard(IconData icon, String text) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//       decoration: BoxDecoration(
//         color: AppColors.pieCardLightDark,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         children: [
//           Icon(icon, color: Colors.orange),
//           const SizedBox(height: 5),
//           Text(
//             text,
//             style:  TextStyle(color: AppColors.lightDarkTextDarkColor),
//           ),
//         ],
//       ),
//     );
//   }
// }