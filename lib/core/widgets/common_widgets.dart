import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:http/http.dart' as http;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../../router/app_router.dart';
import '../colors/colors.dart';
import '../constants/api_keys.dart';
import '../constants/api_urls.dart';
import '../constants/icons_constant.dart';
import '../constants/image_constant.dart';
import '../constants/string_constants.dart';
import '../navigations/navigation_service.dart';
import '../themes/app_text_style.dart';
import 'common_app_snackbar.dart';

class CommonWidgets {
  static appBar({
    String? title,
    bool wantBackButton = true,
    bool centerTitle = true,
    bool manualBackButtonTap = false,
    List<Widget>? actions,
    Color? backgroundColor,
    Color? titleColor,
    void Function()? onTap,
  }) {
    return AppBar(
      elevation: 0,
      shadowColor: AppColors.appBarBackGroundColor,
      surfaceTintColor: AppColors.appBarBackGroundColor,
      foregroundColor: AppColors.appBarBackGroundColor,
      backgroundColor: backgroundColor ?? AppColors.appBarBackGroundColor,
      scrolledUnderElevation: 0.0,

      leading: wantBackButton
          ? GestureDetector(
              onTap: manualBackButtonTap
                  ? onTap
                  : () {
                      if (NavigationService.canPop()) {
                        NavigationService.pop();
                      } else {
                        SystemNavigator.pop();
                      }
                    },
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: svgIcon(
                    IconConstants.icBack,
                    height: 20.h,
                    width: 20.w,
                    color: AppColors.lightDarkWhiteColor,
                  ),
                ),
              ),
            )
          : null,
      titleSpacing: wantBackButton ? 0 : 20.w,
      centerTitle: centerTitle ?? true,
      // title: Text(title ?? '', style: AppTextStyle.titleStyleLB16bb),
      title: Text(
        title ?? '',
        style: AppTextStyle.titleStyleLB18bb.copyWith(
          color: titleColor ?? AppColors.appBarTitleColor,
        ),
      ),
      actions: actions,
    );
  }

  /// --- SVG Loader ---
  static Widget svgIcon(
    String assetPath, {
    double? height,
    double? width,
    Color? color,
  }) {
    return SvgPicture.asset(
      assetPath,
      height: height ?? 20,
      width: width ?? 20,
      colorFilter: color != null
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }

  /// BackGround frame
  static Widget customBackgroundFrame({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? splashColor,
    bool showLoading = false,
    required VoidCallback onPressed,
    Widget? child,
    required BuildContext context,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? 50.h,
      margin: buttonMargin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        gradient: LinearGradient(
          colors: [Color(0xFF34C8E8), Color(0xFF4E4AF2)],
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 9.r),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFFFF).withOpacity(0.5),
                Color(0xFF000000).withOpacity(0.5),
              ],
            ),
            width: 3.w,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: showLoading
            ? Center(
                child: const CircularProgressIndicator(color: AppColors.white),
              )
            : GestureDetector(
                onTap: onPressed,
                child: Container(
                  height: height ?? 50.h,
                  width: width ?? 50.h,
                  alignment: Alignment.center,
                  child: child,
                ),
              ),
      ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonElevatedButton({
    Key? buttonKey,
    Key? loadingKey,
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    Color? splashColor,
    bool showLoading = false,
    Color? buttonColor,
    TextStyle? textStyle,
    double? elevation,
    required VoidCallback onPressed,
    Widget? child,
    Decoration? decoration,
    BoxBorder? border,
    bool isDisabled = false,
    Color? disableButtonColor,
    required BuildContext context,
  }) {
    final Color effectiveColor = isDisabled
        ? disableButtonColor ?? AppColors.greys2
        : (buttonColor ?? AppColors.primary);

    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      margin: buttonMargin,
      alignment: Alignment.center,
      decoration:
          decoration ??
          BoxDecoration(
            color: effectiveColor,
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          ),
      clipBehavior: Clip.hardEdge,
      child: showLoading
          ? Container(
              key: loadingKey,
              alignment: Alignment.center,
              decoration:
                  decoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: buttonColor ?? AppColors.primary,
                  ),
              child: const CircularProgressIndicator(color: AppColors.white),
            )
          : GestureDetector(
              key: buttonKey,
              onTap: isDisabled ? null : onPressed,
              child: Container(
                height: height ?? 60.h,
                width: width ?? double.infinity,
                alignment: Alignment.center,
                decoration:
                    decoration ??
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: effectiveColor,
                    ),
                child: child,
              ),
            ),
    );
  }

  /// For outlined button (used for secondary actions)
  static Widget commonOutlinedButton({
    Key? buttonKey,
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    double? borderRadius,
    Color? borderColor,
    Color? textColor,
    Color? splashColor,
    bool showLoading = false,
    required VoidCallback onPressed,
    Widget? child,
    required BuildContext context,
    Color? backgroundColor,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      margin: buttonMargin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        border: Border.all(color: borderColor ?? AppColors.primary, width: 1.5),
      ),
      child: GestureDetector(
        key: buttonKey,
        onTap: onPressed,
        child: Container(
          height: height ?? 50.h,
          width: width ?? double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            color: Colors.transparent,
          ),
          child: showLoading
              ? const CircularProgressIndicator(color: AppColors.primary)
              : DefaultTextStyle(
                  style: AppTextStyle.titleStyle16bw.copyWith(
                    color: textColor ?? AppColors.primary,
                  ),
                  child: child ?? const SizedBox(),
                ),
        ),
      ),
    );
  }

  static Widget newCommonOutlinedButton({
    Key? buttonKey,
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    double? borderRadius,
    required Color backgroundColor,
    Color? borderColor,
    Color? textColor,
    Color? splashColor,
    bool showLoading = false,
    required VoidCallback onPressed,
    Widget? child,
    required BuildContext context,
    required Color overlayColor,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      margin: buttonMargin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
        child: InkWell(
          key: buttonKey,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          //splashColor: splashColor ?? backgroundColor.withOpacity(0.2),
          splashColor: AppColors.profileHeadingColor.withOpacity(0.3),
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          onTap: onPressed,
          child: Center(
            child: showLoading
                ? const CircularProgressIndicator(color: AppColors.white)
                : DefaultTextStyle(
                    style: AppTextStyle.titleStyle16bw.copyWith(
                      color: textColor ?? Colors.white,
                    ),
                    child: child ?? const SizedBox(),
                  ),
          ),
        ),
      ),
    );
  }

  ///For Full Size Use In Column Not In ROW
  static Widget commonGradientButton({
    double? height,
    double? width,
    EdgeInsetsGeometry? buttonMargin,
    EdgeInsetsGeometry? contentPadding,
    double? borderRadius,
    bool wantContentSizeButton = false,
    bool isLoading = false,
    Color? buttonColor,
    TextStyle? textStyle,
    double? elevation,
    required VoidCallback onPressed,
    Widget? child,
    BoxBorder? border,
  }) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: wantContentSizeButton ? height : 50.h,
        width: wantContentSizeButton ? width : double.infinity,
        margin: buttonMargin,
        alignment: Alignment.center,
        decoration: kGradientBoxDecoration(
          borderRadius: borderRadius,
          showGradientBorder: true,
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            : child ?? const Text(''),
      ),
    );
  }

  static imageView({
    double? width,
    double? height,
    double? radius,
    required String image,
    String? defaultNetworkImage,
    BoxFit? fit,
    BorderRadiusGeometry? borderRadius,
  }) {
    return SizedBox(
      height: height ?? 64.h,
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 8.r),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: fit ?? BoxFit.cover,
          errorWidget: (context, error, stackTrace) {
            return Container(
              height: height ?? 64.h,
              width: width ?? double.infinity,
              color: Theme.of(context).colorScheme.onSecondary.withOpacity(.2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius ?? 8.r),
                child: defaultNetworkImage != null
                    ? imageView(image: defaultNetworkImage)
                    : Icon(Icons.error, color: AppColors.primary),
              ),
            );
          },
          progressIndicatorBuilder: (context, url, downloadProgress) {
            return SizedBox(
              height: height ?? 64.h,
              width: width ?? double.infinity,
              child: Shimmer.fromColors(
                baseColor: Theme.of(
                  context,
                ).colorScheme.onSecondary.withOpacity(.4),
                highlightColor: Theme.of(context).colorScheme.onSecondary,
                child: Container(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSecondary.withOpacity(.4),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget dataNotFound() {
    return Center(child: Image.asset(ImageConstants.imageNoDataFound));
  }

  static BoxDecoration kGradientBoxDecoration({
    double? borderRadius,
    bool showGradientBorder = false,
    Color? defaultColor,
  }) {
    return BoxDecoration(
      gradient: showGradientBorder
          ? LinearGradient(
              colors: [
                const Color(0xffFF4292),
                const Color(0xffFF4292).withOpacity(0.7),
                const Color(0xff5588FE).withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          : LinearGradient(
              colors: [
                defaultColor ?? Colors.grey,
                defaultColor ?? Colors.grey,
              ],
            ),
      borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
    );
  }

  static Widget commonGifView({
    required String gifAsset,
    double? width,
    double? height,
    BoxFit? fit,
    double? borderRadius,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
      child: Image.asset(
        gifAsset,
        height: height ?? 24.h,
        width: width ?? 24.w,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }

  static Widget appIcons({
    required String assetName,
    double? width,
    double? height,
    double? borderRadius,
    Color? color,
    BoxFit? fit,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 4.r),
      child: SvgPicture.asset(
        assetName == '' ? IconConstants.icLogo : assetName,
        height: height ?? 24.h,
        width: width ?? 24.w,
        color: color,
        fit: fit ?? BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(height: height ?? 24.h, width: width ?? 24.w);
        },
      ),
    );
  }

  static Widget verticalSpace({double? height}) {
    return SizedBox(height: height ?? 10.h);
  }

  static Widget horizontalSpace({double? width}) {
    return SizedBox(width: width ?? 10.w);
  }

  static Widget customProgressBar({
    required bool inAsyncCall,
    double? width,
    Widget? child,
    Color? backgroundColor,
    bool overlapped = false,
    double? height,
  }) {
    return Container(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: inAsyncCall
            ? backgroundColor ?? backgroundColor
            : backgroundColor,
      ),
      clipBehavior: Clip.hardEdge,
      child: inAsyncCall
          ? overlapped
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                          appIcons(
                            assetName: IconConstants.icLogo,
                            width: 30.w,
                            height: 30.h,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      Opacity(opacity: 0.3, child: child ?? const SizedBox()),
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      const CircularProgressIndicator(color: AppColors.primary),
                      appIcons(
                        assetName: IconConstants.icLogo,
                        width: 30.w,
                        height: 30.h,
                        fit: BoxFit.fill,
                      ),
                    ],
                  )
          : child ?? const SizedBox(),
    );
  }

  static InputDecoration inputDecoration({
    String? hintText,
    String? labelText,
    String? errorText,
    EdgeInsetsGeometry? contentPadding,
    Color? fillColor,
    TextStyle? hintStyle,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    Widget? suffixIcon,
    Widget? prefixIcon,
    bool? filled,
  }) {
    return InputDecoration(
      errorText: errorText,
      counterText: '',
      errorStyle: AppTextStyle.titleStyle16pct,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      labelText: labelText,
      labelStyle: AppTextStyle.titleStyle14b,
      fillColor: AppColors.primary,
      // filled: filled ?? false,
      contentPadding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      hintStyle: AppTextStyle.titleStyle14b,
      disabledBorder: border(color: AppColors.lightTextColor),
      border: border(color: AppColors.primary),
      errorBorder: border(color: AppColors.errorColor),
      enabledBorder: border(color: AppColors.primary),
      focusedErrorBorder: border(),
      focusedBorder: border(),
    );
  }

  static border({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? AppColors.primary, width: 2.w),
      borderRadius: BorderRadius.circular(14.r),
    );
  }

  static Widget gradientText(String? text, double? fontSize) {
    return GradientText(
      text ?? '',
      gradientDirection: GradientDirection.ltr,
      style: TextStyle(fontSize: fontSize ?? 16.0.sp),
      colors: [
        const Color(0xffFF4292),
        const Color(0xffFF4292).withOpacity(0.7),
        const Color(0xff5588FE).withOpacity(0.6),
      ],
    );
  }

  static Widget commonTextField({
    Key? key,
    double? elevation,
    String? hintText,
    String? labelText,
    String? errorText,
    TextAlign textAlign = TextAlign.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    EdgeInsetsGeometry? contentPadding,
    TextEditingController? controller,
    int? maxLines,
    double? cursorHeight,
    bool wantBorder = false,
    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    Color? initialBorderColor,
    TextInputType? keyboardType,
    double? borderRadius,
    double? maxHeight,
    String? initialValue,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
    bool hintTextColor = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    AutovalidateMode? autoValidateMode,
    int? maxLength,
    GestureTapCallback? onTap,
    bool obscureText = false,
    FocusNode? focusNode,
    Decoration? decoration,
    TextInputAction? textInputAction,
    double? verticalHeight,
    bool? filled,
    bool isCard = false,
    bool enabled = true,
  }) {
    return Padding(
      padding: contentPadding ?? EdgeInsets.symmetric(vertical: 0.h),
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (labelText != null)
            Text(
              labelText ?? '',
              style: labelStyle ?? AppTextStyle.titleStyle14blb,
            ),
          if (labelText != null) SizedBox(height: verticalHeight ?? 8),
          Row(
            children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: prefixIcon != null ? 3.w : 0,
                    vertical: 0,
                  ),
                  child: TextFormField(
                    key: key,
                    focusNode: focusNode,
                    obscureText: obscureText,
                    onTap: onTap,
                    maxLines: maxLines ?? 1,
                    maxLength: maxLength,
                    textAlign: textAlign,
                    cursorHeight: cursorHeight,
                    cursorColor: AppColors.primary,
                    autovalidateMode: autoValidateMode,
                    controller: controller,
                    onChanged:
                        onChanged ??
                        (value) {
                          value = value.trim();
                          if (value.isEmpty ||
                              value.replaceAll(" ", "").isEmpty) {
                            controller?.text = "";
                          }
                        },
                    validator: validator,
                    keyboardType: defaultTargetPlatform == TargetPlatform.iOS
                        ? const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          )
                        : keyboardType ?? TextInputType.text,
                    readOnly: readOnly,
                    autofocus: autofocus,
                    initialValue: controller == null ? initialValue : null,
                    inputFormatters: inputFormatters,
                    textCapitalization: textCapitalization,
                    style:
                        style ??
                        AppTextStyle.titleStyle14blb.copyWith(
                          color: AppColors.lightDarkWhiteColor,
                        ),
                    enabled: enabled,
                    textInputAction: textInputAction,
                    decoration: InputDecoration(
                      errorText: errorText,
                      counterText: '',
                      errorStyle:
                          errorStyle ??
                          (errorText != null && errorText.isEmpty
                              ? const TextStyle(height: 0, fontSize: 0)
                              : AppTextStyle.titleStyleError()),
                      hintText: hintText,
                      hintStyle: hintStyle ?? AppTextStyle.titleStyle14blb,
                      fillColor:
                          fillColor ?? AppColors.textFieldBgLightDarkColor,
                      filled: filled ?? true,
                      prefixIcon: prefixIcon == null
                          ? null
                          : Padding(
                              padding: EdgeInsets.only(left: 12.w, right: 8.w),
                              child: prefixIcon,
                            ),
                      prefixIconConstraints: BoxConstraints(
                        maxWidth: 100,
                        maxHeight: 100,
                      ),
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          //color: AppColors.primary,
                          color: initialBorderColor ?? AppColors.primary,
                        ),
                        //borderRadius: BorderRadius.circular(8.0.r),
                        borderRadius: BorderRadius.circular(borderRadius ?? 8.0.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.MainBlueColor,
                        ),
                      //  borderRadius: BorderRadius.circular(8.0.r),
                        borderRadius: BorderRadius.circular(borderRadius ?? 8.0.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          //color: AppColors.unselectedLightDarkBorder
                          color:
                              initialBorderColor ??
                              // AppColors.dividerLightDarkColor,
                              AppColors.grey,
                        ),
                      //  borderRadius: BorderRadius.circular(8.0.r),
                        borderRadius: BorderRadius.circular(borderRadius ?? 8.0.r),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          color: AppColors.errorColor,
                        ),
                      //  borderRadius: BorderRadius.circular(8.0.r),
                        borderRadius: BorderRadius.circular(borderRadius ?? 8.0.r),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 1,
                          //color: AppColors.grey
                          //color: initialBorderColor ?? AppColors.grey,
                          color:
                              initialBorderColor ??
                              AppColors.dividerLightDarkColor,
                        ),
                      //  borderRadius: BorderRadius.circular(8.0.r),
                        borderRadius: BorderRadius.circular(borderRadius ?? 8.0.r),
                      ),
                      suffixIconColor: AppColors.grey,
                      suffixIcon: suffixIcon ?? const SizedBox(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget commonTextWithMaterialLabel({
    Key? key,

    double? elevation,

    String? hintText,

    String? labelText,

    String? errorText,

    EdgeInsetsGeometry? contentPadding,

    TextEditingController? controller,

    int? maxLines,

    double? cursorHeight,

    double? horizontalPadding,

    double? prefixIconHorizontal,

    bool wantBorder = false,

    ValueChanged<String>? onChanged,
    FormFieldValidator<String>? validator,
    Color? fillColor,
    Color? initialBorderColor,
    double? initialBorderWidth,
    TextInputType? keyboardType,
    double? borderRadius,
    double? maxHeight,
    TextStyle? hintStyle,
    TextStyle? style,
    TextStyle? labelStyle,
    TextStyle? errorStyle,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool autofocus = false,
    bool readOnly = false,
    bool hintTextColor = false,
    Widget? suffixIcon,
    Widget? prefixIcon,
    AutovalidateMode? autoValidateMode,
    int? maxLength,
    GestureTapCallback? onTap,
    bool obscureText = false,
    FocusNode? focusNode,
    Decoration? decoration,
    TextInputAction? textInputAction,
    bool? filled,
    bool isCard = false,
    bool enabled = true,

    //  New Parameters
    List<String>? pickerItems,
    String? pickerTitle,
    String? suffixText,
    required,
  }) {
    return Padding(
      padding: contentPadding ?? EdgeInsets.symmetric(vertical: 0.h),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: prefixIcon != null ? 10.w : 0,
          vertical: 0,
        ),
        child: TextFormField(
          key: key,
          focusNode: focusNode,
          obscureText: obscureText,
          onTap: onTap,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          cursorHeight: cursorHeight,
          cursorColor: AppColors.primary,
          autovalidateMode: autoValidateMode,
          controller: controller,

          onChanged:
              onChanged ??
              (value) {
                value = value.trim();
                if (value.isEmpty || value.replaceAll(" ", "").isEmpty) {
                  controller?.text = "";
                }
              },
          validator: validator,
          keyboardType: defaultTargetPlatform == TargetPlatform.iOS
              ? const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                )
              : keyboardType ?? TextInputType.text,
          readOnly: readOnly,
          autofocus: autofocus,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          style: style ?? AppTextStyle.titleStyle16bb,
          enabled: enabled,
          textInputAction: textInputAction,

          decoration: InputDecoration(
            // label: labelText != null ? Text(labelText) : null,
            labelStyle: labelStyle ?? AppTextStyle.titleStyle14b,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: labelText,
            errorText: errorText,
            counterText: '',
            errorStyle: errorStyle ?? AppTextStyle.titleStyleError(),
            hintText: hintText,
            hintStyle: hintStyle ?? AppTextStyle.titleStyle14b,
            fillColor: fillColor ?? AppColors.secondary,
            filled: filled ?? true,
            prefixIcon: prefixIcon,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 5.h,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.greys2),
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.greys2),
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.greys2),
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.errorColor),
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: AppColors.greys2),
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            suffixText: suffixText,
            suffixStyle: AppTextStyle.titleStyleLB14blb,
            suffixIconColor: AppColors.greys2,
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Align(
                        alignment: Alignment.center,
                        child: suffixIcon,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  ///common Rich Text
  static Widget richText({
    required String boldText,
    required String normalText,
    TextStyle? boldStyle,
    TextStyle? normalStyle,
    TextAlign textAlign = TextAlign.start,
    int? maxLines,
    TextOverflow overflow = TextOverflow.visible,
  }) {
    return RichText(
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      text: TextSpan(
        children: [
          TextSpan(
            text: boldText,
            style:
                boldStyle ??
                AppTextStyle.titleStyle14b.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.lightDarkBlackGreyColor,
                ),
          ),
          TextSpan(
            text: normalText,
            style:
                normalStyle ??
                AppTextStyle.titleStyle12b.copyWith(
                  fontWeight: FontWeight.normal,
                  color: AppColors.lightDarkBlackGreyColor,
                ),
          ),
        ],
      ),
    );
  }

  ///common List tile
  static Widget commonListTile({
    required String icon,
    required String title,
    String? label,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? borderColor,
    Color? iconColor,
    double? borderWidth,
    double? borderRadius,
    TextStyle? textStyle,
    TextStyle? labelStyle,
    Widget? trailingIcon,
    EdgeInsetsGeometry? padding,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
      child: Container(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          border: Border.all(
            color: borderColor ?? AppColors.grey,
            width: borderWidth ?? 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.svgIcon(
              icon,
              height: 20,
              width: 20,
              color: iconColor ?? Colors.white,
            ),
            SizedBox(width: 12.w),

            /// TEXT AREA
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (label != null) ...[
                    Text(
                      label,
                      style: labelStyle ?? AppTextStyle.titleStyleLB12bb,
                    ),
                    SizedBox(height: 4.h),
                  ],
                  Text(
                    title,
                    style:
                        textStyle ??
                        AppTextStyle.titleStyle14b.copyWith(
                          color: Colors.black,
                          fontSize: 14.sp,
                        ),
                  ),
                ],
              ),
            ),

            trailingIcon ??
                CommonWidgets.svgIcon(
                  IconConstants.icNewArrowLeft,
                  height: 20,
                  width: 20,
                  color: iconColor,
                ),
          ],
        ),
      ),
    );
  }

  static Widget commonTextFieldWithoutBg({
    required BuildContext context,
    required String hint,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
    bool? enable = true,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      style: AppTextStyle.titleStyleLB16blb,
      enabled: enable,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.titleStyleLB16blb,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        suffixIcon: CommonWidgets.svgIcon(IconConstants.icCalendarFilled),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  static Widget newCommonTextFieldWithoutBg({
    required BuildContext context,
    required String hint,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
    bool? enable = true,
    VoidCallback? onTap,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      onTap: onTap,
      style: AppTextStyle.titleStyleLB16blb,
      enabled: enable,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.titleStyleLB16blb,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: .8),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: .8),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primary, width: .8),
        ),

        suffixIcon: Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: CommonWidgets.svgIcon(IconConstants.icCalendarFilled),
        ),
        suffixIconConstraints: const BoxConstraints(
          minWidth: 20,
          minHeight: 20,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
      ),
    );
  }

  static countryCodePicker({
    ValueChanged<CountryCode>? onChanged,
    String? initialSelection,
  }) {
    return CountryCodePicker(
      boxDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.primary, width: 8.w),
      ),
      searchDecoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(width: 8.w, color: AppColors.errorColor),
        ),
      ),
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      showFlagMain: true,
      hideMainText: false,
      flagWidth: 24.w,
      onChanged: onChanged,
      initialSelection: initialSelection ?? 'IN',
      showCountryOnly: true,
      showDropDownButton: true,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
      textStyle: AppTextStyle.titleStyle14bb,
    );
  }

  static Widget commonOtpView({
    Key? key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    PinCodeFieldShape? shape,
    TextInputType keyboardType = TextInputType.number,
    List<TextInputFormatter>? inputFormatters,
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onCompleted,
    int length = 4,
    double? height,
    double? width,
    double? borderRadius,
    double? borderWidth,
    String? hintCharacter,
    bool readOnly = false,
    bool autoFocus = false,
    bool enableActiveFill = true,
    bool enablePinAutofill = true,
    bool autoDismissKeyboard = true,
    TextStyle? textStyle,
    Color? cursorColor,
    Color? inactiveColor,
    Color? inactiveFillColor,
    Color? activeColor,
    Color? activeFillColor,
    Color? selectedColor,
    Color? selectedFillColor,
    bool obscureText = false,
    AutovalidateMode? autoValidateMode,
    FormFieldValidator<String>? validator,
    EdgeInsets? fieldOuterPadding,
    String? errorMessage,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      PinCodeTextField(
        key: key,
        length: length,
        validator: validator,
        obscureText: obscureText,
        mainAxisAlignment: mainAxisAlignment,
        hintCharacter: hintCharacter ?? '∗',
        hintStyle: AppTextStyle.titleStyle20bb.copyWith(
          color: AppColors.readTitleMessageDateLightDarkTextColor,
          fontSize: 30,
        ),
        autovalidateMode: autoValidateMode ?? AutovalidateMode.disabled,
        // obscureText: true,
        appContext: NavigationService.navigatorKey.currentContext!,
        cursorColor: cursorColor ?? AppColors.white,
        autoFocus: autoFocus,
        keyboardType: keyboardType,
        inputFormatters:
            inputFormatters ??
            <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
        readOnly: readOnly,
        textStyle: textStyle ?? AppTextStyle.titleStyle20b,
        autoDisposeControllers: false,
        enabled: true,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          fieldOuterPadding: fieldOuterPadding ?? EdgeInsets.zero,
          inactiveColor: errorMessage != null
              ? AppColors.darkRed
              : (inactiveColor ?? Colors.grey.withOpacity(0.8)),
          inactiveFillColor: inactiveFillColor ?? Colors.transparent,
          activeColor: errorMessage != null
              ? AppColors.darkRed
              : (activeColor ?? Colors.grey.withOpacity(0.8)),
          activeFillColor: activeColor ?? Colors.transparent,
          selectedColor: selectedColor ?? AppColors.white,
          selectedFillColor: selectedFillColor ?? Colors.transparent,
          shape: shape ?? PinCodeFieldShape.box,
          fieldWidth: width ?? 45.w,
          fieldHeight: height ?? 45.h,
          borderWidth: borderWidth ?? 3.w,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
          errorBorderColor: AppColors.darkRed,
          errorBorderWidth: 1,
        ),
        enableActiveFill: enableActiveFill,
        controller: controller,
        onChanged: onChanged,
        enablePinAutofill: enablePinAutofill,
        onCompleted: onCompleted,
        autoDismissKeyboard: autoDismissKeyboard,
      ),
      if (errorMessage != null && errorMessage != "") ...[
        Text(
          errorMessage,
          style: AppTextStyle.titleStyle12b.copyWith(color: AppColors.darkRed),
        ),
      ],
    ],
  );

  static Widget profileStackWidget({
    required List<String> profileImageUrls,
    double avatarSize = 50.0,
    double spacing = 10.0,
  }) {
    List<Widget> stackLayers = List<Widget>.generate(profileImageUrls.length, (
      index,
    ) {
      return Padding(
        padding: EdgeInsets.fromLTRB(index.toDouble() * spacing, 0, 0, 0),
        child: CommonWidgets.imageView(
          image: profileImageUrls[index],
          height: avatarSize,
          width: avatarSize,
          borderRadius: BorderRadius.circular(avatarSize / 2),
          defaultNetworkImage: ApiUrlConstants.imageError,
        ),
      );
    });

    return Stack(children: stackLayers);
  }

  static Future<bool> internetConnectionCheckerMethod() async {
    try {
      final result = await http.get(Uri.parse('https://www.google.com/'));
      if (result.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  static Widget noInternetWidget() {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CommonWidgets.svgIcon(
              ImageConstants.imgNoInternet,
              height: 120.h,
              width: 120.h,
            ),
            CommonWidgets.verticalSpace(height: 20.h),
            Text(
              StringConstants.connectionLost,
              style: AppTextStyle.titleStyleLB16bb.copyWith(
                color: AppColors.unReadMessageLightDarkTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            CommonWidgets.verticalSpace(height: 12.h),
            Text(
              StringConstants.wereHavingTroubleConnectingRightNow,
              style: AppTextStyle.titleStyleLB12bb.copyWith(
                color: AppColors.unReadMessageLightDarkTextColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// For Check Api Response
  static Future<bool> responseCheckMethod({
    http.Response? response,
    bool wantSnackBar = true,
    bool wantOnlyErrorSnackBar = false,
    required bool ignore401StatusCode,
  }) async {
    if (response == null) return false;

    Map<String, dynamic>? responseMap;
    try {
      responseMap = jsonDecode(response.body);
    } catch (_) {}

    final statusCode = response.statusCode;

    // ✅ SUCCESS CASES ONLY
    if (statusCode == 200 || statusCode == 201 || statusCode == 204) {
      if (wantSnackBar && responseMap != null) {
        AppSnackBar.show(
          message: responseMap[ApiKeyConstants.message] ?? "Success",
          type: SnackBarType.success,
        );
      }
      return true;
    }

    if (responseMap != null && responseMap[ApiKeyConstants.errors] != null) {
      if (wantSnackBar || wantOnlyErrorSnackBar) {
        AppSnackBar.show(
          message:
              '${responseMap[ApiKeyConstants.errors][0][ApiKeyConstants.message]}',
          type: SnackBarType.error,
        );
      }
    }

    if (statusCode == 401) {
      if (!ignore401StatusCode) {
        await HydratedBloc.storage.clear();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        NavigationService.pushAndRemoveUntil(AppRoutes.login);
      }
      return false;
    }

    return false;
  }

  // static Widget svgIcon(
  //   String assetPath, {
  //   double? height,
  //   double? width,
  //   Color? color,
  // }) {
  //   return SvgPicture.asset(
  //     assetPath,
  //     height: height ?? 20,
  //     width: width ?? 20,
  //     colorFilter: color != null
  //         ? ColorFilter.mode(color, BlendMode.srcIn)
  //         : null,
  //   );
  // }

  static Widget commonEmptyErrorDataWidget({
    required String image,
    double? imageSize,
    String? title,
    String? desc,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidgets.appIcons(
          assetName: image,
          height: imageSize ?? 80.h,
          width: imageSize ?? 80.w,
        ),

        if (title != null) ...[
          SizedBox(height: 20.h),
          Text(
            title,
            style: AppTextStyle.titleStyleLB16bb.copyWith(
              color: AppColors.unReadMessageLightDarkTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        if (desc != null) ...[
          SizedBox(height: 12.h),
          Text(
            desc,
            style: AppTextStyle.titleStyleLB12bb.copyWith(
              color: AppColors.unReadMessageLightDarkTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  static Widget commonErrorWidget({
    required String image,
    String? title,
    String? desc,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonWidgets.appIcons(assetName: image, height: 120.h, width: 120.w),

        if (title != null) ...[
          SizedBox(height: 20.h),
          Text(
            title,
            style: AppTextStyle.titleStyleLB16bb.copyWith(
              color: AppColors.unReadMessageLightDarkTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
        if (desc != null) ...[
          SizedBox(height: 12.h),
          Text(
            desc,
            style: AppTextStyle.titleStyleLB12bb.copyWith(
              color: AppColors.unReadMessageLightDarkTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }

  static void networkConnectionShowSnackBar() {
    AppSnackBar.show(
      message: "Check Your Internet Connection",
      type: SnackBarType.info,
    );
  }

  static void serverDownShowSnackBar() {
    AppSnackBar.show(message: "Server Down", type: SnackBarType.error);
  }

  static Widget progressBar({
    bool isLoading = false,
    Widget? child,
    double? height,
    double? width,
  }) {
    return Container(
      height: height ?? 50.h,
      width: width ?? double.infinity,
      alignment: Alignment.center,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 4.w,
              ),
            )
          : child,
    );
  }

  static Widget unorderedList({required List<String> texts}) {
    var widgetList = <Widget>[];
    for (var text in texts) {
      widgetList.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("•", style: AppTextStyle.titleStyleLB14b),
            CommonWidgets.horizontalSpace(width: 8.w),
            Expanded(child: Text(text, style: AppTextStyle.titleStyleLB14b)),
          ],
        ),
      );
      widgetList.add(SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }

  // Updated fileAttachmentIndicatorIcon
  static Widget fileAttachmentIndicatorIcon({
    required String icon,
    required bool showDot,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: AppColors.lightDarkGreyBlackColor,
          child: CommonWidgets.svgIcon(
            icon,
            height: 16,
            width: 16,
            color: AppColors.ProfileOptionAndIconColor,
          ),
        ),

        // Show dot if either file or remark exists
        if (showDot)
          Positioned(
            right: -1,
            top: -1,
            child: CircleAvatar(radius: 3, backgroundColor: AppColors.primary),
          ),
      ],
    );
  }

  static Widget emptyProfileAvatar({double size = 80}) {
    return ClipOval(
      child: Container(
        height: size.h,
        width: size.h,
        color: AppColors.lightDarkBaseColor,
        alignment: Alignment.center,
        child: CommonWidgets.svgIcon(
          IconConstants.icEmptyProfileIcon,
          height: size * 1.25,
          width: size * 1.25,
        ),
      ),
    );
  }

  static void showLoadingDialog(
    BuildContext context, {
    String message = "Loading...",
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false, // prevent closing dialog
        child: AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          content: SizedBox(
            height: 80.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                SizedBox(height: 15.h),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Shows a snackbar with a message
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // remove old snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontSize: 14.sp, color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      ),
    );
  }
}

enum ErrorAnimationType { shake, clear }
