import 'package:flutter/material.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final int index;
  final int otpLength;
  final bool showLine;

  const OtpInput({
    Key? key,
    required this.controller,
    required this.index,
    required this.otpLength,
    this.showLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TextFormField(
            autofocus: index == 0,
            maxLength: 1,
            controller: controller,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            cursorColor: AppColor.titleAndButtonColor,
            style:
            AppTextStyle.textLight.copyWith(fontSize: 22.0),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                counterText: ''),
            onChanged: (value) {
              if (value.length == 1) {
                if (index == 5) {
                  FocusScope.of(context).unfocus();
                } else {
                  FocusScope.of(context).nextFocus();
                }
              } else {
                if (index != 0) {
                  FocusScope.of(context).previousFocus();
                }
              }
            },
          ),
          if (showLine)
            Container(
              width: 10.w,
              height: 0.2.h,
              color: AppColor.textFieldBorderColor.withOpacity(0.5),
            ),
        ],
      ),
    );
  }
}
