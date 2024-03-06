import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hintText, counterText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  String? Function(String?)? validator;
  Widget? widget;
  GestureTapCallback? onTap, onSufixIconClick;
  FocusNode? focusNode;
  bool obscureText = false,
      showCursor = true,
      readOnly = true,
      autoFocus = false;
  TextStyle? style;
  int? maxLength;
  int? maxLine;
  double? borderRadius;
  bool enabled;
  final InputDecoration? decoration;
  Widget? suFixIcon;
  Widget? preFix;
  final TextInputAction? textInputAction;
  // final FormFieldValidator<String?>? validator;

  CustomTextField(
      {Key? key,
      required this.label,
      this.hintText,
      this.borderRadius,
      required this.controller,
      required this.keyboardType,
      // this.validator,
      this.onTap,
      this.focusNode,
      this.showCursor = false,
      this.obscureText = false,
      this.readOnly = false,
      this.autoFocus = false,
      this.decoration,
      this.style,
      this.counterText,
      this.maxLength,
      this.maxLine,
      this.enabled = true,
      this.preFix,
      this.suFixIcon,
      this.onSufixIconClick,
      this.textInputAction,
      this.validator,
      this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: TextFormField(
        style: AppTextStyle.normalText,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        maxLength: maxLength,
        maxLines: maxLine,
        showCursor: true,
        enabled: enabled,
        readOnly: readOnly,
        autofocus: autoFocus,
        onTap: onTap,
        focusNode: FocusNode(),
        textInputAction: textInputAction,
        cursorColor: AppColor.primaryColor,
        decoration: decoration ??
            InputDecoration(
                border: const OutlineInputBorder(),
                hintText: hintText,
                hintStyle: AppTextStyle.normalText.copyWith(
                  color: AppColor.primaryColor
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
                ),
                isDense: true,
                // label: Text(
                //   label,
                //   style: AppTextStyle.semiBold,
                // ),
                filled: true,
                fillColor: AppColor.skyBlueColor,
                focusColor: AppColor.greyColor,
                counterText: counterText ?? "",
                prefixIcon: preFix,
                suffixIcon: suFixIcon),
      ),
    );
  }
}
