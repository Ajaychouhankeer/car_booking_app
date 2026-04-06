abstract class VehicleEvent {}

class GetVehiclesEvent extends VehicleEvent {
  final String userId;

  GetVehiclesEvent({required this.userId});
}
