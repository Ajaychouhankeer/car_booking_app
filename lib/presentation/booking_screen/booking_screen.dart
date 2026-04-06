import 'package:bloc_project_basic/core/colors/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import '../../core/themes/app_text_style.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  String? selectedPayment;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  /// 📅 Pick Date
  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  /// ⏰ Pick Time
  Future<void> pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = selectedPayment != null;

    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      appBar: AppBar(
        title: const Text("Book Your Ride"),
        backgroundColor: Colors.white,
      ),

      /// 🔽 BOOK BUTTON
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: isButtonEnabled
              ? () {
            print("Booking Confirmed");
          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            disabledBackgroundColor: Colors.grey,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: const Text(
            "Confirm Booking",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔷 USER DETAILS
             Text(
              "Personal Details",
              style: AppTextStyle.titleStyleLB18bb,
            ),
            const SizedBox(height: 10),

            _textField("Full Name", nameController),
            _textField("Mobile Number", mobileController,
                keyboardType: TextInputType.phone),
            _textField("Address", addressController, maxLines: 2),

            const SizedBox(height: 20),

            /// 🔷 LOCATION
             Text(
              "Trip Details",
              style: AppTextStyle.titleStyleLB18bb,
            ),
            const SizedBox(height: 10),

            _textField("From Location", fromController),
            _textField("To Location", toController),

            const SizedBox(height: 10),

            /// 📅 DATE & TIME
            Row(
              children: [
                Expanded(
                  child: _pickerCard(
                    title: selectedDate == null
                        ? "Select Date"
                        : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                    icon: Icons.calendar_today,
                    onTap: pickDate,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _pickerCard(
                    title: selectedTime == null
                        ? "Select Time"
                        : selectedTime!.format(context),
                    icon: Icons.access_time,
                    onTap: pickTime,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔷 PAYMENT
             Text(
              "Payment Method",
              style: AppTextStyle.titleStyleLB18bb,
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _paymentCard("Cash", Icons.money),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _paymentCard("Online", Icons.payment),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// 🔹 TEXT FIELD
  Widget _textField(String hint, TextEditingController controller,
      {int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: AppColors.CardbackgoundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// 🔹 DATE / TIME CARD
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
          border: Border.all(color: AppColors.lightDarkBorderColor,width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.orange),
            const SizedBox(width: 6),
            Text(title, style: TextStyle(color:AppColors.lightDarkTextDarkColor)),
          ],
        ),
      ),
    );
  }

  /// 🔹 PAYMENT CARD
  Widget _paymentCard(String title, IconData icon) {
    bool isSelected = selectedPayment == title;

    return GestureDetector(
      onTap: () {
        setState(() => selectedPayment = title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                color: isSelected ? Colors.black : Colors.white),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}