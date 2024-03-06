import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/controllers/login/login_controller.dart';
import 'package:health_workers/controllers/new_password/new_password_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/forgot_password/forgot_password_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final NewPasswordController controller = Get.put(NewPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          newPassword,
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
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                newPasswordEnter,
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Text(
              passwordEnter,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              label: emailEnter,
              controller: controller.passwordController,
              borderRadius: 8,
              keyboardType: null,
            ),
            SizedBox(
              height: 3.h,
            ),
            Text(
              repeatPasswordEnter,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              label: passwordEnter,
              controller: controller.repeatPasswordController,
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
                textStyle: AppTextStyle.mediumText
                    .copyWith(color: AppColor.whiteColor),
              ),
            )
          ],
        ),
      ),
    );
  }
}
