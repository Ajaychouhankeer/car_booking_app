import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_widgets.dart';


String formatTime(String time) {
  try {
    final parsedTime = DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm a").format(parsedTime);
  } catch (e) {
    return time;
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> booking;
  final VoidCallback onCancel;
  final VoidCallback onViewDetails;

  const BookingCard({
    super.key,
    required this.booking,
    required this.onCancel,
    required this.onViewDetails,
  });

  Color getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "completed":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      case "confirmed":
        return AppColors.MainBlueColor;
      case "ongoing":
        return AppColors.MainBlueColor;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = booking['status'] ?? "";
    final vehicle = booking['vehicle'];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
       // color: AppColors.lightDarkCardColor,
        gradient: LinearGradient(
          colors: [
            AppColors.VehicleCardBottomContainerColor1, // light orange
            AppColors.VehicleCardBottomContainerColor2, // light blue
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔷 LEFT SIDE CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🚗 TITLE + STATUS
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        vehicle?['vehicleName'] ?? "Vehicle",
                        style: AppTextStyle.titleStyleLB20bb
                      ),
                    ),

                    /// STATUS BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: getStatusColor(status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status.toUpperCase(),
                        style: TextStyle(
                          color: getStatusColor(status),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                CommonWidgets.verticalSpace(height: 6),

                /// 📅 DATE
                Text(
                  (booking['pickupDate'] ?? "").split("T")[0],
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                ),

                Row(
                  children: [
                    Image.asset(
                      ImageConstants.pickupTimeIcon,
                      width: 16,
                    ),
                    CommonWidgets.horizontalSpace(width: 5),
                    Text(
                      formatTime(booking['pickupTime'] ?? ""), // ✅ UPDATED
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),

                CommonWidgets.verticalSpace(height: 10),

                /// 📍 ROUTE (TIMELINE STYLE)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// 🔵 FROM (ICON + TEXT SAME LINE)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageConstants.fromLocaionIcon,
                          width: 32,
                        ),
                        CommonWidgets.horizontalSpace(width: 8),
                        Expanded(
                          child: Text(
                            booking['pickupLocation'] ?? "",
                            style:AppTextStyle.titleStyleLB16bb
                          ),
                        ),
                      ],
                    ),

                    /// 🔽 LINE
                    Padding(
                      padding: const EdgeInsets.only(left: 11), // icon ke center se line
                      child: Container(
                        height: 20,
                        width: 2,
                        color: Colors.grey.shade400,
                      ),
                    ),

                    /// 🔴 TO (ICON + TEXT SAME LINE)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImageConstants.toLocationIcon,
                          width: 32,
                        ),
                        CommonWidgets.horizontalSpace(width: 8),
                        Expanded(
                          child: Text(
                            booking['dropLocation'] ?? "",
                              style:AppTextStyle.titleStyleLB16bb
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                CommonWidgets.verticalSpace(height: 10),

                /// 💰 PRICE
                Text(
                  "₹${booking['totalAmount']}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),

                CommonWidgets.verticalSpace(height: 4),

                _buildPaymentStatus(booking['paymentStatus'] ?? "unpaid"),

                CommonWidgets.verticalSpace(height: 8),

                /// 🔘 ACTIONS
                Row(
                  children: [
                    /// 🔵 VIEW DETAILS (PRIMARY BUTTON)
                    Expanded(
                      child: SizedBox(
                        height: 42,
                        child: ElevatedButton(
                          onPressed: onViewDetails,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.MainBlueColor,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                StringConstants.viewDetails,
                                style: AppTextStyle.titleStyle12bb.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    CommonWidgets.horizontalSpace(width: 8),

                    /// 🔴 CANCEL (SECONDARY BUTTON - OUTLINED)
                    if (status == "pending")
                      Expanded(
                        child: SizedBox(
                          height: 42,
                          child: OutlinedButton(
                            onPressed: onCancel,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      StringConstants.cancelBooking,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),

          CommonWidgets.horizontalSpace(width: 10),

          /// 🚗 RIGHT IMAGE (PERFECT SIZE)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              vehicle?['imageUrl'] ?? "",
              height: 85,
              width: 110,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                height: 85,
                width: 110,
                color: Colors.grey.shade300,
                child: const Icon(Icons.car_rental),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildPaymentStatus(String status) {
    final s = status.toLowerCase();

    String text;
    Color color;

    switch (s) {
      case "submitted":
        text = StringConstants.paymentSubmitted;
        color = Colors.orange;
        break;

      case "paid":
        text = "Payment Paid";
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
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        text,
        style: AppTextStyle.titleStyleLB12bb.copyWith(color: color),
        // style: TextStyle(
        //   fontSize: 12,
        //   color: color,
        //   fontWeight: FontWeight.w600,
        // ),
      ),
    );
  }
}

