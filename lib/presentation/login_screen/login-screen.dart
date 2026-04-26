import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/networks/response/status.dart';
import '../../logic/auth_bloc/auth_bloc.dart';
import '../../logic/auth_bloc/auth_event.dart';
import '../../logic/auth_bloc/auth_state.dart';
import '../../router/app_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/validators/input_validators.dart'; // ✅ NEW
import '../../core/widgets/common_widgets.dart';
import '../../logic/auth_bloc/auth_bloc.dart';
import '../../logic/auth_bloc/auth_event.dart';
import '../../logic/auth_bloc/auth_state.dart';
import '../../router/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // ✅ NEW

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w),

          child: Form(
            // ✅ NEW
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                // SizedBox(height: 40.h),
                SizedBox(height: 20.h),
                Image.asset(
                  width: 200.w,
                  height: 200.h,
                  ImageConstants.splashLogo,
                ),

                SizedBox(height: 20.h),

                Text(
                  StringConstants.welcomeBack,
                  style: AppTextStyle.titleStyleLB24bb,
                ),

                SizedBox(height: 6.h),

                Text(
                  StringConstants.loginToContinue,
                  style: AppTextStyle.titleStyleLB16bb,
                ),

                SizedBox(height: 30.h),

                /// EMAIL ✅ VALIDATION ADDED
                CommonWidgets.commonTextField(
                  controller: emailController,
                  hintText: StringConstants.email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                  borderRadius: 50,
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                  validator: InputValidators.validateEmail,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),

                /// PASSWORD ✅ WITH HIDE/SHOW + VALIDATION
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return CommonWidgets.commonTextField(
                      controller: passwordController,
                      hintText: StringConstants.password,
                      obscureText: state.isPasswordHidden,
                      prefixIcon: const Icon(Icons.password),
                      borderRadius: 50,
                      contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                      validator: InputValidators.validatePassword,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: [LengthLimitingTextInputFormatter(20)],
                      suffixIcon: InkWell(
                        onTap: () {
                          context.read<AuthBloc>().add(
                            TogglePasswordVisibilityEvent(),
                          );
                        },
                        child: Icon(
                          state.isPasswordHidden
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 20.h),

                /// LOGIN BUTTON ✅ UPDATED
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    final response = state.authResponse;

                    if (response?.status == Status.completed) {
                     // NavigationService.pushNamed(AppRoutes.mainScreen);
                      NavigationService.pushAndRemoveUntil(AppRoutes.mainScreen);
                    } else if (response?.status == Status.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(response?.message ?? "Error")),
                      );
                    }
                  },

                  builder: (context, state) {
                    final isLoading =
                        state.authResponse?.status == Status.loading;

                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.MainBlueColor,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),

                        onPressed: isLoading
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();

                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    LoginEvent({
                                      "email": emailController.text.trim(),
                                      "password": passwordController.text
                                          .trim(),
                                    }),
                                  );
                                }
                              },

                        child: isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                StringConstants.login,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    );
                  },
                ),

                // SizedBox(height: 120.h),
                SizedBox(height: 40.h),

                /// SIGN UP (UNCHANGED ✅)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.doNotHaveAnAccount,
                      style: AppTextStyle.titleStyleLB12bb,
                    ),

                    SizedBox(width: 5.w),

                    GestureDetector(
                      onTap: () {
                        NavigationService.pushNamed(AppRoutes.register);
                      },

                      child: Text(
                        StringConstants.signUp,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.MainBlueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
