import 'package:bloc_project_basic/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/colors/colors.dart';
import '../../core/constants/api_keys.dart';
import '../../core/constants/icons_constant.dart';
import '../../core/constants/string_constants.dart';
import '../../core/navigations/navigation_service.dart';
import '../../core/themes/app_text_style.dart';
import '../../core/widgets/common_app_snackbar.dart';
import '../../core/widgets/common_widgets.dart';
import '../../logic/themes/theme_bloc.dart';


class ThemeSettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.lightWhiteDarkBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            border: Border(
              top: BorderSide(
                width: 1.w,
                color: AppColors.dividerLightDarkColor,
              ),
            ),
          ),

          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),

            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Header Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          StringConstants.selectAppTheme,
                          style: AppTextStyle.titleStyle18bb.copyWith(
                            color: AppColors.unReadTitleLightDarkTextColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),

                        InkWell(
                          onTap: () {
                            NavigationService.pop();
                          },
                          child: CommonWidgets.svgIcon(
                            IconConstants.icCloseCircular,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                    CommonWidgets.verticalSpace(height: 4.h),

                    Text(
                      StringConstants.selectAppThemeDesc,
                      style: AppTextStyle.titleStyle12b.copyWith(
                        color: AppColors.lightDarkGreyColorForText,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    CommonWidgets.verticalSpace(height: 16.h),

                    Divider(
                      height: 1.h,
                      color: AppColors.dividerLightDarkColor,
                    ),

                    CommonWidgets.verticalSpace(height: 16.h),

                    SizedBox(
                      height: 208.h,
                      child: ListView.builder(
                        itemCount: state.themeList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final theme = state.themeList[index];
                          final isSelected = theme == state.selectedTheme;

                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              context.read<ThemeBloc>().add(
                                ToggleTheme(theme: theme),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(bottom: 8),
                              height: 64.h,
                              decoration: BoxDecoration(
                                border: AppColors.isDark
                                    ? null
                                    : Border.all(
                                  width: 1,
                                  color: AppColors.lightgrey,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: AppColors.lightDarkBaseColor,
                              ),
                              child: Row(
                                children: [
                                  Radio<String>(
                                    value: theme,
                                    groupValue: state.selectedTheme,
                                    activeColor:
                                    AppColors.unReadTitleLightDarkTextColor,
                                    onChanged: (_) {
                                      context.read<ThemeBloc>().add(
                                        ToggleTheme(theme: theme),
                                      );
                                    },
                                  ),

                                  CommonWidgets.horizontalSpace(width: 8.w),

                                  Text(
                                    theme.tr,
                                    style: AppTextStyle.titleStyle16bb.copyWith(
                                      color: isSelected
                                          ? AppColors.unReadTitleLightDarkTextColor
                                          : AppColors.greys2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    CommonWidgets.verticalSpace(height: 16.h),

                    /// Apply Button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 34),
                      child: CommonWidgets.commonElevatedButton(
                        onPressed: () {
                          ThemeMode selectedMode;
                          switch (state.selectedTheme) {
                            case ApiKeyConstants.light:
                              selectedMode = ThemeMode.light;
                              AppSnackBar.show(
                                message:
                                StringConstants.themeUpdatedSuccessfully,
                                type: SnackBarType.success,
                              );
                              break;
                            case ApiKeyConstants.dark:
                              selectedMode = ThemeMode.dark;
                              AppSnackBar.show(
                                message:
                                StringConstants.themeUpdatedSuccessfully,
                                type: SnackBarType.success,
                              );
                              break;
                            default:
                              selectedMode = ThemeMode.system;
                              AppSnackBar.show(
                                message:
                                StringConstants.themeUpdatedSuccessfully,
                                type: SnackBarType.success,
                              );
                          }

                          context.read<ThemeBloc>().add(ThemeApply());
                         // Navigator.pop(context);
                          NavigationService.pushNamed(AppRoutes.mainScreen);
                        },
                        child: Text(
                        //  StringConstants.applyTheme,
                          "Apply Theme",
                          style: AppTextStyle.titleStyle16bw,
                        ),
                        context: context,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
