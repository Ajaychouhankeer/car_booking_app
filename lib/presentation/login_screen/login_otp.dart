import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/navigations/navigation_service.dart';
import '../../router/app_router.dart';

class LoginOTP extends StatefulWidget {
  const LoginOTP({super.key});

  @override
  State<LoginOTP> createState() => _LoginOTPState();
}

class _LoginOTPState extends State<LoginOTP> {

  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50, left: 30,right: 30,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              SizedBox(height: 50.h),

              Text(
                "OTP Verification ",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                "Enter the Varification Code we just sent on you Email Address",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.black,

                ),
              ),

              SizedBox(height: 30.h),

              PinCodeTextField(
                appContext: context,
                length: 4,
                keyboardType: TextInputType.number,
                autoFocus: true,
                animationType: AnimationType.fade,

                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 55,
                  fieldWidth: 55,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  activeColor: Colors.black12,
                  inactiveColor: Colors.black12,
                  selectedColor: AppColors.primary,
                ),

                enableActiveFill: true,

                onChanged: (value) {},

                onCompleted: (value) {
                  print("OTP Entered: $value");
                },
              ),

              SizedBox(height: 20.h),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                  ),
                  onPressed: () {
                   // NavigationService.pushReplacementNamed(AppRoutes.home);
                    NavigationService.pushReplacementNamed(AppRoutes.mainScreen);
                  },

                  child: Text(
                    "VERIFY",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
