

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

///NEW (Suggestion Keys + Overlay)
final GlobalKey pickupKey = GlobalKey();
final GlobalKey dropKey = GlobalKey();

OverlayEntry? pickupOverlay;
OverlayEntry? dropOverlay;

DateTime? pickupDate;
DateTime? returnDate;

bool isRoundTrip = false;

@override
void initState() {
super.initState();

    pickupController.addListener(checkAndCalculate);
    dropController.addListener(checkAndCalculate);
    totalPrice = 0;
}

@override
void dispose() {
pickupController.dispose();
dropController.dispose();
kmController.dispose();
passengerController.dispose();
noteController.dispose();
removeOverlays();
super.dispose();
}

void updatePreviewPrice() {
if (totalKm == 0) return;

    double km = totalKm;
    double kmPrice = km * widget.pricePerKm;

    int totalDays = 1;

    if (pickupDate != null && returnDate != null) {
      DateTime start = DateTime(pickupDate!.year, pickupDate!.month, pickupDate!.day);
      DateTime end = DateTime(returnDate!.year, returnDate!.month, returnDate!.day);

      totalDays = end.difference(start).inDays + 1;
    }

    double dayPrice = totalDays * widget.pricePerDay;

    totalPrice = kmPrice + dayPrice;

    setState(() {});
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
print("PRICE PER DAY: ${widget.pricePerDay}");
print("EXTRA DAYS: $extraDays");
if (totalKm == 0) return;

    double finalKm = totalKm;
//  Round Trip only if return date selected
if (isRoundTrip && returnDate != null) {
// finalKm = totalKm * 2;
}

    double kmPrice = finalKm * widget.pricePerKm;

    // 👉 Extra days calculation
    extraDays = 0;

    if (isRoundTrip && pickupDate != null && returnDate != null) {
      //int days = returnDate!.difference(pickupDate!).inDays;

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

      int days = end.difference(start).inDays + 1;

      if (days > 0) {
        extraDays = days;
      } else {
        extraDays = 0;
      }
    }

    double dayPrice = extraDays * widget.pricePerDay;

    totalPrice = kmPrice + dayPrice;

    setState(() {});
}

/// OVERLAY REMOVE
void removeOverlays() {
pickupOverlay?.remove();
pickupOverlay = null;
dropOverlay?.remove();
dropOverlay = null;
}

/// SHOW OVERLAY
void showOverlay({
required BuildContext context,
required RenderBox renderBox,
required List<String> suggestions,
required TextEditingController controller,
required bool isPickup,
}) {
final overlay = Overlay.of(context);

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    OverlayEntry entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          left: offset.dx,
          top: offset.dy + size.height + 5,
          width: size.width,
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: stateLoadingWidget(
                isLoading: isPickup
                    ? context.read<DistanceBloc>().state.isFromLoading
                    : context.read<DistanceBloc>().state.isToLoading,
                suggestions: suggestions,
                controller: controller,
                isFrom: isPickup,
              ),
            ),
          ),
        );
      },
    );

    overlay.insert(entry);

    if (isPickup) {
      pickupOverlay?.remove();
      pickupOverlay = entry;
    } else {
      dropOverlay?.remove();
      dropOverlay = entry;
    }
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
      updatePreviewPrice();
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
final date = await showDatePicker(
context: context,
firstDate: pickupDate ?? DateTime.now(),
lastDate: DateTime(2100),
initialDate: pickupDate ?? DateTime.now(),
);

    if (date != null) {
      setState(() => returnDate = date);
      updatePreviewPrice();
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
if (pickupController.text.isEmpty ||
dropController.text.isEmpty ||
pickupDate == null ||
kmController.text.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text("Please fill required fields")),
);
return;
}

    if (pickupTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select pickup time")),
      );
      return;
    }

    if (isRoundTrip && returnDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select return date")),
      );
      return;
    }

    // context.read<BookingBloc>().add(
    //   CreateBookingEvent(
    //     body: {
    //       "vehicleId": widget.vehicleId,
    //       "pickupLocation": pickupController.text,
    //       "dropLocation": dropController.text,
    //       "pickupDate": pickupDate!.toIso8601String(),
    //       "returnDate": isRoundTrip ? returnDate?.toIso8601String() : null,
    //       "pickupTime": "${pickupTime!.hour.toString().padLeft(2, '0')}:${pickupTime!.minute.toString().padLeft(2, '0')}",
    //      // "estimatedKm": int.parse(kmController.text.replaceAll(" km", "")),
    //       "estimatedKm": double.parse(kmController.text.replaceAll(" km", ""),),
    //       "driverRequired": true,
    //       "specialNote": noteController.text,
    //       "passengers": passengerController.text.isEmpty
    //           ? 1
    //           : int.parse(passengerController.text),
    //     },
    //   ),
    // );

    context.read<BookingBloc>().add(
      CreateBookingEvent(
        body: {
          "vehicleId": widget.vehicleId,
          "pickupLocation": pickupController.text,
          "dropLocation": dropController.text,
          "pickupDate": pickupDate!.toIso8601String(),
          "returnDate": isRoundTrip ? returnDate?.toIso8601String() : null,
          "pickupTime": "${pickupTime!.hour.toString().padLeft(2, '0')}:${pickupTime!.minute.toString().padLeft(2, '0')}",
          "estimatedKm": totalKm,   // 👈 FIX (use calculated km, not text parse)
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
               // kmController.text = state.distanceResponse.data ?? "";
               //  String kmText = state.distanceResponse.data ?? "0";
               //  kmController.text = kmText;
                String kmText = state.distanceResponse.data ?? "0";
                kmController.text = kmText;
                // YAHI ADD KARNA HAI 👇
                totalKm = double.tryParse(kmText.split(" ").first) ?? 0;
                updatePreviewPrice();
                calculateTotalPrice();

                // totalPrice = totalKm * widget.pricePerKm;
                //
                // setState(() {});
              }
            },
          ),

          /// PICKUP SUGGESTION
          BlocListener<DistanceBloc, DistanceState>(
            listenWhen: (p, c) => p.fromSuggestions != c.fromSuggestions,
            listener: (context, state) {
              if (state.fromSuggestions.isNotEmpty) {
                final box = pickupKey.currentContext!.findRenderObject() as RenderBox;
                showOverlay(
                  context: context,
                  renderBox: box,
                  suggestions: state.fromSuggestions,
                  controller: pickupController,
                  isPickup: true,
                );
              } else {
                pickupOverlay?.remove();
              }
            },
          ),

          /// DROP SUGGESTION
          BlocListener<DistanceBloc, DistanceState>(
            listenWhen: (p, c) => p.toSuggestions != c.toSuggestions,
            listener: (context, state) {
              if (state.toSuggestions.isNotEmpty) {
                final box = dropKey.currentContext!.findRenderObject() as RenderBox;
                showOverlay(
                  context: context,
                  renderBox: box,
                  suggestions: state.toSuggestions,
                  controller: dropController,
                  isPickup: false,
                );
              } else {
                dropOverlay?.remove();
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

              /// PICKUP FIELD UPDATED
              _textField(StringConstants.pickupLocation, pickupController,
                  key: pickupKey,
                  onChanged: (v) {
                    context.read<DistanceBloc>()
                        .add(FetchFromSuggestionsEvent(v));
                  }),

              ///  DROP FIELD UPDATED
              _textField(StringConstants.dropLocation, dropController,
                  key: dropKey,
                  onChanged: (v) {
                    context.read<DistanceBloc>()
                        .add(FetchToSuggestionsEvent(v));
                  }),

              _textField(StringConstants.totalDistanceInkm, kmController,
                  keyboardType: TextInputType.number,
                  readOnly: true),
              CommonWidgets.verticalSpace(height: 10.h),

              Text(
                "Live Fare Estimate",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              // if (totalKm > 0)
              //   Container(
              //     padding: EdgeInsets.all(14),
              //     margin: EdgeInsets.only(bottom: 12),
              //     decoration: BoxDecoration(
              //       color: AppColors.CardbackgoundColor,
              //       borderRadius: BorderRadius.circular(12),
              //       border: Border.all(color: AppColors.lightDarkBorderColor),
              //     ),
              //     child: Text(
              //       "Total Amount: ₹$totalPrice",
              //       style: AppTextStyle.titleStyle18bb.copyWith(
              //         color: AppColors.orrangeMain,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //
              //   ),

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

                      Text("Distance: $totalKm km"),

                      Text("Price/km: ₹${widget.pricePerKm}"),

                      if (extraDays > 0)
                        Text("Extra Days: $extraDays × ₹${widget.pricePerDay}"),

                      Divider(),

                      Text(
                        "Estimated Total: ₹${totalPrice.toStringAsFixed(0)}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),

                      Text(
                        "Final price will be confirmed after booking",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),

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
                  updatePreviewPrice();
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
Icon(icon, color: AppColors.MainBlueColor),
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
