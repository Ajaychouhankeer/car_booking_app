import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/networks/response/status.dart';
import '../../../core/colors/colors.dart';

import '../../core/constants/image_constant.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/booking/booking_bloc.dart';
import '../../logic/booking/booking_event.dart';
import '../../logic/booking/booking_state.dart';
import '../shimmers/booking_shimmer_screen.dart';
import 'booking_card.dart';
import 'booking_details_screen.dart'; // 👈 NEW WIDGET

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen> {
  void showCancelDialog(BuildContext context, String bookingId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppColors.lightDarkCardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ///ICON
                Image.asset(ImageConstants.cancelBooking, width: 62),

                CommonWidgets.verticalSpace(height: 15.h),

                /// TITLE
                Text(
                  StringConstants.cancelBooking,
                  style: AppTextStyle.titleStyleLB20bb,
                ),

                CommonWidgets.verticalSpace(height: 10.h),

                /// SUB TEXT
                Text(
                  StringConstants.areYouSureCancelBooking,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),

                CommonWidgets.verticalSpace(height: 22.h),

                /// BUTTONS
                Row(
                  children: [
                    /// NO BUTTON
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          StringConstants.no,
                          style: AppTextStyle.titleStyleLB12bb,
                        ),
                      ),
                    ),

                    CommonWidgets.horizontalSpace(width: 12.w),

                    /// YES BUTTON
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(ctx);

                          context.read<BookingBloc>().add(
                            CancelBookingEvent(bookingId: bookingId),
                          );

                          showCancelSuccessDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          StringConstants.yesCancel,
                          style: AppTextStyle.titleStyle12bb.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showCancelSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.cancel, color: Colors.red, size: 50),
                ),

                CommonWidgets.verticalSpace(height: 15.h),

                Text(
                  StringConstants.bookingCanceled,
                  style: AppTextStyle.titleStyle18bb,
                ),

                CommonWidgets.verticalSpace(height: 10.h),

                Text(
                  StringConstants.bookingCanceledSuccefully,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700),
                ),

                CommonWidgets.verticalSpace(height: 20.h),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(ctx); // close dialog

                      /// 🔥 refresh list
                      context.read<BookingBloc>().add(GetMyBookingsEvent());
                    },
                    child: Text(StringConstants.ok),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    /// 🔥 Load bookings
    context.read<BookingBloc>().add(GetMyBookingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        title: StringConstants.myBookings,
        centerTitle: false,
        // wantBackButton: false
      ),

      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          /// Cancel success
          if (state.cancelBookingResponse.status == Status.completed) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Booking Cancelled")));
          }

          /// Cancel error
          if (state.cancelBookingResponse.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.cancelBookingResponse.message ?? "Error"),
              ),
            );
          }
        },

        builder: (context, state) {
          switch (state.myBookingsResponse.status) {
            /// Loading
            case Status.loading:
              return const BookingShimmerScreen();

            /// Data Loaded
            case Status.completed:
              final bookings = state.myBookingsResponse.data ?? [];

              if (bookings.isEmpty) {
                return Center(
                  child: Text(
                    StringConstants.noBookingFound,
                    style: TextStyle(color: Colors.white70),
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<BookingBloc>().add(GetMyBookingsEvent());
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];

                    return BookingCard(
                      booking: booking,
                      onCancel: () {
                        showCancelDialog(context, booking['_id']);
                      },

                      /// DETAILS
                      onViewDetails: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                BookingDetailsScreen(booking: booking),
                          ),
                        );
                      },
                    );
                  },
                ),
              );

            /// Error
            case Status.error:
              return Center(
                child: Text(
                  state.myBookingsResponse.message ?? "Error",
                  style: const TextStyle(color: Colors.white),
                ),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}