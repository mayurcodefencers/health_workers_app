import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/controllers/login/login_controller.dart';
import 'package:health_workers/controllers/otp/otp_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/new_password/new_passwrd_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_text_field.dart';
import 'package:health_workers/widgets/otp_input_widget.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          otpVerification,
          style: AppTextStyle.boldText
              .copyWith(color: AppColor.primaryColor, fontSize: 22),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColor.navyBlueColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 5.w
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                enterCode,
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Row(
              children: [
                OtpInput(
                  controller: controller.otp1,
                  index: 0,
                  otpLength: 0,
                ),
                OtpInput(
                  controller: controller.otp2,
                  index: 1,
                  otpLength: 1,
                ),
                OtpInput(
                  controller: controller.otp3,
                  index: 2,
                  otpLength: 2,
                ),
                OtpInput(
                  controller: controller.otp4,
                  index: 3,
                  otpLength: 3,
                ),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: Text(
                  codeExpire,
                style: AppTextStyle.normalText.copyWith(
                  color: AppColor.greyColor,
                  fontSize: 14
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  notReceiveCode,
                  style: AppTextStyle.normalText.copyWith(
                      color: AppColor.greyColor,
                      fontSize: 14
                  ),
                ),
                Text(
                  resendCode,
                  style: AppTextStyle.semiBoldText.copyWith(
                      color: AppColor.navyBlueColor,
                      fontSize: 14
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: ButtonWidget(
                text: submit,
                borderRadius: 8,
                width: 50.w,
                textStyle: AppTextStyle.mediumText.copyWith(
                    color: AppColor.whiteColor
                ),
                onTap: () {
                  Get.to(() => const NewPasswordScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
