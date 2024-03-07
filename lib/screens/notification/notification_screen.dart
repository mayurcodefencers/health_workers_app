import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          notification,
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                padding: const EdgeInsets.all(00),
                itemBuilder: (BuildContext context, int index) {
                  return notificationContainer();
                }),
          ),
        ],
      ),
    );
  }
  Widget notificationContainer() {
    return Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColor.pureWhiteColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x19101828),
              blurRadius: 4,
              offset: Offset(0, 2),
              spreadRadius: -1,
            )
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 4.w,
            ),
            SvgPicture.asset(
                AppAssets.reschedule
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              "Booking Successfully Done",
              style: AppTextStyle.mediumText.copyWith(
                  fontSize: 12,
                  color: AppColor.primaryColor
              ),
            )

          ],
        )

    );
  }
}
