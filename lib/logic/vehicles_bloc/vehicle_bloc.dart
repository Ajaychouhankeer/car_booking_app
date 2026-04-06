import 'package:bloc_project_basic/data/repositories/api_methods.dart';
import 'package:bloc_project_basic/logic/vehicles_bloc/vehicle_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'vehicle_state.dart';



class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  VehicleBloc() : super(VehicleInitial()) {
    on<GetVehiclesEvent>(_getVehicles);
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
        emit(VehicleLoaded(response));
      } else {
        emit(VehicleError("No data found"));
      }
    } catch (e) {
      emit(VehicleError(e.toString()));
    }
  }
}