import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          history,
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
          doctorContainer(),
          patientContainer(),
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                padding: const EdgeInsets.all(00),
                itemBuilder: (BuildContext context, int index) {
                  return docContainer();
                }),
          ),
        ],
      ),
    );
  }

  Widget doctorContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.primaryColor, fontSize: 18),
                  ),
                  Text(
                    "General Physician",
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.greyColor, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 2.w),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  // margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColor.lightBlueColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: SvgPicture.asset(AppAssets.done),
                ),
              )
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Row(
            children: [
              Text(
                "$date : ",
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.navyBlueColor, fontSize: 12),
              ),
              Text(
                "05-03-2024",
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 12),
              ),
              SizedBox(
                width: 4.w,
              ),
              Text(
                "$time : ",
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.navyBlueColor, fontSize: 12),
              ),
              Text(
                "12 AM",
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 12),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget patientContainer() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(10),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mr.Mukesh Parmar ",
            style: AppTextStyle.semiBoldText
                .copyWith(fontSize: 18, color: AppColor.primaryColor),
          ),
          SizedBox(
            height: 3.w,
          ),
          Row(
            children: [
              Text(
                "$gender : ",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
              ),
              Text(
                "Male",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.greyColor),
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                "$age : ",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
              ),
              Text(
                "25",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.greyColor),
              ),
            ],
          ),
          SizedBox(
            height: 2.w,
          ),
          Row(
            children: [
              Text(
                "$phoneNo : ",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
              ),
              Text(
                "+91 9809876789",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.greyColor),
              ),
            ],
          ),
          SizedBox(
            height: 2.w,
          ),
          Row(
            children: [
              Text(
                "$email : ",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
              ),
              Text(
                "mukesh@gmail.com",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.greyColor),
              ),
            ],
          ),
          SizedBox(
            height: 2.w,
          ),
          Row(
            children: [
              Text(
                "$address : ",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
              ),
              Text(
                "Viswas bus stand, Nr. Jakatnaka Ahmedabad",
                style: AppTextStyle.semiBoldText
                    .copyWith(fontSize: 12, color: AppColor.greyColor),
              ),
            ],
          ),
          SizedBox(
            height: 1.w,
          ),
        ],
      ),
    );
  }

  Widget docContainer() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(10),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               decoration: BoxDecoration(
                   color: AppColor.lightBlueColor,
                   borderRadius: BorderRadius.circular(4)),
               child: SvgPicture.asset(AppAssets.doc),
             ),
             SizedBox(
               width: 5.w,
             ),
             Text(
               "Document",
               style: AppTextStyle.mediumText.copyWith(
                 color: AppColor.navyBlueColor,
                 fontSize: 12
               ),
             ),
             const Spacer(),
             SvgPicture.asset(AppAssets.download)
           ],
        ),
      ),
    );
  }
}
