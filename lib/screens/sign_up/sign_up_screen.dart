import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/login/login_screen.dart';
import 'package:health_workers/widgets/bottom_nav_widget.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/check_box_widget.dart';
import 'package:health_workers/widgets/container_widget.dart';
import 'package:health_workers/widgets/text_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  bool showPassword = true;
  bool male = true;
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
        heightC: 90.h,
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  signUp,
                  style: AppTextStyle.titleAndButtonBg,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CustomTextField(
                  controller: nameController,
                  keyboardType: null,
                  label: name,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CustomTextField(
                  controller: emailController,
                  keyboardType: null,
                  label: emailOnly,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CustomTextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  label: phone,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CustomTextField(
                  controller: dobController,
                  keyboardType: null,
                  label: birthDate,
                  readOnly: true,
                  onTap: () async {
                    selectDate(context);
                  },
                ),
                const SizedBox(
                  height: 15.0,
                ),
                radioButtonWidget(),
                const SizedBox(
                  height: 15.0,
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
                    Expanded(
                      child: Text(
                        tcText1,
                        style: AppTextStyle.textNormal.copyWith(fontSize: 11),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ButtonWidget(
                  text: signUp.toUpperCase(),
                  borderRadius: 10,
                  onTap : (){
                    Get.to(const HomePage());
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

  Widget radioButtonWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          gender,
          style: AppTextStyle.textFieldLabelText,
        ),
        Row(
          children: [
            Radio(
              value: true,
              groupValue: male,
              fillColor: MaterialStateColor.resolveWith(
                    (states) => AppColor.textFieldBorderColor,
              ),
              onChanged: (val) {
                setState(() {
                  male = true;
                });
              },
            ),
            Text(
              maleText,
              style: AppTextStyle.textFieldUserText,
            ),
            Radio(
              value: false,
              groupValue: male,
              fillColor: MaterialStateColor.resolveWith(
                    (states) => AppColor.textFieldBorderColor,
              ),
              onChanged: (val) {
                setState(() {
                  male = false;
                });
              },
            ),
            Text(
              female,
              style: AppTextStyle.textFieldUserText,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      // DateTime.now().subtract(Duration(days: 1))
      lastDate: DateTime.now(),
    );

    if(pickedDate != null ){
      String formattedDate = DateFormat.yMd().format(pickedDate);
      print("dfnjknjf $formattedDate");
      setState(() {
        dobController.text = formattedDate;
      });
    } else {}
  }
}
