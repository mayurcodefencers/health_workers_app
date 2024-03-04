import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/mobile/mobile_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/container_widget.dart';
import 'package:health_workers/widgets/text_field_widget.dart';
import 'package:sizer/sizer.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool showPassword = true;


  void toggleVisibility() {
    setState(() {
      showPassword = !showPassword;
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
        heightC: 65.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  createNewPassword,
                  style: AppTextStyle.titleAndButtonBg,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Center(child: SvgPicture.asset(AppAssets.password)),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    passSuggetionText1,
                    style: AppTextStyle.textLight,
                  ),
                ),
                Center(
                  child: Text(
                    passSuggetionText2,
                    style: AppTextStyle.textLight,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  controller: newPassController,
                  keyboardType: TextInputType.text,
                  label: newPassword,
                  obscureText: showPassword,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  controller: confirmPassController,
                  keyboardType: TextInputType.text,
                  label: confirmPassword,
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
                const SizedBox(
                  height: 20.0,
                ),
                ButtonWidget(
                  text: save.toUpperCase(),
                  borderRadius: 10,
                  onTap : (){
                    Get.to(const MobileScreen());
                  },
                ),
                const SizedBox(
                  height: 26.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
