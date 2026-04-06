import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/api_keys.dart';
import '../../core/constants/length.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/translations/translation_service.dart';
import '../../core/widgets/common_app_snackbar.dart';
import '../../core/widgets/common_widgets.dart';
import '../../data/local_data/local_data.dart';
import '../../router/app_router.dart';

class SelectLanguageScreen extends StatefulWidget {
  final Map<String, String> data;

  const SelectLanguageScreen({super.key, required this.data});

  @override
  State<SelectLanguageScreen> createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  String selectedLanguage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonWidgets.appBar(
        title: StringConstants.selectLanguage,
        centerTitle: false,
        wantBackButton:
        widget.data[ApiKeyConstants.from] != ApiKeyConstants.login,
      ),
      backgroundColor: AppColors.lightDarkBackgroundColor,
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringConstants.selectLangAppbarSubtitle,
              style: AppTextStyle.titleStyleLB12bm,
            ),

            SizedBox(height: 12.h),

            /// 🔹 Language List
            Expanded(
              child: ListView.builder(
                itemCount: LocalData.languageList.length,
                itemBuilder: (context, index) {
                  final language = LocalData.languageList[index];

                  final languageCode = language['language_code'];
                  final countryCode = language['country_code'];

                  final isSelected = selectedLanguage == languageCode;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedLanguage = languageCode;
                      });
                    },
                    child: _LanguageCard(
                      languageName: language['language_name'],
                      imagePath: language['language_image'],
                      isSelected: isSelected,
                    ),
                  );
                },
              ),
            ),

            /// 🔹 Button
            CommonWidgets.commonElevatedButton(
              onPressed: () async {
                if (selectedLanguage.isEmpty) {
                  AppSnackBar.show(
                    message: StringConstants.pleaseSelectLangToContinue,
                    type: SnackBarType.warning,
                  );
                  return;
                }

                final selected = LocalData.languageList.firstWhere(
                      (item) =>
                  item[ApiKeyConstants.languageCode] == selectedLanguage,
                );

                final pref = await SharedPreferences.getInstance();
                await pref.setString(
                    ApiKeyConstants.languageKey, selectedLanguage);
                await pref.setString(
                    ApiKeyConstants.countryCode,
                    selected[ApiKeyConstants.country_Code]);

                /// 🔥 Apply language
                TranslationService.changeLanguage(
                  selectedLanguage,
                  selected[ApiKeyConstants.country_Code],
                );

                /// 🔥 Navigation
                NavigationService.pushReplacementNamed(
                  AppRoutes.mainScreen,
                );
              },
              context: context,
              height: 48.h,
              width: AppLength.screenFullWidth(),
              child: Text(
                StringConstants.select,
                style: AppTextStyle.titleStyle16bw,
              ),
            ),

            SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}


/// --- Language Card Widget ---
class _LanguageCard extends StatelessWidget {
  final String languageName;
  final String imagePath;
  final bool isSelected;

  const _LanguageCard({
    required this.languageName,
    required this.imagePath,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 25.w),
      decoration: BoxDecoration(
        color: AppColors.lightDarkCardGroundColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isSelected
              ? AppColors.dividerLightDarkColor
              : AppColors.unselectedLightDarkBorder,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected ? AppColors.lightDarkWhiteColor : Colors.grey,
            size: 22.h,
          ),
          SizedBox(width: 12.w),
          Text(
            languageName,
            style: AppTextStyle.titleStyle18w.copyWith(
              color: isSelected
                  ? AppColors.lightDarkWhiteColor
                  : Colors.grey[800],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Spacer(),

          ColorFiltered(
            colorFilter: isSelected
                ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
                : const ColorFilter.matrix(<double>[
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0.2126,
              0.7152,
              0.0722,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            child: CommonWidgets.appIcons(
              assetName: imagePath,
              height: 66.h,
              width: 90.w,
            ),
          ),
        ],
      ),
    );
  }
}


// class SelectLanguageScreen extends StatelessWidget {
//   final Map<String, String> data;
//
//   const SelectLanguageScreen({super.key, required this.data});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<LoginBloc, LoginState>(
//       listener: (context, state) {},
//       child: BlocBuilder<LoginBloc, LoginState>(
//         builder: (context, state) {
//           return Scaffold(
//             appBar: CommonWidgets.appBar(
//               title: StringConstants.selectLanguage,
//               centerTitle: false,
//               wantBackButton:
//               data[ApiKeyConstants.from] == ApiKeyConstants.login
//                   ? false
//                   : true,
//             ),
//             backgroundColor: AppColors.lightDarkBackgroundColor,
//             body: SafeArea(
//               minimum: const EdgeInsets.only(left: 20, right: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     StringConstants.selectLangAppbarSubtitle,
//                     style: AppTextStyle.titleStyleLB12bm,
//                   ),
//                   CommonWidgets.verticalSpace(height: 12.h),
//
//                   /// --- Language List ---
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: LocalData.languageList.length,
//                     itemBuilder: (context, index) {
//                       final language = LocalData.languageList[index];
//                       final languageCode = language['language_code'].toString();
//                       final countryCode = language['country_code'].toString();
//                       final languageName = language['language_name'];
//                       final imagePath = language['language_image'];
//
//                       final isSelected = languageCode == state.language;
//
//                       return GestureDetector(
//                         onTap: () => _onLanguageSelected(
//                           context,
//                           languageCode,
//                           countryCode,
//                           data,
//                         ),
//                         child: _LanguageCard(
//                           languageName: languageName,
//                           imagePath: imagePath,
//                           isSelected: isSelected,
//                         ),
//                       );
//                     },
//                   ),
//
//                   Spacer(),
//
//                   CommonWidgets.commonElevatedButton(
//                     onPressed: () async {
//                       final current = state.language;
//
//                       if (current.isEmpty) {
//                         AppSnackBar.show(
//                           message: StringConstants.pleaseSelectLangToContinue,
//                           type: SnackBarType.warning,
//                         );
//                         return;
//                       }
//
//                       final countryCode = LocalData.languageList.firstWhere(
//                             (item) => item[ApiKeyConstants.languageCode] == current,
//                       )[ApiKeyConstants.country_Code];
//
//                       final pref = await SharedPreferences.getInstance();
//                       await pref.setString(
//                         ApiKeyConstants.languageKey,
//                         current,
//                       );
//                       await pref.setString(
//                         ApiKeyConstants.countryCode,
//                         countryCode,
//                       );
//
//                       TranslationService.changeLanguage(current, countryCode);
//                       final themeBloc = context.read<ThemeBloc>();
//
//                       if (data[ApiKeyConstants.from] == ApiKeyConstants.login) {
//                         if (themeBloc.state.isInvestorMode) {
//                           NavigationService.pushReplacementNamed(
//                             AppRoutes.mainScreen,
//                           );
//                         } else {
//                           NavigationService.pushReplacementNamed(
//                             AppRoutes.mainScreen,
//                           );
//                         }
//                       } else {
//                         final data = {
//                           "isInvestorMode": themeBloc.state.isInvestorMode,
//                         };
//                         NavigationService.pushAndRemoveUntil(
//                           AppRoutes.splash,
//                           arguments: data,
//                         );
//                       }
//                     },
//                     context: context,
//                     height: 48.h,
//                     width: AppLength.screenFullWidth(),
//                     child: Text(
//                       StringConstants.select,
//                       style: AppTextStyle.titleStyle16bw,
//                     ),
//                   ),
//
//                   CommonWidgets.verticalSpace(height: 8.h),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   /// Handle language selection and app flow
//   Future<void> _onLanguageSelected(
//       BuildContext context,
//       String languageCode,
//       String countryCode,
//       Map<String, String> data,
//       ) async {
//     final bloc = context.read<LoginBloc>();
//
//     bloc.add(
//       LoginSelectLanguage(
//         languageType: languageCode,
//         data: data,
//         countryCode: countryCode,
//       ),
//     );
//   }
// }
//
// /// --- Language Card Widget ---
// class _LanguageCard extends StatelessWidget {
//   final String languageName;
//   final String imagePath;
//   final bool isSelected;
//
//   const _LanguageCard({
//     required this.languageName,
//     required this.imagePath,
//     required this.isSelected,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 16.h),
//       padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 25.w),
//       decoration: BoxDecoration(
//         color: AppColors.lightDarkCardGroundColor,
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(
//           color: isSelected
//               ? AppColors.dividerLightDarkColor
//               : AppColors.unselectedLightDarkBorder,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.08),
//             blurRadius: 6,
//             spreadRadius: 1,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Icon(
//             isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
//             color: isSelected ? AppColors.lightDarkWhiteColor : Colors.grey,
//             size: 22.h,
//           ),
//           SizedBox(width: 12.w),
//           Text(
//             languageName,
//             style: AppTextStyle.titleStyle18w.copyWith(
//               color: isSelected
//                   ? AppColors.lightDarkWhiteColor
//                   : Colors.grey[800],
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           Spacer(),
//
//           ColorFiltered(
//             colorFilter: isSelected
//                 ? const ColorFilter.mode(Colors.transparent, BlendMode.multiply)
//                 : const ColorFilter.matrix(<double>[
//               0.2126,
//               0.7152,
//               0.0722,
//               0,
//               0,
//               0.2126,
//               0.7152,
//               0.0722,
//               0,
//               0,
//               0.2126,
//               0.7152,
//               0.0722,
//               0,
//               0,
//               0,
//               0,
//               0,
//               1,
//               0,
//             ]),
//             child: CommonWidgets.appIcons(
//               assetName: imagePath,
//               height: 66.h,
//               width: 90.w,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
