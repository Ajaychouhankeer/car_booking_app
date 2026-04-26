import 'package:bloc_project_basic/core/constants/string_constants.dart';
import 'package:bloc_project_basic/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project_basic/data/networks/response/status.dart';

import '../../core/colors/colors.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/about_bloc/about_bloc.dart';
import '../../logic/about_bloc/about_event.dart';
import '../../logic/about_bloc/about_state.dart';


class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        title: 'Contact Us',
        centerTitle: false,
      ),
      body: BlocListener<AboutBloc, AboutState>(
        listener: (context, state) {

          if (state.contactResponse.status == Status.completed) {
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
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 40,
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// TITLE
                        Text(
                          StringConstants.thankyouforContact,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// DESCRIPTION
                         Text(
                          StringConstants.responseSubmitteddSuccefully,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 20),

                        /// BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.MainBlueColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);

                              /// 🔥 CLEAR FORM
                              nameController.clear();
                              emailController.clear();
                              messageController.clear();
                            },
                            child:Text(StringConstants.close,style: AppTextStyle.titleStyle12bb.copyWith(color: AppColors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          if (state.contactResponse.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.contactResponse.message!)),
            );
          }
        },
        child: Column(
          children: [

            /// 🔥 TOP HEADER (GRADIENT)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff1D2671), AppColors.blue],
                 // colors: [Colors.orange, Colors.deepOrange],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child:  Column(
                children: [
                  Icon(Icons.support_agent, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    StringConstants.contactUs,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      StringConstants.contactHeaddingDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔥 FORM SECTION
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  color: AppColors.lightDarkCardGroundColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [

                        /// NAME
                        TextField(
                          controller: nameController,
                          style: TextStyle(
                            color: AppColors.lightDarkWhiteColor,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            labelText: StringConstants.fullName,
                            labelStyle: AppTextStyle.titleStyleLB12bb,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// EMAIL
                        TextField(
                          controller: emailController,
                          style: TextStyle(
                            color: AppColors.lightDarkWhiteColor,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email),
                            labelText: StringConstants.enterEmail,
                            labelStyle: AppTextStyle.titleStyleLB12bb,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// MESSAGE
                        TextField(
                          controller: messageController,
                          maxLines: 4,
                          style: TextStyle(
                            color: AppColors.lightDarkWhiteColor,
                          ),
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.message),
                            labelText: StringConstants.contactYourMassage,
                            labelStyle: AppTextStyle.titleStyleLB12bb,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 25),

                        /// 🔥 BUTTON
                        BlocBuilder<AboutBloc, AboutState>(
                          builder: (context, state) {

                            if (state.contactResponse.status == Status.loading) {
                              return Container(
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }

                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.MainBlueColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onPressed: () {
                                  context.read<AboutBloc>().add(
                                    SendContact({
                                      "name": nameController.text,
                                      "email": emailController.text,
                                      "message": messageController.text,
                                    }),
                                  );
                                },
                                child: Text(
                                  StringConstants.sendMassge,
                                  style: AppTextStyle.titleStyle16bb.copyWith(color: AppColors.white),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        /// EXTRA INFO
                        Text(
                          StringConstants.responsein24h,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
