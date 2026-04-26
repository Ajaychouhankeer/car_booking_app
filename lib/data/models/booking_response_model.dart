// class BookingResponseModel {
//   final String id;
//   final String bookingId;
//   final String pickupLocation;
//   final String dropLocation;
//   final String pickupDate;
//   final String pickupTime;
//   final String? returnDate;
//   final double totalAmount;
//   final int passengers;
//   final String status;
//   final String? paymentStatus;
//
//   BookingResponseModel({
//     required this.id,
//     required this.bookingId,
//     required this.pickupLocation,
//     required this.dropLocation,
//     required this.pickupDate,
//     required this.pickupTime,
//     this.returnDate,
//     required this.totalAmount,
//     required this.passengers,
//     required this.status,
//     this.paymentStatus,
//   });
//
//   factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
//     return BookingResponseModel(
//       id: json['_id'] ?? "",
//       bookingId: json['bookingId'] ?? "",
//       pickupLocation: json['pickupLocation'] ?? "",
//       dropLocation: json['dropLocation'] ?? "",
//       pickupDate: json['pickupDate'] ?? "",
//       pickupTime: json['pickupTime'] ?? "",
//       returnDate: json['returnDate'],
//       totalAmount: (json['totalAmount'] ?? 0).toDouble(),
//       passengers: json['passengers'] ?? 0,
//       status: json['status'] ?? "",
//       paymentStatus: json['paymentStatus'] ?? "pending",
//     );
//   }
// }

class BookingResponseModel {
  final String id;
  final String bookingId;
  final String pickupLocation;
  final String dropLocation;
  final String pickupDate;
  final String pickupTime;
  final String? returnDate;
  final double totalAmount;
  final int passengers;
  final String status;
  final String? paymentStatus;
  final int extraDays;

  final BreakdownModel breakdown; // ✅ NEW

  BookingResponseModel({
    required this.id,
    required this.bookingId,
    required this.pickupLocation,
    required this.dropLocation,
    required this.pickupDate,
    required this.pickupTime,
    this.returnDate,
    required this.totalAmount,
    required this.passengers,
    required this.status,
    this.paymentStatus,
    required this.extraDays,
    required this.breakdown, // ✅ NEW
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) {
    return BookingResponseModel(
      id: json['_id'] ?? "",
      bookingId: json['bookingId'] ?? "",
      pickupLocation: json['pickupLocation'] ?? "",
      dropLocation: json['dropLocation'] ?? "",
      pickupDate: json['pickupDate'] ?? "",
      pickupTime: json['pickupTime'] ?? "",
      returnDate: json['returnDate'],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      passengers: json['passengers'] ?? 0,
      status: json['status'] ?? "",
      paymentStatus: json['paymentStatus'] ?? "pending",
      extraDays: json['extraDays'] ?? 0,

      breakdown: BreakdownModel.fromJson(json['breakdown'] ?? {}), // ✅ NEW
    );
  }
}

class BreakdownModel {
  final double baseFare;
  final double extraDayCharge;
  final double driverCharge;

  BreakdownModel({
    required this.baseFare,
    required this.extraDayCharge,
    required this.driverCharge,
  });

  factory BreakdownModel.fromJson(Map<String, dynamic> json) {
    return BreakdownModel(
      baseFare: (json['baseFare'] ?? 0).toDouble(),
      extraDayCharge: (json['extraDayCharge'] ?? 0).toDouble(),
      driverCharge: (json['driverCharge'] ?? 0).toDouble(),
    );
  }
}