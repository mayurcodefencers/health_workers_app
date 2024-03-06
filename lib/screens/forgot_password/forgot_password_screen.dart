import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/controllers/forgot_password/forgot_password_controller.dart';
import 'package:health_workers/controllers/login/login_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/otp/otp_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          forgotPassword,
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
                recoverYourPassword,
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Text(
              emailEnter,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              label: emailEnter,
              controller: controller.emailController,
              borderRadius: 8,
              keyboardType: null,
            ),
            SizedBox(
              height: 10.h,
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
                  Get.to(() => const OtpScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
