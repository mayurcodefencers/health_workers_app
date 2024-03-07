import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          bookings,
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
                  return bookingListWidget();
                }),
          ),
        ],
      ),
    );
  }
  Widget bookingListWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(12),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(AppAssets.profilePic),
          ),
          SizedBox(
            width: 6.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. Parthiv Joshi",
                style: AppTextStyle.semiBoldText
                    .copyWith(color: AppColor.navyBlueColor, fontSize: 16),
              ),
              Text(
                "Mr Mukesh Parmar",
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 14),
              ),
              Text(
                "+91 7990230441",
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 10),
              ),
              Row(
                children: [
                  Text(
                    "05-03-2024",
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.greyColor, fontSize: 10),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "12:00AM",
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.greyColor, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(18),
            // margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.lightBlueColor,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              "10",
              style: AppTextStyle.semiBoldText
                  .copyWith(color: AppColor.primaryColor, fontSize: 23),
            ),
          )
        ],
      ),
    );
  }
}
