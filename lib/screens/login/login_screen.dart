import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/controllers/forgot_password/forgot_password_controller.dart';
import 'package:health_workers/controllers/login/login_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/screens/forgot_password/forgot_password_screen.dart';
import 'package:health_workers/utils/validator.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
    controller.emailController.text = 'healthworker@gmail.com';
    controller.passwordController.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          welcomeBack,
          style: AppTextStyle.boldText
              .copyWith(color: AppColor.primaryColor, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  signIntoYourAccount,
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
                validator: (String? value) => Validators.validateEmail(value!.trim()),
                borderRadius: 8,
                keyboardType: null,
              ),
              SizedBox(
                height: 3.h,
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
                label: passwordEnter,
                controller: controller.passwordController,
                borderRadius: 8,
                validator: (String? value) => Validators.validatePassword(
                    value!.trim()),
                obscureText: !controller.showPassword.value,
                suFixIcon: Obx(() => GestureDetector(
                  onTap: () {
                    controller.toggleShowPassword();
                  },
                  child: Icon(
                    controller.showPassword.value ? Icons.visibility : Icons.visibility_off,
                    color: AppColor.greyColor,
                    size: 26,
                  ),
                )),
                keyboardType: null,
              ),
              Padding(
                padding: EdgeInsets.only(right: 6.w, top: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ForgotPasswordScreen());
                      },
                      child: Text(
                        "$forgotPassword?",
                        style: AppTextStyle.mediumText
                            .copyWith(color: AppColor.primaryColor, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: ButtonWidget(
                  text: signIn,
                  borderRadius: 8,
                  width: 50.w,
                  textStyle: AppTextStyle.mediumText
                      .copyWith(color: AppColor.whiteColor),
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final formData = {
                        'email': controller.emailController.text,
                        'password': controller.passwordController.text,
                        'adminemail': 'mayur@gmail.com',
                        'adminpassword': '12345'
                      };
                      controller.submitLoginData(formData);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
