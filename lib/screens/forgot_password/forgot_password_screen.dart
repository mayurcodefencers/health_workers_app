import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/container_widget.dart';
import 'package:health_workers/widgets/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBgColor,
      appBar: AppBar(
        backgroundColor: AppColor.appBgColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColor.arrowBackColor,
            size: 24.0,
          ),
        ),
      ),
      body: ContainerWidget(
        heightC: 55.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                forgotPassword,
                style: AppTextStyle.titleAndButtonBg,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Center(child: SvgPicture.asset(AppAssets.mobilePhone)),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  receiveVerificationCode1,
                  style: AppTextStyle.textLight,
                ),
              ),
              Center(
                child: Text(
                  receiveVerificationCode2,
                  style: AppTextStyle.textLight,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CustomTextField(
                controller: phoneController,
                keyboardType: null,
                label: email,
              ),
              const SizedBox(
                height: 12.0,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ButtonWidget(
                text: send.toUpperCase(),
                borderRadius: 10,
                onTap : (){},
              ),
              const SizedBox(
                height: 26.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
