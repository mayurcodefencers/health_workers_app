import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/notification/notification_screen.dart';
import 'package:health_workers/screens/transaction/transaction_screen.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          profile,
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
      body: Center(
        child: Column(
          children: [
            SizedBox(
               height: 4.h,
            ),
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(AppAssets.profilePic),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
               "Hardeep Sodhi",
              style: AppTextStyle.semiBoldText.copyWith(
                fontSize: 18,
                color: AppColor.navyBlueColor
              ),
            ),
            Text(
              healthWorker,
              style: AppTextStyle.boldText.copyWith(
                  fontSize: 12,
                  color: AppColor.greyColor
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            walletContainer(),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 3.w,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const NotificationScreen());
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.notifications_none,
                      size: 34,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      notification,
                      style: AppTextStyle.mediumText.copyWith(
                          fontSize: 14,
                        color: AppColor.navyBlueColor
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 3.w
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout_outlined,
                      size: 34,
                      color: AppColor.primaryColor,
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(
                      logOut,
                      style: AppTextStyle.mediumText.copyWith(
                          fontSize: 14,
                          color: AppColor.navyBlueColor
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget walletContainer() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const TransactionScreen());
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(15),
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SvgPicture.asset(
                    AppAssets.wallet
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    walletBalance,
                    style: AppTextStyle.mediumText.copyWith(
                      color: AppColor.navyBlueColor,
                      fontSize: 14
                    ),
                  )
                ],
              ),
              Text(
                "20,000",
                style: AppTextStyle.mediumText.copyWith(
                  fontSize: 22,
                  color: AppColor.navyBlueColor
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
