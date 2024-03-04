import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/new_password/new_password_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/container_widget.dart';
import 'package:health_workers/widgets/otp_input_widget.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpInput1 = TextEditingController();
  final TextEditingController otpInput2 = TextEditingController();
  final TextEditingController otpInput3 = TextEditingController();
  final TextEditingController otpInput4 = TextEditingController();
  final TextEditingController otpInput5 = TextEditingController();
  final TextEditingController otpInput6 = TextEditingController();

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
              const SizedBox(
                height: 15.0,
              ),
              Center(child: SvgPicture.asset(AppAssets.mobilePhone)),
              const SizedBox(
                height: 12.0,
              ),
              Center(
                child: Text(
                  sentOtpText,
                  style: AppTextStyle.textLight,
                ),
              ),
              Row(
                children: [
                  OtpInput(controller: otpInput1, otpLength: 0, index: 0,),
                  OtpInput(controller: otpInput2, otpLength: 1, index: 1,),
                  OtpInput(controller: otpInput3, otpLength: 2, index: 2,),
                  OtpInput(controller: otpInput4, otpLength: 3, index: 3,),
                  OtpInput(controller: otpInput5, otpLength: 4, index: 4,),
                  OtpInput(controller: otpInput6, otpLength: 5, index: 5),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                  verifyOtpText,
                  style: AppTextStyle.textLight,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    notReceivedOtpText,
                    style: AppTextStyle.textLight,
                  ),
                  Text(
                    resendOtp,
                    style: AppTextStyle.titleAndButtonBg.copyWith(fontSize: 14.0),
                  ),
                ],
              ),
              const SizedBox(
                height: 26.0,
              ),
              ButtonWidget(
                text: submit.toUpperCase(),
                borderRadius: 10,
                onTap : (){
                  Get.to(const NewPasswordScreen());
                },
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
