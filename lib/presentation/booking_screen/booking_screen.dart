import 'package:bloc_project_basic/core/colors/colors.dart';
import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:bloc_project_basic/core/navigations/navigation_service.dart';
import 'package:bloc_project_basic/core/widgets/common_app_snackbar.dart';
import 'package:bloc_project_basic/core/widgets/common_widgets.dart';
import 'package:bloc_project_basic/presentation/booking_screen/search_location_screen.dart';
import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/themes/app_text_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../logic/booking/booking_bloc.dart';
import '../../logic/booking/booking_event.dart';
import '../../logic/booking/booking_state.dart';
import '../../data/networks/response/status.dart';
import '../../logic/distance_bloc/distance_bloc.dart';
import '../../logic/distance_bloc/distance_event.dart';
import '../../logic/distance_bloc/distance_state.dart';
import '../cart_screen/cart_screen.dart';

class BookingScreen extends StatefulWidget {
  final String vehicleId;
  final double pricePerKm;
  final double pricePerDay;


  const BookingScreen({super.key, required this.vehicleId, required this.pricePerKm, required this.pricePerDay,});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TimeOfDay? pickupTime;
  double totalKm = 0;
  double totalPrice = 0;
  int extraDays = 0;

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropController = TextEditingController();
  final TextEditingController kmController = TextEditingController();
  final TextEditingController passengerController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  bool isDialogShown = false;

  DateTime? pickupDate;
  DateTime? returnDate;

  bool isRoundTrip = false;

  @override
  void initState() {
    super.initState();
    totalPrice = 0;
  }

  @override
  void dispose() {
    pickupController.dispose();
    dropController.dispose();
    kmController.dispose();
    passengerController.dispose();
    noteController.dispose();
   // removeOverlays();
    super.dispose();
  }

  void checkAndCalculate() {
    if (pickupController.text.isNotEmpty &&
        dropController.text.isNotEmpty) {

      context.read<DistanceBloc>().add(
        CalculateDistanceEvent(
          from: pickupController.text.trim(),
          to: dropController.text.trim(),
        ),
      );
    }
  }

  void calculateTotalPrice() {
    if (totalKm == 0) return;

    double finalKm = totalKm;

    // ROUND TRIP = always double km
    if (isRoundTrip) {
      finalKm = totalKm * 2;
    }
    double kmPrice = finalKm * widget.pricePerKm;

    // EXTRA DAYS (only extra days, no +1)
    extraDays = 0;

    if (isRoundTrip && pickupDate != null && returnDate != null) {
      DateTime start = DateTime(
        pickupDate!.year,
        pickupDate!.month,
        pickupDate!.day,
      );

      DateTime end = DateTime(
        returnDate!.year,
        returnDate!.month,
        returnDate!.day,
      );

      int days = end.difference(start).inDays;

      if (days > 0) {
        extraDays = days;
      }
    }

    double dayPrice = extraDays * widget.pricePerDay;
    totalPrice = kmPrice + dayPrice;
    setState(() {});
  }

  /// DATE PICKERS SAME
  Future<void> pickPickupDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() => pickupDate = date);
      calculateTotalPrice();
    }
  }


  Future<void> pickPickupTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        pickupTime = picked;
      });
    }
  }

  Future<void> pickReturnDate() async {
    DateTime initial;

    if (returnDate != null) {
      initial = returnDate!;
    } else if (pickupDate != null) {
      initial = pickupDate!;
    } else {
      initial = DateTime.now();
    }

    // Ensure initialDate >= firstDate
    DateTime first = pickupDate ?? DateTime.now();

    if (initial.isBefore(first)) {
      initial = first;
    }

    final date = await showDatePicker(
      context: context,
      firstDate: first,
      lastDate: DateTime(2100),
      initialDate: initial,
    );

    if (date != null) {
      setState(() => returnDate = date);
      calculateTotalPrice();
    }
  }

  void showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// ICON
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  ),
                ),

                CommonWidgets.verticalSpace(height: 15.h),

                /// TITLE
                Text(
                  StringConstants.bookingConfirmed,
                  style: AppTextStyle.titleStyle18bb,
                ),

                CommonWidgets.verticalSpace(height: 10.h),

                ///  MESSAGE (Professional )
                Text(
                  StringConstants.yourBookingSuccefullyCreated,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.titleStyle14bb.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),

                CommonWidgets.verticalSpace(height: 20.h),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();

                      isDialogShown = false;
                      context.read<BookingBloc>().add(ResetBookingEvent());

                      Future.delayed(const Duration(milliseconds: 200), () {
                        NavigationService.pushReplacementNamed(
                          AppRoutes.bookingHisory,
                        );
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.MainBlueColor,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:Text(StringConstants.viewBooking,style: AppTextStyle.titleStyle12bb.copyWith(color: AppColors.white),),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// SUBMIT
  void submitBooking() {
    print("ROUND TRIP VALUE => $isRoundTrip");
    print({
      "vehicleId": widget.vehicleId,
      "isRoundTrip": isRoundTrip,
    });
    if (pickupController.text.isEmpty ||
        dropController.text.isEmpty ||
        pickupDate == null ||
        kmController.text.isEmpty) {
      AppSnackBar.show(message: "Please fill required fields",
          type: SnackBarType.error
      );
      return;
    }

    if (pickupTime == null) {
      AppSnackBar.show(message: "Please Pickup Time",
          type: SnackBarType.error
      );
      return;
    }

    if (isRoundTrip && returnDate == null) {
      AppSnackBar.show(message: "Please select Return Date",
          type: SnackBarType.error
      );
      return;
    }

    context.read<BookingBloc>().add(
      CreateBookingEvent(
        body: {
          "vehicleId": widget.vehicleId,
          "pickupLocation": pickupController.text,
          "dropLocation": dropController.text,
          "pickupDate": pickupDate!.toIso8601String(),
          "returnDate": isRoundTrip ? returnDate?.toIso8601String() : null,
          "pickupTime": "${pickupTime!.hour.toString().padLeft(2, '0')}:${pickupTime!.minute.toString().padLeft(2, '0')}",
          "estimatedKm": totalKm,
          "estimatedAmount": totalPrice,
          "extraDays": extraDays,
          "isRoundTrip": isRoundTrip,
          "driverRequired": true,
          "specialNote": noteController.text,
          "passengers": passengerController.text.isEmpty ? 1: int.parse(passengerController.text),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        title: StringConstants.bookYourTrip,
        centerTitle: false,
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            if (state.createBookingResponse.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ElevatedButton(
              onPressed: submitBooking,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.MainBlueColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                StringConstants.confirmBooking,
                style: AppTextStyle.titleStyle18bb
                    .copyWith(color: AppColors.white),
              ),
            );
          },
        ),
      ),

      body: MultiBlocListener(
        listeners: [
          BlocListener<BookingBloc, BookingState>(
            listener: (context, state) {

              final status = state.createBookingResponse.status;
              if (status == Status.completed && !isDialogShown) {
                isDialogShown = true;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showSuccessDialog();
                });
              }

              if (status == Status.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.createBookingResponse.message ?? "Error"),
                  ),
                );
              }
            },
          ),

          /// KM AUTO FILL
          BlocListener<DistanceBloc, DistanceState>(
            listener: (context, state) {
              if (state.distanceResponse.status == Status.completed) {
                String kmText = state.distanceResponse.data ?? "0";
                kmController.text = kmText;
                totalKm = double.tryParse(kmText.split(" ").first) ?? 0;
                calculateTotalPrice();
              }
            },
          ),

        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(StringConstants.tripDetails, style: AppTextStyle.titleStyleLB18bb),
              CommonWidgets.verticalSpace(height: 10.h),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => DistanceBloc(),
                        child: SearchLocationScreen(isPickup: true),
                      ),
                    ),
                  );

                  if (result != null) {
                    pickupController.text = result;

                    // 🔥 distance calculate
                    checkAndCalculate();
                  }
                },
                child: AbsorbPointer(
                  child: _textField(
                    StringConstants.pickupLocation,
                    pickupController,
                    readOnly: true,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => DistanceBloc(),
                        child: SearchLocationScreen(isPickup: false),
                      ),
                    ),
                  );

                  if (result != null) {
                    dropController.text = result;

                    // 🔥 distance calculate
                    checkAndCalculate();
                  }
                },
                child: AbsorbPointer(
                  child: _textField(
                    StringConstants.dropLocation,
                    dropController,
                    readOnly: true,
                  ),
                ),
              ),

              _textField(StringConstants.totalDistanceInkm, kmController,
                  keyboardType: TextInputType.number,
                  readOnly: true),

              CommonWidgets.verticalSpace(height: 10.h),

              _pickerCard(
                title: pickupDate == null
                    ? StringConstants.selectPickupDate
                    : "${pickupDate!.day}/${pickupDate!.month}/${pickupDate!.year}",
                icon: Icons.calendar_today,
                onTap: pickPickupDate,
              ),

              CommonWidgets.verticalSpace(height: 10.h),

              _pickerCard(
                title: pickupTime == null
                    ? StringConstants.selectPickupTime
                    : pickupTime!.format(context),
                icon: Icons.access_time,
                onTap: pickPickupTime,
              ),

              CommonWidgets.verticalSpace(height: 10.h),

              Text(StringConstants.otherDetails , style: AppTextStyle.titleStyleLB18bb),
              CommonWidgets.verticalSpace(height: 10.h),

              _textField(StringConstants.totalPassanger, passengerController,
                  keyboardType: TextInputType.number),

              _textField('Notes', noteController),

              SwitchListTile(
                value: isRoundTrip,
                onChanged: (value) {
                  setState(() => isRoundTrip = value);
                 // updatePreviewPrice();
                  calculateTotalPrice();

                },
                title: Text(StringConstants.roundTrip,
                    style: AppTextStyle.titleStyle16bb),
              ),

              if (isRoundTrip)
                _pickerCard(
                  title: returnDate == null
                      ? StringConstants.selectReturnDate
                      : "${returnDate!.day}/${returnDate!.month}/${returnDate!.year}",
                  icon: Icons.calendar_today,
                  onTap: pickReturnDate,
                ),
              CommonWidgets.verticalSpace(height: 10.h),
              Text(
                "Your Trip Charges",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              if (totalKm > 0)
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.CardbackgoundColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Distance: $totalKm km",
                          style: AppTextStyle.titleStyle12bb.copyWith(color: AppColors.greys2)

                      ),

                      Text("Price/km: ₹${widget.pricePerKm}",
                          style: AppTextStyle.titleStyle12bb.copyWith(color: AppColors.greys2)
                      ),

                      if (extraDays > 0)
                        Text("Extra Days: $extraDays × ₹${widget.pricePerDay}",
                            style: AppTextStyle.titleStyle12bb.copyWith(color: AppColors.greys2)
                        ),

                      Divider(),

                      Text(
                        "Estimated Total: ₹${totalPrice.toStringAsFixed(0)}",
                        style: AppTextStyle.titleStyle18bb.copyWith(color: AppColors.orrangeMain),
                      ),

                      Text(
                        "Final price will be confirmed after booking",
                          style: AppTextStyle.titleStyle12bb.copyWith(color: AppColors.greys2)
                      ),
                    ],
                  ),
                ),

              CommonWidgets.verticalSpace(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  ///  UPDATED TEXT FIELD (logic added, UI same)
  Widget _textField(
      String hint,
      TextEditingController controller, {
        int maxLines = 1,
        TextInputType? keyboardType,
        bool readOnly = false,
        Function(String)? onChanged,
        Key? key,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        key: key,
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        readOnly: readOnly,
        onChanged: onChanged,

        style: AppTextStyle.titleStyle16bb
            .copyWith(color: AppColors.lightDarkTextDarkColor),

        cursorColor: AppColors.blue,

        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          filled: true,
          fillColor: AppColors.CardbackgoundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
            BorderSide(color: AppColors.lightDarkBorderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
            BorderSide(color: AppColors.blue, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _pickerCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.CardbackgoundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: AppColors.lightDarkBorderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.orrangeMain),
            CommonWidgets.verticalSpace(height: 6.h),
            Text(title,
                style: AppTextStyle.titleStyle16bb.copyWith(
                    color: AppColors.lightDarkTextDarkColor)),
          ],
        ),
      ),
    );
  }
}
