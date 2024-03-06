import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/consultation/consultation_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(AppAssets.profilePic),
                ),
                SizedBox(
                  width: 3.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      welComeBackHome,
                      style: AppTextStyle.mediumText
                          .copyWith(color: AppColor.primaryColor, fontSize: 12),
                    ),
                    Text(
                      "Hardeep Sodhi",
                      style: AppTextStyle.semiBoldText.copyWith(
                          color: AppColor.navyBlueColor, fontSize: 14),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.notifications_none,
                  size: 34,
                  color: AppColor.primaryColor,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const ConsultationScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColor.pureWhiteColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    AppAssets.bookAppointmentHome,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bookAppointment,
                        style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.primaryColor, fontSize: 16),
                      ),
                      Text(
                        bookAppointmentHere,
                        style: AppTextStyle.normalText
                            .copyWith(color: AppColor.greyColor, fontSize: 10),
                      )
                    ],
                  ),
                  SvgPicture.asset(
                    AppAssets.arrow,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                upcomingBookings,
                style: AppTextStyle.semiBoldText
                    .copyWith(color: AppColor.primaryColor, fontSize: 16),
              ),
              ButtonWidget(
                text: viewAll,
                width: 25.w,
                textStyle: AppTextStyle.normalText.copyWith(
                  color: AppColor.pureWhiteColor,
                ),
                onTap: () {},
                borderRadius: 10,
              )
            ],
          ),
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
      margin: const EdgeInsets.all(14),
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
