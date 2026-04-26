import 'package:bloc_project_basic/core/navigations/navigation_service.dart';
import 'package:bloc_project_basic/core/themes/app_text_style.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/vehicles_bloc/vehicle_bloc.dart';
import '../../logic/vehicles_bloc/vehicle_events.dart';
import '../../logic/vehicles_bloc/vehicle_state.dart';
import '../home_screen/vehical_card.dart';
import '../vehical_detail_screen/vehicle_details_screen.dart';

class HomeVehicleSection extends StatefulWidget {
  const HomeVehicleSection({super.key});

  @override
  State<HomeVehicleSection> createState() => _HomeVehicleSectionState();
}

class _HomeVehicleSectionState extends State<HomeVehicleSection> {
  bool isCalled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Call only once
    if (!isCalled) {
      context.read<VehicleBloc>().add(GetVehiclesEvent(userId: "123"));
      isCalled = true;
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehicleBloc, VehicleState>(
      builder: (context, state) {
     //   context.read<VehicleBloc>().add(GetVehiclesEvent(userId: "123"));
        if (state is VehicleLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is VehicleError) {
          return Text(state.message);
        }

        if (state is VehicleLoaded) {

          // ✅ ONLY FIRST 10 VEHICLES
          final vehicles = state.data.data?.take(10).toList() ?? [];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Vehicles",
                    style: AppTextStyle.titleStyleLB16bb
                  ),
                  GestureDetector(
                    onTap: (){
                      NavigationService.pushNamed(AppRoutes.allVehicles);
                    },
                    child: Text(
                      "View All",
                        style: AppTextStyle.titleStyleLB16bb
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                              "_id": vehicle.sId,
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
                      carName: vehicle.vehicleName ?? "",
                      imageUrl: vehicle.imageUrl ?? "",
                      price: "₹${vehicle.pricePerKm}/km",
                      seats: (vehicle.seats ?? 0).toString(),
                     // time: "25 mins",
                      onBook: () {},
                    ),
                  );
                },
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}