import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/widgets/common_widgets.dart';
import '../../router/app_router.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  State<AuthLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<AuthLoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              SizedBox(height: 100.h),

              /// Title
              Text(
                "Welcome Back",
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.black,
                ),
              ),

              SizedBox(height: 30.h),

              /// Email Field
              CommonWidgets.commonTextField(
                controller: emailController,
                hintText: StringConstants.email,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
              ),

              CommonWidgets.verticalSpace(height: 30.h),

              /// Password Field
              CommonWidgets.commonTextField(
                controller: passwordController,
                hintText: StringConstants.password,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: const Icon(Icons.remove_red_eye),
              ),

              CommonWidgets.verticalSpace(height: 10.h),

              /// Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              CommonWidgets.verticalSpace(height: 30.h),

              /// Login Button
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
                    // // Trigger Bloc login
                    // final email = emailController.text.trim();
                    // final password = passwordController.text.trim();
                    //
                    // if (email.isEmpty || password.isEmpty) {
                    //   CommonWidgets.showSnackBar(context, "Please fill all fields");
                    //   return;
                    // }
                    //
                    // context.read<AuthBloc>().add(
                    //   AuthLoginEvent(email: email, password: password),
                    // );
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              CommonWidgets.verticalSpace(height: 70.h),

              /// Social login text
              Text(
                "Or continue with",
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.black,
                ),
              ),

              SizedBox(height: 20.h),

              /// Social Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /// Apple
                  Column(
                    children: [
                      Image.asset(ImageConstants.apple),
                      SizedBox(height: 8.h),
                      const Text("Apple"),
                    ],
                  ),

                  /// Google
                  Column(
                    children: [
                      Image.asset(ImageConstants.google),
                      SizedBox(height: 8.h),
                      const Text("Google"),
                    ],
                  ),

                  /// Facebook
                  Column(
                    children: [
                      Image.asset(ImageConstants.facebook),
                      SizedBox(height: 8.h),
                      const Text("Facebook"),
                    ],
                  ),
                ],
              ),

              CommonWidgets.verticalSpace(height: 30.h),

              /// Register Option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      NavigationService.pushNamed(AppRoutes.register);
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class AuthLoginScreen extends StatefulWidget {
//   const AuthLoginScreen({super.key});
//
//   @override
//   State<AuthLoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<AuthLoginScreen> {
//
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//
//           child: Column(
//             children: [
//
//               SizedBox(height: 100),
//
//               /// Title
//               Text(
//                 "Welcome Back",
//                 style: TextStyle(
//                   fontSize: 25.sp,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.black,
//                 ),
//               ),
//
//               SizedBox(height: 6.h),
//
//               Text(
//                 "Login to your account",
//                 style: TextStyle(
//                   fontSize: 16.sp,
//                   color: AppColors.black,
//                 ),
//               ),
//
//               SizedBox(height: 40.h),
//
//               /// Email Field
//               CommonWidgets.commonTextField(
//                 controller: emailController,
//                 hintText: StringConstants.email,
//                 keyboardType: TextInputType.emailAddress,
//                 prefixIcon: const Icon(Icons.email),
//               ),
//
//               CommonWidgets.verticalSpace(height: 30.h),
//
//               /// Password Field
//               CommonWidgets.commonTextField(
//                 controller: passwordController,
//                 hintText: StringConstants.password,
//                 keyboardType: TextInputType.text,
//                 prefixIcon: const Icon(Icons.lock),
//                 suffixIcon: const Icon(Icons.remove_red_eye),
//               ),
//
//               CommonWidgets.verticalSpace(height: 10.h),
//
//               /// Forgot Password
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Text(
//                   "Forgot Password?",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     color: AppColors.blue,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//
//               CommonWidgets.verticalSpace(height: 30.h),
//
//               /// Login Button
//               SizedBox(
//                 width: double.infinity,
//
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.blue,
//                     padding: EdgeInsets.symmetric(vertical: 14.h),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.r),
//                     ),
//                   ),
//
//                   onPressed: () {
//                     NavigationService.pushNamed(AppRoutes.home);
//                   },
//
//                   child: Text(
//                     "LOGIN",
//                     style: TextStyle(
//                       fontSize: 16.sp,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//
//               CommonWidgets.verticalSpace(height: 70.h),
//
//               /// Social login text
//               Text(
//                 "Or continue with",
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   color: AppColors.black,
//                 ),
//               ),
//
//               SizedBox(height: 20.h),
//
//               /// Social Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//
//                   /// Apple
//                   Column(
//                     children: [
//                       Image.asset(ImageConstants.apple),
//                       SizedBox(height: 8.h),
//                       const Text("Apple"),
//                     ],
//                   ),
//
//                   /// Google
//                   Column(
//                     children: [
//                       Image.asset(ImageConstants.google),
//                       SizedBox(height: 8.h),
//                       const Text("Google"),
//                     ],
//                   ),
//
//                   /// Facebook
//                   Column(
//                     children: [
//                       Image.asset(ImageConstants.facebook),
//                       SizedBox(height: 8.h),
//                       const Text("Facebook"),
//                     ],
//                   ),
//
//                 ],
//               ),
//
//               CommonWidgets.verticalSpace(height: 30.h),
//
//               /// Register Option
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//
//                   const Text("Don't have an account? "),
//
//                   GestureDetector(
//                     onTap: () {
//                       NavigationService.pushNamed(AppRoutes.register);
//                     },
//                     child: Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: AppColors.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   )
//
//                 ],
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }