import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:bloc_project_basic/core/navigations/navigation_service.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter/material.dart';
import '../../../core/colors/colors.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_widgets.dart';


class BookingDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> booking;

  const BookingDetailsScreen({super.key, required this.booking});

  Color getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getShortBookingId(String id) {
    if (id.length <= 10) return id;
    return id.substring(0, 10);
  }

  @override
  Widget build(BuildContext context) {
    final vehicle = booking['vehicle'];
    final breakdown = booking['breakdown'] ?? {};
    final extraDays = breakdown['extraDays'] ?? 0;
    final perDayPrice = breakdown['perDayPrice'] ?? 0;
    final status = booking['status'] ?? "";
    final paymentStatusRaw = (booking['paymentStatus'] ?? "unpaid").toString().toLowerCase();

    final paymentStatus = (paymentStatusRaw == "unpaid" || paymentStatusRaw == "")
        ? "pending"
        : paymentStatusRaw;

    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        title: StringConstants.bookingDetails,
        centerTitle: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
           // color: Colors.white,
            gradient: LinearGradient(
              colors: [
                AppColors.VehicleCardBottomContainerColor1, // light orange
                AppColors.VehicleCardBottomContainerColor2, // light blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [

              /// HEADER
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFF1E5AA8),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Center(
                  child: Text(
                    StringConstants.bookingDetails,
                    style: AppTextStyle.titleStyleLB20bb.copyWith(color: AppColors.white),
                  ),
                ),
              ),

              /// BOOKING ID + STATUS
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${StringConstants.bookingID}: ${getShortBookingId(booking['_id'] ?? '')}",
                      style: AppTextStyle.titleStyleLB16bb,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: getStatusColor(status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              _divider(),

              /// ROUTE
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            booking['pickupLocation'] ?? "",
                            style: AppTextStyle.titleStyleLB16bb,
                          ),
                        ),
                      ],
                    ),
                    CommonWidgets.verticalSpace(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        CommonWidgets.horizontalSpace(width: 8),
                        Expanded(
                          child: Text(
                            booking['dropLocation'] ?? "",
                            style: AppTextStyle.titleStyleLB16bb,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              _divider(),

              /// CAR DETAILS
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Image.network(
                      vehicle?['imageUrl'] ?? "",
                      height: 120,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(Icons.car_rental, size: 80),
                    ),
                    CommonWidgets.verticalSpace(height: 10),
                    Text(
                      vehicle?['vehicleName'] ?? StringConstants.vehicle,
                      style: AppTextStyle.titleStyleLB20bb,
                    ),
                    CommonWidgets.verticalSpace(height: 6),
                    Text(
                      "${booking['passengers'] ?? 0} Seats • ${booking['estimatedKm']} KM",
                      style: AppTextStyle.titleStyleLB16bb,
                    ),
                  ],
                ),
              ),

              _divider(),

              /// BOOKING INFO
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _infoRow(StringConstants.pickupDate,
                        (booking['pickupDate'] ?? "").split("T")[0]),
                    _infoRow(StringConstants.returnDate,
                        (booking['returnDate'] ?? "").split("T")[0]),
                    _infoRow(StringConstants.totalDistanceInkm,
                        "${booking['estimatedKm']} KM"),
                  ],
                ),
              ),

              _divider(),
              Text(
                "Price Details",
                style: AppTextStyle.titleStyleLB18bb,
              ),
              CommonWidgets.verticalSpace(height: 8),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  children: [

                    /// BASE FARE
                    _infoRow(
                      "Distance Charge",
                      "₹${breakdown['baseFare'] ?? 0}",
                    ),

                    /// EXTRA DAY
                    if ((breakdown['extraDayCharge'] ?? 0) > 0) ...[
                      _infoRow(
                        "Extra Days ($extraDays days)",
                        "₹$perDayPrice/day",
                      ),
                      _infoRow(
                        "Total Extra Charge",
                        "₹${breakdown['extraDayCharge']}",
                      ),
                    ],

                    /// DRIVER
                    if ((breakdown['driverCharge'] ?? 0) > 0)
                      _infoRow(
                        "Driver Charge",
                        "₹${breakdown['driverCharge']}",
                      ),
                  ],
                ),
              ),

              _divider(),

              /// PRICE
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(StringConstants.totalAmout,
                       style: AppTextStyle.titleStyleLB18bb,

                     ),
                    Text(
                      "₹${booking['totalAmount']}",
                      style: AppTextStyle.titleStyleLB18bb
                    ),
                  ],
                ),
              ),

              CommonWidgets.verticalSpace(height: 10),

              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: (paymentStatus == "pending" ||
                      paymentStatus == "unpaid" ||
                      paymentStatus == "rejected")
                      ? ElevatedButton(
                    onPressed: () {
                      NavigationService.pushNamed(
                        AppRoutes.makePaymentScreen,
                        arguments: {
                          "amount": booking['totalAmount'],
                          "bookingData": booking,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orrangeMain,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      paymentStatus == "rejected"
                          ? StringConstants.payAgain
                          : StringConstants.makePayment,
                      style: AppTextStyle.titleStyle16bb.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  )
                      : _paymentStatusWidget(paymentStatus),
                ),
              ),

              CommonWidgets.verticalSpace(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Row(
      children: List.generate(
        40,
            (index) => Expanded(
          child: Container(
            height: 1,
            color: index % 2 == 0
                ? Colors.grey[300]
                : Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.titleStyleLB16bb),
          Text(value, style: AppTextStyle.titleStyleLB16bb),
        ],
      ),
    );
  }

  Widget _paymentStatusWidget(String status) {
    String text = "";
    Color color = Colors.grey;

    switch (status) {
      case "submitted":
        text = StringConstants.paymentSubmitted;
        color = Colors.orange;
        break;

      case "paid":
        text = StringConstants.paymentVerified;
        color = Colors.green;
        break;

      case "rejected":
        text = StringConstants.paymentRejected;
        color = Colors.red;
        break;

      default:
        text = StringConstants.paymentPending;
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
