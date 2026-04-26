import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project_basic/data/networks/response/status.dart';

import '../../core/colors/colors.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/about_bloc/about_bloc.dart';
import '../../logic/about_bloc/about_event.dart';
import '../../logic/about_bloc/about_state.dart';
import 'common_shimmer_about.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_project_basic/data/networks/response/status.dart';

import '../../core/colors/colors.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/about_bloc/about_bloc.dart';
import '../../logic/about_bloc/about_event.dart';
import '../../logic/about_bloc/about_state.dart';
import 'common_shimmer_about.dart';

class HelpFaqScreen extends StatefulWidget {
  const HelpFaqScreen({super.key});

  @override
  State<HelpFaqScreen> createState() => _HelpFaqScreenState();
}

class _HelpFaqScreenState extends State<HelpFaqScreen> {

  @override
  void initState() {
    super.initState();
    context.read<AboutBloc>().add(FetchFaq());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightDarkBackgroundColor,

      appBar: CommonWidgets.appBar(
        backgroundColor: AppColors.lightDarkBackgroundColor,
        title: 'Help & FAQ',
        centerTitle: false,
      ),

      body: BlocBuilder<AboutBloc, AboutState>(
        builder: (context, state) {

          switch (state.faqResponse.status) {

            case Status.loading:
              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.lightDarkCardColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        ShimmerBox(height: 16, width: double.infinity),
                        SizedBox(height: 10),
                        ShimmerBox(height: 14, width: double.infinity),
                        SizedBox(height: 6),
                        ShimmerBox(height: 14, width: 200),
                      ],
                    ),
                  );
                },
              );

            case Status.completed:
              final faqList = state.faqResponse.data!.data;

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: faqList.length,
                itemBuilder: (context, index) {
                  return _faqCard(
                    question: faqList[index].question,
                    answer: faqList[index].answer,
                  );
                },
              );

            case Status.error:
              return Center(
                child: Text(state.faqResponse.message ?? "Error"),
              );

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  /// 🔥 Modern FAQ Card
  Widget _faqCard({required String question, required String answer}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
          AppColors.lightDarkCardColor,
          AppColors.lightDarkCardColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData().copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),

          /// Question
          title: Text(
            question,
            style: AppTextStyle.titleStyleLB14bb
          ),

          /// Icon Style
          iconColor: Colors.blue,
          collapsedIconColor: Colors.grey,

          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                answer,
                style: AppTextStyle.titleStyleLB12bb
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class HelpFaqScreen extends StatefulWidget {
//   const HelpFaqScreen({super.key});
//
//   @override
//   State<HelpFaqScreen> createState() => _HelpFaqScreenState();
// }
//
// class _HelpFaqScreenState extends State<HelpFaqScreen> {
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<AboutBloc>().add(FetchFaq());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.lightDarkBackgroundColor,
//       appBar: CommonWidgets.appBar(
//         backgroundColor: AppColors.lightDarkBackgroundColor,
//         title: 'Help & Faq',
//         centerTitle: false,
//       ),
//       body: BlocBuilder<AboutBloc, AboutState>(
//         builder: (context, state) {
//
//           switch (state.faqResponse.status) {
//
//             case Status.loading:
//               return ListView.builder(
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         ShimmerBox(height: 16, width: double.infinity),
//                         SizedBox(height: 8),
//                         ShimmerBox(height: 14, width: double.infinity),
//                         SizedBox(height: 8),
//                         ShimmerBox(height: 14, width: 200),
//                       ],
//                     ),
//                   );
//                 },
//               );
//
//             case Status.completed:
//               final faqList = state.faqResponse.data!.data;
//
//               return ListView.builder(
//                 itemCount: faqList.length,
//                 itemBuilder: (context, index) {
//                   return ExpansionTile(
//                     title: Text(faqList[index].question,style: AppTextStyle.titleStyleLB12bb,),
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: Text(faqList[index].answer,style: AppTextStyle.titleStyleLB12bb,),
//                       )
//                     ],
//                   );
//                 },
//               );
//
//             case Status.error:
//               return Center(
//                 child: Text(state.faqResponse.message ?? "Error"),
//               );
//
//             default:
//               return const SizedBox();
//           }
//         },
//       ),
//     );
//   }
// }
