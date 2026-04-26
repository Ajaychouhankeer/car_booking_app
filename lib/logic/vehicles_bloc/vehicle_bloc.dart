import 'package:bloc_project_basic/data/repositories/api_methods.dart';
import 'package:bloc_project_basic/logic/vehicles_bloc/vehicle_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {

  List<dynamic> _allVehicles = [];

  VehicleBloc() : super(VehicleInitial()) {
    on<GetVehiclesEvent>(_getVehicles);
    on<SearchVehicleEvent>(_searchVehicle);
  }

  Future<void> _getVehicles(
      GetVehiclesEvent event,
      Emitter<VehicleState> emit,
      ) async {

    emit(VehicleLoading());

    try {
      final response = await ApiMethods.getvehiclesApi(
        userId: event.userId,
      );

      if (response != null) {

        _allVehicles = response.data ?? [];

        emit(VehicleLoaded(
          response,
          filteredVehicles: _allVehicles, // 👈 initially full list
        ));

      } else {
        emit(VehicleError("No data found"));
      }
    } catch (e) {
      emit(VehicleError(e.toString()));
    }
  }

  void _searchVehicle(
      SearchVehicleEvent event,
      Emitter<VehicleState> emit,
      ) {

    final currentState = state;

    if (currentState is VehicleLoaded) {

      final query = event.query.toLowerCase();

      final filtered = _allVehicles.where((vehicle) {
        final name = (vehicle.vehicleName ?? "").toLowerCase();
        return name.contains(query);
      }).toList();

      emit(VehicleLoaded(
        currentState.data,
        filteredVehicles: filtered,
      ));
    }
  }
}


// class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
//   VehicleBloc() : super(VehicleInitial()) {
//     on<GetVehiclesEvent>(_getVehicles);
//   }
//
//   Future<void> _getVehicles(
//       GetVehiclesEvent event,
//       Emitter<VehicleState> emit,
//       ) async {
//     emit(VehicleLoading());
//
//     try {
//       final response = await ApiMethods.getvehiclesApi(
//         userId: event.userId,
//       );
//
//       if (response != null) {
//         emit(VehicleLoaded(response));
//       } else {
//         emit(VehicleError("No data found"));
//       }
//     } catch (e) {
//       emit(VehicleError(e.toString()));
//     }
//   }
// }