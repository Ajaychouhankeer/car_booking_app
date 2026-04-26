import 'package:bloc_project_basic/core/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/string_constants.dart';
import '../../core/themes/app_text_style.dart';
import '../../logic/booking/booking_bloc.dart';
import '../../logic/distance_bloc/distance_bloc.dart';
import '../booking_screen/booking_screen.dart';

class VehicleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> vehicleData;

  const VehicleDetailScreen({super.key, required this.vehicleData});

  @override
  Widget build(BuildContext context) {
    print("Vehicle Data: $vehicleData");
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
            title: StringConstants.vehicleDetails,
            centerTitle: false,
            wantBackButton: true
          ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(

          onPressed: () {
            final vehicleId = vehicleData["_id"];

            print("Vehicle Data: $vehicleData");
            print("Vehicle ID: $vehicleId");

            if (vehicleId == null || vehicleId.toString().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Vehicle ID missing ❌")),
              );
              return;
            }
            print("FULL VEHICLE DATA: $vehicleData");
            print("pricePerDay RAW: ${vehicleData["pricePerDay"]}");
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (_) => BookingScreen(
            //       vehicleId: vehicleId.toString(),
            //       pricePerKm: (vehicleData["pricePerKm"] ?? 0).toDouble(),
            //       pricePerDay: (vehicleData["pricePerDay"] ?? 0).toDouble(),
            //     ),
            //   ),
            // );

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => DistanceBloc(),
                    ),
                    BlocProvider(
                      create: (_) => BookingBloc(),
                    ),
                  ],
                  child: BookingScreen(
                    vehicleId: vehicleId.toString(),
                    pricePerKm: (vehicleData["pricePerKm"] ?? 0).toDouble(),
                    pricePerDay: (vehicleData["pricePerDay"] ?? 0).toDouble(),
                  ),
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.MainBlueColor,

            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            StringConstants.bookNow,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ///IMAGE (FIXED)
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

            /// CONTENT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Name + Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        vehicleData["vehicleName"] ?? "",
                        style: AppTextStyle.titleStyleLB24bb,
                      ),
                      Text(
                        "₹${vehicleData["pricePerKm"] ?? 0}/km",
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.orrangeMain,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  ///Rating
                  Row(
                    children: [
                      Icon(Icons.star, color: AppColors.orrangeMain, size: 18),
                      const SizedBox(width: 5),
                      Text(
                        "${vehicleData["rating"] ?? 0} (${vehicleData["totalTrips"] ?? 0} trips)",
                        style: AppTextStyle.titleStyleLB12bb,
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  ///INFO CARDS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoCard(Icons.event_seat, "${vehicleData["seats"] ?? 0} Seats"),
                      _infoCard(Icons.local_gas_station, vehicleData["fuelType"] ?? ""),
                      _infoCard(Icons.ac_unit, (vehicleData["ac"] ?? false) ? "AC" : "Non-AC"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  /// FEATURES
                  Text(
                    StringConstants.features,
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

                  ///DESCRIPTION
                  Text(
                    StringConstants.description,
                    style: AppTextStyle.titleStyleLB18bb,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    vehicleData["description"] ?? "",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 20),

                  /// AVAILABILITY
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
                            ? StringConstants.availableNow
                            : StringConstants.notAvailble,
                        style: TextStyle(
                          color: (vehicleData["available"] ?? false)
                              ? AppColors.greenDark
                              : AppColors.lightYellow
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
          Icon(icon, color: AppColors.orrangeMain,),
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
