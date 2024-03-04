import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/screens/login/login_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/container_widget.dart';
import 'package:sizer/sizer.dart';

import '../core/theme/app_text_style.dart';

class LoginWithMobileContainer extends StatelessWidget {
  const LoginWithMobileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      // appBar: AppBar(
      //   backgroundColor: AppColor.appBgColor,
      //   leading: const Icon(
      //     Icons.arrow_back,
      //     color: AppColor.arrowBackColor,
      //     size: 24.0,
      //   ),
      // ),
      body: ContainerWidget(
        heightC: 20.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                ButtonWidget(
                  text: mobileNumber.toUpperCase(),
                  borderRadius: 10,
                  textStyle: AppTextStyle.textNormal.copyWith(color: AppColor.containerColor, fontSize: 16),
                  onTap: () {},
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Row(
                    children: [
                      Text(
                        alreadyHaveAccount,
                        style: AppTextStyle.textNormal.copyWith(fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const LoginScreen());
                        },
                        child: Text(
                          " $login",
                          style: AppTextStyle.textBold.copyWith(fontSize: 16, color: AppColor.titleAndButtonColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
