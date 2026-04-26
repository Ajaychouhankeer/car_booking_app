class BookingModel {
  final String vehicleId;
  final String pickupLocation;
  final String dropLocation;
  final String pickupDate;
  final String pickupTime;
  final String? returnDate;
  final int estimatedKm;
  final bool driverRequired;
  final String specialNote;
  final int passengers;

  BookingModel({
    required this.vehicleId,
    required this.pickupLocation,
    required this.dropLocation,
    required this.pickupDate,
    required this.pickupTime,
    this.returnDate,
    required this.estimatedKm,
    required this.driverRequired,
    required this.specialNote,
    required this.passengers,
  });

  Map<String, dynamic> toJson() {
    return {
      "vehicleId": vehicleId,
      "pickupLocation": pickupLocation,
      "dropLocation": dropLocation,
      "pickupDate": pickupDate,
      "pickupTime": pickupTime,
      "returnDate": returnDate,
      "estimatedKm": estimatedKm,
      "driverRequired": driverRequired,
      "specialNote": specialNote,
      "passengers": passengers,
    };
  }
}