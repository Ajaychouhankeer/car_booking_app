abstract class VehicleEvent {}

class GetVehiclesEvent extends VehicleEvent {
  final String userId;

  GetVehiclesEvent({required this.userId});
}

class SearchVehicleEvent extends VehicleEvent {
  final String query;

  SearchVehicleEvent(this.query);
}