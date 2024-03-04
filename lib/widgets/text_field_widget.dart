import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_workers/core/theme/app_text_style.dart';



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
  final InputDecoration? decoration;
  Widget? suFixIcon;
  final TextInputAction? textInputAction;

  CustomTextField(
      {Key? key,
        required this.label,
        this.hintText,
        required this.controller,
        required this.keyboardType,
        this.validator,
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
        this.suFixIcon,
        this.onSufixIconClick,
        this.textInputAction,
        this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: TextFormField(
        style: AppTextStyle.textFieldUserText,
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        maxLength: maxLength,
        showCursor: showCursor,
        readOnly: readOnly,
        autofocus: autoFocus,
        onTap: onTap,
        textInputAction: textInputAction,
        decoration: decoration ??
            InputDecoration(
              isDense: true,
              // hintText: hintText,
              label: Text(
                label,
                style: AppTextStyle.textFieldLabelText,
              ),
              border: const OutlineInputBorder(),
               focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey,),),
              counterText: counterText ?? "",
              suffixIcon: suFixIcon
            ),
      ),
    );
  }
}
