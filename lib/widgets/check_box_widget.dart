import 'package:flutter/material.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:sizer/sizer.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool tickValue;

  const CheckBoxWidget({Key? key, required this.tickValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 3.h,
      width: 6.w,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.titleAndButtonColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: tickValue
          ? const Icon(
        Icons.check,
        size: 18.0,
        color: AppColor.titleAndButtonColor,
      )
          : const Icon(
        null,
        size: 20.0,
      ),
    );
  }
}
