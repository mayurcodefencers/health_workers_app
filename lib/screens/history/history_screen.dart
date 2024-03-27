import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/booking/bookin_details_controller.dart';
import 'package:health_workers/controllers/meeting/meeting_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/show_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final BookingDetailsController controller =
      Get.put(BookingDetailsController());
  final MeetingController meetingController = Get.put(MeetingController());

  @override
  void initState() {
    super.initState();
    controller
        .bookingDetails(meetingController.storeAppointmentIdHistory!.value);
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        } else if (controller.bookingDetailsModel == null) {
          return const Center(child: Text('No data available'));
        } else {
          return Column(
            children: [
              doctorContainer(),
              patientContainer(),
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller
                            .bookingDetailsModel?.appointmentDetails?.length ??
                        0,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(00),
                    itemBuilder: (BuildContext context, int index) {
                      return docContainer(index);
                    }),
              ),
            ],
          );
        }
      }),
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
              Container(
                width: 8.h,
                height: 14.w,
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    // controller
                    //     .appointmentListModel
                    //     ?.appointmentlist![index]
                    //     .name![0].toUpperCase()
                    //     .toString() ??
                    //     "10",
                    controller.bookingDetailsModel?.appointmentDetails?.first
                            .doctorname?[0]
                            .toUpperCase() ??
                        "",
                    style: AppTextStyle.semiBoldText
                        .copyWith(color: AppColor.whiteColor, fontSize: 22),
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
                    controller.bookingDetailsModel?.appointmentDetails?.first
                            .doctorname ??
                        "",
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.primaryColor, fontSize: 18),
                  ),
                  Text(
                    controller.bookingDetailsModel?.appointmentDetails?.first
                            .departmentname ??
                        "",
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
                  child: Column(
                    children: [
                      Text(
                        tokenNo,
                        style: AppTextStyle.semiBoldText.copyWith(
                            color: AppColor.navyBlueColor, fontSize: 10),
                      ),
                      Text(
                        controller.bookingDetailsModel?.appointmentDetails
                                ?.first.tokenNo ??
                            "",
                        style: AppTextStyle.semiBoldText.copyWith(
                            color: AppColor.primaryColor, fontSize: 23),
                      ),
                    ],
                  ),
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
                controller.bookingDetailsModel?.appointmentDetails?.first
                        .date ??
                    "",
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
            controller
                    .bookingDetailsModel?.appointmentDetails?.first.username ??
                "",
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
                controller.bookingDetailsModel?.appointmentDetails?.first
                        .gender ??
                    "",
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
                controller.bookingDetailsModel?.appointmentDetails?.first
                        .userage ??
                    "",
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
                controller.bookingDetailsModel?.appointmentDetails?.first
                        .userphoneno ??
                    "",
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
                controller.bookingDetailsModel?.appointmentDetails?.first
                        .useremail ??
                    "",
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
                controller.bookingDetailsModel?.appointmentDetails?.first
                        .address ??
                    "",
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

  Widget docContainer(int index) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const ShowImageScreen());
      },
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
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 12),
            ),
            const Spacer(),
            SvgPicture.asset(
              AppAssets.view,
            )
          ],
        ),
      ),
    );
  }

  Future<void> downloadFile(String url) async {
    try {
      // Initialize FlutterDownloader
      await FlutterDownloader.initialize();

      // Get the external storage directory
      String? dir = (await getExternalStorageDirectory())?.path;

      if (dir != null) {
        // Create the directory if it doesn't exist
        Directory directory = Directory('/storage/emulated/0/Download/');
        if (!await directory.exists()) {
          directory.create(recursive: true);
        }

        // Start the download task
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          savedDir: directory.path,
          showNotification: true,
          openFileFromNotification: true,
        );

        print('Download task id: $taskId');
      } else {
        print('Failed to get external storage directory.');
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
  }

}
