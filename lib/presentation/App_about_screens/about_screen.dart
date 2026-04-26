import 'package:bloc_project_basic/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project_basic/data/networks/response/status.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors/colors.dart';
import '../../core/constants/image_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/about_bloc/about_bloc.dart';
import '../../logic/about_bloc/about_event.dart';
import '../../logic/about_bloc/about_state.dart';
import 'common_shimmer_about.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AboutBloc>().add(FetchAbout());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,
      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        title: 'About Us',
        centerTitle: false,
      ),
      body: BlocBuilder<AboutBloc, AboutState>(
        builder: (context, state) {

          switch (state.aboutResponse.status) {

            case Status.loading:
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const ShimmerBox(height: 100, width: 100, radius: 50),
                    const SizedBox(height: 20),
                    const ShimmerBox(height: 20, width: 150),
                    const SizedBox(height: 10),
                    const ShimmerBox(height: 14, width: double.infinity),
                    const SizedBox(height: 8),
                    const ShimmerBox(height: 14, width: double.infinity),
                    const SizedBox(height: 8),
                    const ShimmerBox(height: 14, width: 200),
                  ],
                ),
              );

            case Status.completed:
              final about = state.aboutResponse.data!.data;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        width: 200.w,
                       // height: 200.h,
                        ImageConstants.splashLogo,
                      ),

                      Divider(color: AppColors.dividerLightDarkColor),
                      Text(
                        about.title,
                          textAlign: TextAlign.start,
                        style:  AppTextStyle.titleStyleLB24bb
                      ),

                  
                      const SizedBox(height: 10),
                  
                      Text(
                        about.description,
                        textAlign: TextAlign.start,
                        style: AppTextStyle.titleStyleLB14bb,
                      ),
                  
                      const SizedBox(height: 20),
                  
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text("App Version",style: AppTextStyle.titleStyleLB14bb,),
                        subtitle: Text("1.0.0",style: AppTextStyle.titleStyleLB12bb,),
                      ),
                  
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text("Founded by",style: AppTextStyle.titleStyleLB14bb,),
                        subtitle: Text("Ajay Chouhan",style: AppTextStyle.titleStyleLB12bb,),
                      ),
                    ],
                  ),
                ),
              );

            case Status.error:
              return Center(
                child: Text(state.aboutResponse.message ?? "Error"),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}

// class AboutScreen extends StatelessWidget {
//   const AboutScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("About Us"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               backgroundImage: NetworkImage(
//                 "https://via.placeholder.com/150",
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "ToursGo",
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "ToursGo is a smart travel booking app where you can easily book cars, explore destinations, and enjoy your journey without hassle.",
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 20),
//             ListTile(
//               leading: const Icon(Icons.info),
//               title: const Text("Version"),
//               subtitle: const Text("1.0.0"),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text("Developed By"),
//               subtitle: const Text("Ajay Chouhan"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }