import 'package:flutter/material.dart';
import 'package:health_workers/core/theme/app_color.dart';

class AppTextStyle {

  static TextStyle titleAndButtonBg = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Text',
    color: AppColor.titleAndButtonColor,
  );
  static TextStyle textFieldUserText = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Text',
    color: AppColor.textFieldBorderColor,
  );
  static TextStyle textFieldLabelText = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Text',
    color: AppColor.textFieldBorderColor,
  );
  static TextStyle textNormal = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'SF Pro Text',
    color: AppColor.textFieldBorderColor,
  );
  static TextStyle textBold = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    fontFamily: 'SF Pro Text',
    color: AppColor.containerColor,
  );
  static TextStyle textLight = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    fontFamily: 'SF Pro Text',
    color: AppColor.textFieldBorderColor,
  );
  static TextStyle textSemiBold = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    fontFamily: 'SF Pro Text',
    color: AppColor.containerColor,
  );
}
