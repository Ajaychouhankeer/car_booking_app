import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/colors/colors.dart';
import '../../core/widgets/common_search_bar.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/vehicles_bloc/vehicle_bloc.dart';
import '../../logic/vehicles_bloc/vehicle_events.dart';
import '../../logic/vehicles_bloc/vehicle_state.dart';
import '../home_screen/vehical_card.dart';
import '../shimmers/vehicle_shimmer.dart';
import '../vehical_detail_screen/vehicle_details_screen.dart';

import '../../logic/bottom_nav/bottom_nav_bloc.dart';
import '../../logic/bottom_nav/bottom_nav_event.dart';


class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      appBar: CommonWidgets.appBar(
          backgroundColor: AppColors.lightDarkBackgroundColor,
          title: StringConstants.availablevehicles,
          centerTitle: false,
        onTap: () {
          context.read<BottomNavBloc>().add(BackTabEvent());
        },
      ),

      body: BlocProvider(
        create: (_) =>
        VehicleBloc()..add(GetVehiclesEvent(userId: "123")),
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

        if (state is VehicleLoading) {
          return const VehicleShimmerScreen();
        }

        if (state is VehicleError) {
          return Center(child: Text(state.message));
        }

        if (state is VehicleLoaded) {
         // final vehicles = state.data.data ?? [];
          final vehicles = state.filteredVehicles;

          if (vehicles.isEmpty) {
            return  Center(child: Text(StringConstants.noVahicleAvailbe));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CommonSearchBar(
                  hintText: StringConstants.searchVhicles,
                  onChanged: (value) {
                    context.read<VehicleBloc>().add(SearchVehicleEvent(value));
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
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
                                "_id": vehicle.sId,
                                "vehicleName": vehicle.vehicleName,
                                "imageUrl": vehicle.imageUrl,
                                "pricePerKm": vehicle.pricePerKm,
                                "pricePerDay": vehicle.pricePerDay,
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
                       // time: "25 mins",
                        onBook: () {},
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}