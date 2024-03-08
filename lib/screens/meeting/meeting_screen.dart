import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/meeting/meeting_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/history/history_screen.dart';
import 'package:health_workers/screens/reschedule/reschedule_screen.dart';
import 'package:sizer/sizer.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  final MeetingController controller = Get.put(MeetingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          meetings,
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
      body: Column(
        children: [
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.pureWhiteColor,
                    borderRadius: BorderRadius.circular(4)),
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemCount: controller.type.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.isType.value = index;
                        // String? getUserId = pref?.getString("userId");
                        // controller.isSelectedBooking.value == 0
                        //     ? controller.getOrderListData(controller.userLoginId!.value)
                        //     : controller.pastOrderListData(getUserId!);
                      },
                      child: Obx(
                        () => Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 10.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                  color: controller.isType.value == index
                                      ? AppColor.primaryColor
                                      : AppColor.pureWhiteColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  controller.type[index].toString(),
                                  style: AppTextStyle.semiBoldText.copyWith(
                                    fontSize: 14,
                                    color: controller.isType.value == index
                                        ? AppColor.whiteColor
                                        : AppColor.navyBlueColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 20 / 3,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 40
                  ),
                ),
              ),
            ),
          ),
          Obx(() => controller.isType.value == 0 ? Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                padding: const EdgeInsets.all(00),
                itemBuilder: (BuildContext context, int index) {
                  return upcomingContainer();
                }),
          ) : controller.isType.value == 1 ?
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                padding: const EdgeInsets.all(00),
                itemBuilder: (BuildContext context, int index) {
                  return missedContainer();
                }),
          ) :
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                padding: const EdgeInsets.all(00),
                itemBuilder: (BuildContext context, int index) {
                  return historyContainer();
                }),
          ),)
        ],
      ),
    );
  }
  Widget upcomingContainer() {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
              child: SvgPicture.asset(
                AppAssets.camera,
                color: AppColor.primaryColor,
              )
            )
          ],
        ),
      ),
    );
  }
  Widget missedContainer() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const RescheduleScreen());
      },
      child: Container(
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
                child: SvgPicture.asset(
                  AppAssets.reschedule,
                  color: AppColor.primaryColor,
                )
            )
          ],
        ),
      ),
    );
  }
  Widget historyContainer() {
    return GestureDetector(
      onTap: () {
        Get.to(() => const HistoryScreen());
      },
      child: Container(
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
                child: SvgPicture.asset(
                  AppAssets.done,
                  color: AppColor.primaryColor,
                )
            )
          ],
        ),
      ),
    );
  }
}
