
import '../../data/models/get_vehicles_model.dart';

import '../../data/models/get_vehicles_model.dart';

abstract class VehicleState {}

class VehicleInitial extends VehicleState {}

class VehicleLoading extends VehicleState {}

class VehicleLoaded extends VehicleState {
  final GetVehicles data;
  final List<dynamic> filteredVehicles; // 👈 ADD THIS

  VehicleLoaded(
      this.data, {
        required this.filteredVehicles,
      });
}

class VehicleError extends VehicleState {
  final String message;

  VehicleError(this.message);
}

// abstract class VehicleState {}
//
// class VehicleInitial extends VehicleState {}
//
// class VehicleLoading extends VehicleState {}
//
// class VehicleLoaded extends VehicleState {
//   final GetVehicles data;
//
//   VehicleLoaded(this.data);
// }
//
// class VehicleError extends VehicleState {
//   final String message;
//
//   VehicleError(this.message);
// }