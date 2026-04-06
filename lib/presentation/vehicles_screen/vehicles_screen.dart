import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors/colors.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/vehicles_bloc/vehicle_bloc.dart';
import '../../logic/vehicles_bloc/vehicle_events.dart';
import '../../logic/vehicles_bloc/vehicle_state.dart';
import '../home_screen/vehical_card.dart';
import '../vehical_detail_screen/vehicle_details_screen.dart';


class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      // appBar: AppBar(
      //   title: const Text("Available Vehicles"),
      // ),

      appBar: CommonWidgets.appBar(
          backgroundColor: AppColors.lightDarkBackgroundColor,
          titleColor: AppColors.primary,
          title: 'Available Vehicles',
          centerTitle: false,
         // wantBackButton: false
      ),

      body: BlocProvider(
        create: (_) =>
        VehicleBloc()..add(GetVehiclesEvent(userId: "123")), // 👈 pass dynamic id
        child: const _VehiclesView(),
      ),
    );
  }
}

class _VehiclesView extends StatelessWidget {
  const _VehiclesView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleBloc, VehicleState>(
      builder: (context, state) {

        /// 🔄 LOADING
        if (state is VehicleLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        /// ❌ ERROR
        if (state is VehicleError) {
          return Center(child: Text(state.message));
        }

        /// ✅ SUCCESS
        if (state is VehicleLoaded) {
          final vehicles = state.data.data ?? [];

          /// 📭 EMPTY
          if (vehicles.isEmpty) {
            return const Center(child: Text("No vehicles available"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: vehicles.length,
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VehicleDetailScreen(
                        vehicleData: {
                          "vehicleName": vehicle.vehicleName,
                          "imageUrl": vehicle.imageUrl,
                          "pricePerKm": vehicle.pricePerKm,
                          "rating": vehicle.rating,
                          "totalTrips": vehicle.totalTrips,
                          "seats": vehicle.seats,
                          "fuelType": vehicle.fuelType,
                          "ac": vehicle.ac,
                          "features": vehicle.features,
                          "description": vehicle.description,
                          "available": vehicle.available,
                        },
                      ),
                    ),
                  );
                },
                child: VehicleCard(
                  carName: vehicle.vehicleName ?? "No Name",
                  imageUrl: vehicle.imageUrl ?? "",
                  price: "₹${vehicle.pricePerKm ?? 0}/km",
                  seats: (vehicle.seats ?? 0).toString(),
                  time: "25 mins",
                  onBook: () {},
                ),
              );

              // return GestureDetector(
              //   onTap: () {
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (_) => VehicleDetailScreen(
              //             vehicleData: {
              //               "vehicleName": vehicle.vehicleName,
              //               "imageUrl": vehicle.imageUrl,
              //               "pricePerKm": vehicle.pricePerKm,
              //               "rating": vehicle.rating,
              //               "totalTrips": vehicle.totalTrips,
              //               "seats": vehicle.seats,
              //               "fuelType": vehicle.fuelType,
              //               "ac": vehicle.ac,
              //               "features": vehicle.features,
              //               "description": vehicle.description,
              //               "available": vehicle.available,
              //             },
              //           ),
              //         ),
              //       );
              //     };
              //   },
              //   child: VehicleCard(
              //     carName: vehicle.vehicleName ?? "No Name",
              //     imageUrl: vehicle.imageUrl ?? "",
              //     price: "₹${vehicle.pricePerKm ?? 0}/km",
              //     seats: (vehicle.seats ?? 0).toString(),
              //     time: "25 mins", // 👉 you can replace with API later
              //     onBook: () {
              //       /// 👉 Navigate to booking screen
              //     },
              //   ),
              // );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}