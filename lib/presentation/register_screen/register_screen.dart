import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/validators/input_validators.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/networks/response/status.dart';
import '../../logic/auth_bloc/auth_bloc.dart';
import '../../logic/auth_bloc/auth_event.dart';
import '../../logic/auth_bloc/auth_state.dart';
import '../../router/app_router.dart';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/validators/input_validators.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/auth_bloc/auth_bloc.dart';
import '../../logic/auth_bloc/auth_event.dart';
import '../../logic/auth_bloc/auth_state.dart';
import '../../router/app_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String countryCode = "+91";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 100),
                Text(
                  StringConstants.createAccount,
                  style: AppTextStyle.titleStyleLB24bb,
                ),
                SizedBox(height: 6.h),
                Text(
                  StringConstants.signUp,
                  style: AppTextStyle.titleStyleLB16bb,
                ),
                SizedBox(height: 30.h),
                CommonWidgets.verticalSpace(height: 30.h),

                /// NAME
                CommonWidgets.commonTextField(
                  controller: nameController,
                  hintText: StringConstants.fullName,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.person),
                  borderRadius: 50,
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                  validator: InputValidators.validateName,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),

                /// EMAIL
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

                /// MOBILE
                CommonWidgets.commonTextField(
                  controller: mobileController,
                  hintText: StringConstants.mobileNumber,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone),
                  borderRadius: 50,
                  contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                  validator: InputValidators.validatePhone,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                  ],
                ),

                /// PASSWORD (UPDATED ✅)
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
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                      ],
                      suffixIcon: InkWell(
                        onTap: () {
                          context
                              .read<AuthBloc>()
                              .add(TogglePasswordVisibilityEvent());
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

                CommonWidgets.verticalSpace(height: 30.h),
                CommonWidgets.verticalSpace(height: 30.h),

                /// REGISTER BUTTON (UPDATED ✅)
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    final response = state.authResponse;

                    if (response?.status == Status.completed) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              response?.data?.message ?? "Success"),
                        ),
                      );

                      NavigationService.pushNamed(AppRoutes.login);

                    } else if (response?.status == Status.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text(response?.message ?? "Error"),
                        ),
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
                              RegisterEvent({
                                "name":
                                nameController.text.trim(),
                                "email":
                                emailController.text.trim(),
                                "password": passwordController.text
                                    .trim(),
                                "phone":
                                mobileController.text.trim(),
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
                          StringConstants.register,
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

                CommonWidgets.verticalSpace(height: 70.h),
                CommonWidgets.verticalSpace(height: 70.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringConstants.iHaveAlreadyAccount,
                      style: AppTextStyle.titleStyleLB14bb,
                    ),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () {
                        NavigationService.pushNamed(AppRoutes.login);
                      },
                      child: Text(
                        StringConstants.login,
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







//
// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String countryCode = "+91";
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightDarkBackgroundColor,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 SizedBox(height: 100),
//                 Text(
//                   StringConstants.createAccount,
//                   style: AppTextStyle.titleStyleLB24bb,
//                 ),
//                 SizedBox(height: 6.h),
//                 Text(
//                   StringConstants.signUp,
//                   style: AppTextStyle.titleStyleLB16bb,
//                 ),
//                 SizedBox(height: 30.h),
//                 CommonWidgets.verticalSpace(height: 30.h),
//
//               ///name
//                 CommonWidgets.commonTextField(
//                   controller: nameController,
//                   hintText: StringConstants.fullName,
//                   keyboardType: TextInputType.emailAddress,
//                   prefixIcon: const Icon(Icons.person),
//                   borderRadius: 50,
//                   contentPadding: EdgeInsets.only(top: 10,bottom: 10),
//                   validator: InputValidators.validateName,
//                   autoValidateMode: AutovalidateMode.onUserInteraction,
//                 ),
//
//                ///email
//                 CommonWidgets.commonTextField(
//                   controller: emailController,
//                   hintText: StringConstants.email,
//                   keyboardType: TextInputType.emailAddress,
//                   prefixIcon: const Icon(Icons.email),
//                   borderRadius: 50,
//                   contentPadding: EdgeInsets.only(top: 10,bottom: 10),
//                   validator: InputValidators.validateEmail,
//                   autoValidateMode: AutovalidateMode.onUserInteraction,
//                 ),
//
//                 ///mobile
//                 CommonWidgets.commonTextField(
//                   controller: mobileController,
//                   hintText: StringConstants.mobileNumber,
//                   keyboardType: TextInputType.phone,
//                   prefixIcon: const Icon(Icons.phone),
//                   borderRadius: 50,
//                   contentPadding: EdgeInsets.only(top: 10,bottom: 10),
//                   validator: InputValidators.validatePhone,
//                   autoValidateMode: AutovalidateMode.onUserInteraction,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.digitsOnly, // only numbers
//                     LengthLimitingTextInputFormatter(10),   // max 10 digits
//                   ],
//                 ),
//
//                 ///password
//                 // CommonWidgets.commonTextField(
//                 //   controller: passwordController,
//                 //   hintText: StringConstants.password,
//                 //   keyboardType: TextInputType.emailAddress,
//                 //   prefixIcon: const Icon(Icons.password),
//                 //   borderRadius: 50,
//                 //   contentPadding: EdgeInsets.only(top: 10,bottom: 10),
//                 //   validator: InputValidators.validatePassword,
//                 //   autoValidateMode: AutovalidateMode.onUserInteraction,
//                 //   inputFormatters: [
//                 //     LengthLimitingTextInputFormatter(8), // max 8 chars
//                 //   ],
//                 // ),
//
//                 BlocBuilder<AuthBloc, AuthState>(
//                   builder: (context, state) {
//
//                     final isHidden = state is AuthInitial
//                         ? state.isPasswordHidden
//                         : (state is AuthLoading)
//                         ? state.isPasswordHidden
//                         : (state is AuthSuccess)
//                         ? state.isPasswordHidden
//                         : (state is AuthError)
//                         ? state.isPasswordHidden
//                         : true;
//
//                     return CommonWidgets.commonTextField(
//                       controller: passwordController,
//                       hintText: StringConstants.password,
//                       obscureText: isHidden,
//                       prefixIcon: const Icon(Icons.password),
//                       borderRadius: 50,
//                       contentPadding: EdgeInsets.only(top: 10,bottom: 10),
//                       validator: InputValidators.validatePassword,
//                       autoValidateMode: AutovalidateMode.onUserInteraction,
//                       inputFormatters: [
//                         LengthLimitingTextInputFormatter(8),
//                       ],
//
//                       suffixIcon: InkWell(
//                         onTap: () {
//                           context.read<AuthBloc>().add(TogglePasswordVisibilityEvent());
//                         },
//                         child: Icon(
//                           isHidden ? Icons.visibility_off : Icons.visibility,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 CommonWidgets.verticalSpace(height: 30.h),
//
//
//                 CommonWidgets.verticalSpace(height: 30.h),
//
//                 /// Register Button
//                 // SizedBox(
//                 //   width: double.infinity,
//                 //   child: ElevatedButton(
//                 //     style: ElevatedButton.styleFrom(
//                 //       backgroundColor: AppColors.blue,
//                 //       padding: EdgeInsets.symmetric(vertical: 14.h),
//                 //       shape: RoundedRectangleBorder(
//                 //         borderRadius: BorderRadius.circular(30.r),
//                 //       ),
//                 //     ),
//                 //     onPressed: () {
//                 //     },
//                 //     child: Text(
//                 //       StringConstants.register,
//                 //       style: TextStyle(
//                 //         fontSize: 16.sp,
//                 //         color: Colors.white,
//                 //         fontWeight: FontWeight.bold,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//
//                 BlocConsumer<AuthBloc, AuthState>(
//                   listener: (context, state) {
//                     if (state is AuthSuccess) {
//
//                       final token = state.model.data?.token;
//
//                       // ScaffoldMessenger.of(context).showSnackBar(
//                       //   SnackBar(content: Text(state.model.message ?? "Success")),
//                       // );
//
//                       /// Navigate to Home / Login
//                       NavigationService.pushNamed(AppRoutes.login);
//
//                     } else if (state is AuthError) {
//                       // ScaffoldMessenger.of(context).showSnackBar(
//                       //   SnackBar(content: Text(state.message)),
//                       // );
//                     }
//                   },
//
//                   builder: (context, state) {
//
//                     final isLoading = state is AuthLoading;
//
//                     return SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.blue,
//                           padding: EdgeInsets.symmetric(vertical: 14.h),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.r),
//                           ),
//                         ),
//                         // onPressed: isLoading ? null : () {
//                         //
//                         //   context.read<AuthBloc>().add(
//                         //     RegisterEvent({
//                         //       "name": nameController.text.trim(),
//                         //       "email": emailController.text.trim(),
//                         //       "password": passwordController.text.trim(),
//                         //       "phone": mobileController.text.trim(),
//                         //     }),
//                         //   );
//                         //
//                         // },
//
//                         onPressed: isLoading
//                             ? null
//                             : () {
//                           FocusScope.of(context).unfocus();
//
//                           if (_formKey.currentState!.validate()) {
//
//                             context.read<AuthBloc>().add(
//                               RegisterEvent({
//                                 "name": nameController.text.trim(),
//                                 "email": emailController.text.trim(),
//                                 "password": passwordController.text.trim(),
//                                 "phone": mobileController.text.trim(),
//                               }),
//                             );
//
//                           } else {
//                             print("Validation Failed");
//                           }
//                         },
//
//                         child: isLoading
//                             ? SizedBox(
//                           height: 20.h,
//                           width: 20.h,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         )
//                             : Text(
//                           StringConstants.register,
//                           style: TextStyle(
//                             fontSize: 16.sp,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//
//                 CommonWidgets.verticalSpace(height: 70.h),
//
//                 CommonWidgets.verticalSpace(height: 70.h),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//
//                     Text(
//                       StringConstants.iHaveAlreadyAccount,
//                       style: AppTextStyle.titleStyleLB14bb,
//                     ),
//
//                     SizedBox(width: 5.w),
//
//                     GestureDetector(
//                       onTap: () {
//                         NavigationService.pushNamed(AppRoutes.login);
//                       },
//
//                       child: Text(
//                         StringConstants.login,
//                         style: TextStyle(
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


