import 'dart:io';

import 'package:bloc_project_basic/core/colors/colors.dart';
import 'package:bloc_project_basic/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/string_constants.dart';
import '../../core/widgets/common_app_snackbar.dart';
import '../../core/widgets/common_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/networks/response/status.dart';
import '../../logic/payment_bloc/payment_bloc.dart';
import '../../logic/payment_bloc/payment_event.dart';
import '../../logic/payment_bloc/payment_state.dart';
import '../main_screen/main_navigation_screen.dart';


class PaymentScreen extends StatefulWidget {
  final dynamic amount;
  final Map<String, dynamic> bookingData;

  const PaymentScreen({
    super.key,
    required this.amount,
    required this.bookingData,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}


class _PaymentScreenState extends State<PaymentScreen> {
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    print("BOOKING DATA 👉 ${widget.bookingData}");
    context.read<PaymentBloc>().add(GetPaymentDetailsEvent());
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  void showBookingConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // user manually band na kare
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// ✅ SUCCESS ICON
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 50,
                  ),
                ),

                const SizedBox(height: 16),

                /// 🔥 TITLE
                 Text(
                  StringConstants.paymentSubmitted,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                /// 💬 DESCRIPTION
                 Text(StringConstants.paymentProofSubmittedMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 20),

                /// 🚀 BUTTON
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // dialog close

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MainNavigationScreen(initialIndex: 2),
                        ),
                            (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.MainBlueColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                        StringConstants.okGotIt,
                      style: AppTextStyle.titleStyleLB12bb.copyWith(color: AppColors.white)
                    ),
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
  Widget build(BuildContext context) {
    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {

        /// ✅ SUCCESS
        if (state.uploadResponse.status == Status.completed) {
          if (ModalRoute.of(context)?.isCurrent ?? false) {
            showBookingConfirmationDialog(context);
          }
        }

        /// ❌ ERROR
        if (state.uploadResponse.status == Status.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.uploadResponse.message ?? "Upload Failed"),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        appBar: CommonWidgets.appBar(
          backgroundColor: AppColors.lightDarkBackgroundColor,
          title: StringConstants.payment,
          centerTitle: false,
        ),

        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            final selectedMethod = state.selectedMethod;

            final isUploading = state.uploadResponse.status == Status.loading;

            String buttonText = selectedMethod == StringConstants.cash ? StringConstants.confirmBooking : StringConstants.makePayment;

            if (state.paymentResponse.status == Status.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.paymentResponse.status == Status.error) {
              return Center(
                  child: Text(state.paymentResponse.message ?? "Error"));
            }

            if (state.paymentResponse.status == Status.completed) {
              final data = state.paymentResponse.data!.data;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [

                      /// 💰 AMOUNT CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.MainBlueColor.withOpacity(0.8),
                              AppColors.MainBlueColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Column(
                          children: [
                             Text(StringConstants.totalAmount,
                                style: TextStyle(color: Colors.white70)),
                            const SizedBox(height: 5),
                            Text(
                              "₹${widget.amount}",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// PAYMENT OPTIONS
                      _paymentTile(StringConstants.upiPayment, Icons.account_balance_wallet, state),
                      if (selectedMethod == "UPI")
                      //_upiView(data.upiId,),
                        _upiView(data.upiId, double.parse(widget.amount
                            .toString())),

                      _paymentTile(StringConstants.qrCode, Icons.qr_code, state),
                      if (selectedMethod == "QR Code")
                        _qrView(data.qrCodeUrl),

                      _paymentTile(StringConstants.netBanking, Icons.account_balance, state),
                      if (selectedMethod == "Net Banking")
                        _bankView(data),

                      _paymentTile(StringConstants.cash, Icons.money, state),


                      if (selectedMethod != "Cash") ...[
                        const SizedBox(height: 10),

                        /// 📸 SELECT IMAGE
                        GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                style: BorderStyle.solid,
                              ),
                              color: Colors.grey.shade50,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                    Icons.upload_file, color: Colors.blue),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    selectedImage == null
                                        ? StringConstants.uploadPaymentProof
                                        : StringConstants.imageSelected,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 14),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// 🖼 PREVIEW
                        if (selectedImage != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              selectedImage!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                      ],

                      const SizedBox(height: 20),

                      /// BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isUploading
                              ? null
                              : () {
                            if (selectedMethod == "Cash") {
                              // normal booking confirm
                            } else {
                              if (selectedImage == null) {
                                AppSnackBar.show(
                                  message: StringConstants.selectPaymentScreenshot,
                                  type: SnackBarType.info,
                                );
                                return;
                              }

                              /// 🔥 CALL BLOC
                              context.read<PaymentBloc>().add(
                                UploadPaymentScreenshotEvent(
                                  bookingId:
                                  widget.bookingData["_id"]?.toString() ?? "",
                                  image: selectedImage!,
                                ),
                              );
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: AppColors.MainBlueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),

                          /// 🔥 IMPORTANT CHANGE (LOADER)
                          child: isUploading
                              ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : Text(
                            buttonText,
                            style: AppTextStyle.titleStyleLB16bb
                                .copyWith(color: AppColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  /// 🔹 PAYMENT TILE (BLOC CONTROLLED)
  Widget _paymentTile(String title, IconData icon, PaymentState state) {
    return GestureDetector(
      onTap: () {
        context.read<PaymentBloc>().add(
          SelectPaymentMethodEvent(title),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.CardbackgoundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: state.selectedMethod == title
                ? AppColors.orrangeMain
                : Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.orrangeMain),
            const SizedBox(width: 10),
            Expanded(
              child: Text(title, style: AppTextStyle.titleStyle16bb),
            ),
            Radio(
              value: title,
              groupValue: state.selectedMethod,
              onChanged: (value) {
                context.read<PaymentBloc>().add(
                  SelectPaymentMethodEvent(value.toString()),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  /// 🔹 UPI VIEW


  Widget _upiView(String upiId, double amount) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade50,
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔹 HEADER
          Row(
            children: [
              const Icon(Icons.account_balance_wallet, color: Colors.green),
              const SizedBox(width: 8),
               Text(
                StringConstants.upiPayment,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),

              /// 🔥 TAP BADGE
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  StringConstants.tapToPay,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue,
                  ),
                ),
              )
            ],
          ),

          const SizedBox(height: 12),

          /// 🔹 UPI ID ROW
          GestureDetector(
            onTap: () async {
              final uri = Uri.parse(
                "upi://pay?pa=$upiId&pn=CarBooking&am=$amount&cu=INR",
              );

              await launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      upiId,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  /// COPY BUTTON
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: upiId));
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(StringConstants.upiCopied)),
                      );
                    },
                    child: const Icon(Icons.copy, size: 18, color: Colors.grey),
                  ),

                  const SizedBox(width: 8),

                  /// 👉 ARROW ICON
                  const Icon(
                      Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// 🔹 HELPER TEXT
          Row(
            children:  [
              Icon(Icons.info_outline, size: 14, color: Colors.grey),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                  StringConstants.upiPaymentHint,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔹 QR VIEW
  Widget _qrView(String qrUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Image.network(qrUrl, height: 250),
      ),
    );
  }

  /// 🔹 BANK DETAILS
  Widget _bankView(dynamic data) {
    final bank = data.bankDetails;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${StringConstants.accountHolder}: ${bank.holderName}"),
          Text("${StringConstants.accountNo}: ${bank.accountNumber}"),
          Text("${StringConstants.ifsc}: ${bank.ifsc}"),
        ],
      ),
    );
  }
}
