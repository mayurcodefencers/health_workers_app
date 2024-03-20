import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/consulting/consulting_controller.dart';
import 'package:health_workers/controllers/home/home_controller.dart';
import 'package:health_workers/controllers/login/login_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/login/login_screen.dart';
import 'package:health_workers/screens/notification/notification_screen.dart';
import 'package:health_workers/screens/transaction/transaction_screen.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final HomeController controller = Get.put(HomeController());
  final LoginController loginController = Get.put(LoginController());
  final ConsultingController consultingController = Get.put(ConsultingController());

  @override
  void initState() {
    super.initState();
    walletDetails();
  }

  Future<void> walletDetails() async {
    consultingController.getWalletAmount();
  }

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
        // leading: GestureDetector(
        //   onTap: () {
        //     Get.back();
        //   },
        //   child: const Icon(
        //     Icons.arrow_back_ios_outlined,
        //     color: AppColor.navyBlueColor,
        //   ),
        // ),
      ),
      body: Obx(() {
        if (consultingController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        }
        // else if (consultingController.walletAmountModel == null) {
        //   return const Center(child: Text('No Data Available'));
        // }
        else {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    controller.userImage.toString() ?? "",
                    fit: BoxFit.fill,
                    width: 100,
                    height: 100,
                    // fit: BoxFit.cover
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  controller.userName.toString() ?? "",
                  style: AppTextStyle.semiBoldText
                      .copyWith(fontSize: 18, color: AppColor.navyBlueColor),
                ),
                Text(
                  healthWorker,
                  style: AppTextStyle.boldText
                      .copyWith(fontSize: 12, color: AppColor.greyColor),
                ),
                SizedBox(
                  height: 3.h,
                ),
                walletContainer(),
                SizedBox(
                  height: 2.h,
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 3.w,
                //   ),
                //   child: GestureDetector(
                //     onTap: () {
                //       Get.to(() => const NotificationScreen());
                //     },
                //     child: Row(
                //       children: [
                //         SvgPicture.asset(
                //             AppAssets.notification
                //         ),
                //         SizedBox(
                //           width: 2.w,
                //         ),
                //         Text(
                //           notification,
                //           style: AppTextStyle.mediumText.copyWith(
                //               fontSize: 14, color: AppColor.navyBlueColor),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: GestureDetector(
                    onTap: () async {
                      await loginController.logout();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                            AppAssets.logout,
                          height: 3.h,
                          width: 6.w,
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Text(
                          logOut,
                          style: AppTextStyle.mediumText.copyWith(
                              fontSize: 14, color: AppColor.navyBlueColor),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
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
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SvgPicture.asset(AppAssets.wallet),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    walletBalance,
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
                  )
                ],
              ),
              Text(
                consultingController.walletAmountModel?.walletAmount?.walletAmount ?? "0",
                style: AppTextStyle.mediumText
                    .copyWith(fontSize: 22, color: AppColor.navyBlueColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
