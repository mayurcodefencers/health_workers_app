import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/container_widget.dart';
import 'package:sizer/sizer.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();

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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Center(child: SvgPicture.asset(AppAssets.mobile)),
                const SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: Text(
                    enterMobileText1,
                    style: AppTextStyle.textLight,
                  ),
                ),
                Center(
                  child: Text(
                    enterMobileText2,
                    style: AppTextStyle.textLight,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                mobileNumberContainer(),
                const SizedBox(
                  height: 20.0,
                ),
                ButtonWidget(
                  text: submit.toUpperCase(),
                  borderRadius: 10,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                            print("dbjfjfj");
                    }
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

  Widget mobileNumberContainer() {
    return Form(
      key: _formKey,
      child: Row(
        children: [
          Container(
            height: 7.h,
            width: 18.w,
            decoration: const BoxDecoration(
              color: AppColor.appBgColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(4),
                bottom: Radius.circular(4),
              ),
            ),
            child: Center(
              child: Text(
                "+ 91",
                style: AppTextStyle.textFieldLabelText.copyWith(fontSize: 14),
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Container(
            height: 7.h,
            width: 63.w,
            decoration: const BoxDecoration(
              color: AppColor.appBgColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(4),
                bottom: Radius.circular(4),
              ),
            ),
            child: Theme(
                data: ThemeData(
                  primaryColor: Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(
                    style: AppTextStyle.textFieldUserText,
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Mobile number is required';
                      } else if (value.length != 10) {
                        return 'Mobile number must be 10 digits';
                      } else if (value.length > 10) {
                        return 'Please Enter valid Mobile number';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: enterNumber,
                      labelStyle: AppTextStyle.textFieldLabelText,
                      border: InputBorder.none,
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
