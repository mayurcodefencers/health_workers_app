import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/home/home_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/booking/booking_screen.dart';
import 'package:health_workers/widgets/bottom_nav_widget.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:sizer/sizer.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          Image.asset(
            AppAssets.success,
          ),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              bookingDone,
              style: AppTextStyle.semiBoldText.copyWith(
                color: AppColor.primaryColor,
                fontSize: 22
              ),
            ),
          ),
          Center(
            child: Text(
              bookingDone1,
              style: AppTextStyle.semiBoldText.copyWith(
                  color: AppColor.greyColor,
                  fontSize: 16
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          ButtonWidget(
            text: done,
            borderRadius: 8,
            width: 50.w,
            textStyle:
            AppTextStyle.mediumText.copyWith(color: AppColor.whiteColor),
            onTap: () async {
              await homeController.upcomingList();
              Get.to(() => const HomePage());
            },
          )
        ],
      ),
    );
  }
}
