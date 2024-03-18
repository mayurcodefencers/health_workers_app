import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/home/home_controller.dart';
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
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    // upcomingDetails();
    super.initState();
  }

  // Future<void> upcomingDetails() async {
  //   await homeController.upcomingList();
  // }

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        }
        // else if (controller.loginModel == null) {
        //   return const Center(child: Text('No data available'));
        // }
        else {
          return Column(
            children: [
              Obx(() => Padding(
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
                            controller.isType.value == 0 ?
                            homeController.upcomingList() :
                            controller.isType.value == 1 ?
                            controller.getMissingList() :
                            controller.isType.value == 2 ?
                            controller.getCompleteList() :
                            homeController.upcomingList();

                          },
                          child: Obx(
                                () => Row(
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
              Obx(() => controller.isType.value == 0 ?
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: homeController.upcomingModel?.upcomingMeetinglist?.length ?? 0,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(00),
                    itemBuilder: (BuildContext context, int index) {
                      return upcomingContainer(index);
                    }),
              ) :
              controller.isType.value == 1 ?
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.missingMeetingModel?.missingMeetinglist?.length ?? 0,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(00),
                    itemBuilder: (BuildContext context, int index) {
                      return missedContainer(index);
                    }),
              ) :
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.completeMeetingModel?.completeMeetinglist?.length ?? 0,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(00),
                    itemBuilder: (BuildContext context, int index) {
                      return historyContainer(index);
                    }),
              ),)
            ],
          );
        }
      }),
    );
  }
  Widget upcomingContainer(int index) {
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
            Container(
              width: 8.h,
              height: 14.w,
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  homeController
                      .upcomingModel
                      ?.upcomingMeetinglist![index]
                      .username![0]
                      .toUpperCase() ??
                      "",
                  style: AppTextStyle.semiBoldText.copyWith(
                      color: AppColor.whiteColor, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homeController
                      .upcomingModel
                      ?.upcomingMeetinglist?[index]
                      .doctorname ??
                      "",
                  style: AppTextStyle.semiBoldText
                      .copyWith(color: AppColor.navyBlueColor, fontSize: 16),
                ),
                Text(
                  homeController
                      .upcomingModel
                      ?.upcomingMeetinglist?[index]
                      .username ??
                      "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 14),
                ),
                Text(
                  homeController
                      .upcomingModel
                      ?.upcomingMeetinglist?[index]
                      .userphoneno ??
                      "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 10),
                ),
                Text(
                  homeController
                      .upcomingModel
                      ?.upcomingMeetinglist?[index]
                      .createdDate ??
                      "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 10),
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
  Widget missedContainer(int index) {
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
            Container(
              width: 8.h,
              height: 14.w,
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  controller.missingMeetingModel?.missingMeetinglist?[index].username![0].toUpperCase() ?? "",
                  style: AppTextStyle.semiBoldText.copyWith(
                      color: AppColor.whiteColor, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.missingMeetingModel?.missingMeetinglist?[index].doctorname ?? "",
                  style: AppTextStyle.semiBoldText
                      .copyWith(color: AppColor.navyBlueColor, fontSize: 16),
                ),
                Text(
                  controller.missingMeetingModel?.missingMeetinglist?[index].username ?? "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 14),
                ),
                Text(
                  controller.missingMeetingModel?.missingMeetinglist?[index].userphoneno ?? "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 10),
                ),
                Text(
                  controller.missingMeetingModel?.missingMeetinglist?[index].createdDate ?? "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 10),
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
  Widget historyContainer(int index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const HistoryScreen());
        controller.storeAppointmentIdHistory!.value =
            controller.completeMeetingModel!.completeMeetinglist![index].id.toString();
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
            Container(
              width: 8.h,
              height: 14.w,
              decoration: const BoxDecoration(
                color: AppColor.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  controller.completeMeetingModel?.completeMeetinglist?[index].username![0].toUpperCase() ?? "",
                  style: AppTextStyle.semiBoldText.copyWith(
                      color: AppColor.whiteColor, fontSize: 22),
                ),
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.completeMeetingModel?.completeMeetinglist?[index].doctorname ?? "",
                  style: AppTextStyle.semiBoldText
                      .copyWith(color: AppColor.navyBlueColor, fontSize: 16),
                ),
                Text(
                  controller.completeMeetingModel?.completeMeetinglist?[index].username ?? "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 14),
                ),
                Text(
                  controller.completeMeetingModel?.completeMeetinglist?[index].userphoneno ?? "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 10),
                ),
                Text(
                  controller.completeMeetingModel?.completeMeetinglist?[index].createdDate ?? "",
                  style: AppTextStyle.mediumText
                      .copyWith(color: AppColor.greyColor, fontSize: 10),
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
