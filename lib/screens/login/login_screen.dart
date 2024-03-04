import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/forgot_password/forgot_password_screen.dart';
import 'package:health_workers/screens/otp/otp_screen.dart';
import 'package:health_workers/screens/sign_up/sign_up_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/check_box_widget.dart';
import 'package:health_workers/widgets/container_widget.dart';
import 'package:health_workers/widgets/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = true;
  bool tickValue = false;


  void toggleVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void checkBoxValue() {
    setState(() {
      tickValue = !tickValue;
    });
  }

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
        heightC: 52.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                login,
                style: AppTextStyle.titleAndButtonBg,
              ),
              const SizedBox(
                height: 12.0,
              ),
              CustomTextField(
                controller: emailController,
                keyboardType: null,
                label: email,
              ),
              const SizedBox(
                height: 12.0,
              ),
              CustomTextField(
                controller: passwordController,
                keyboardType: TextInputType.text,
                label: password,
                obscureText: showPassword,
                textInputAction: TextInputAction.done,
                suFixIcon: GestureDetector(
                  onTap: () {
                    toggleVisibility();
                  },
                  child: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    size: 26.0,
                    color: AppColor.textFieldBorderColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      checkBoxValue();
                    },
                    child: CheckBoxWidget(
                      tickValue: tickValue,
                    )
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                      rememberText,
                    style: AppTextStyle.textNormal,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const ForgotPasswordScreen());
                      },
                      child: Text(
                        forgotPassword,
                        style: AppTextStyle.textNormal,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
               ButtonWidget(
                text: login.toUpperCase(),
                borderRadius: 10,
                onTap : (){
                  Get.to(const OtpScreen());
                },
              ),
              const SizedBox(
                height: 26.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                  children: [
                    Text(
                      notHaveAccount,
                      style: AppTextStyle.textNormal.copyWith(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(const SignUpScreen());
                      },
                      child: Text(
                       " $signUp",
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
    );
  }
}
