import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/booking/bookin_details_controller.dart';
import 'package:health_workers/controllers/booking/booking_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class BookingDetailsScreen extends StatefulWidget {
  const BookingDetailsScreen({super.key});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetailsScreen> {
  final BookingDetailsController controller = Get.put(BookingDetailsController());
  final BookingController bookingController = Get.put(BookingController());

  @override
  void initState() {
    super.initState();
    callFunction();

  }

  Future<void> callFunction() async {
    await controller.bookingDetails(bookingController.storeAppointmentId!.value);
    print("calling ${
        controller.bookingDetailsModel?.appointmentDetails?.isNotEmpty == true
            ? controller.bookingDetailsModel?.appointmentDetails?.first.doctorname ?? ""
            : ""
    }");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          bookingDetails,
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
              ));
        } else if (controller.bookingDetailsModel == null) {
          return const Center(child: Text('No Data Available'));
        } else {
          return Column(
            children: [
              SizedBox(
                height: 2.h,
              ),
              doctorContainer(),
              SizedBox(
                height: 3.h,
              ),
              patientContainer()
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
                    controller.bookingDetailsModel?.appointmentDetails?.first.doctorname ?? "",
                    style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.primaryColor, fontSize: 18),
                  ),
                  Text(
                    controller.bookingDetailsModel?.appointmentDetails?.first.departmentname ?? "",
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
                            color: AppColor.navyBlueColor,
                            fontSize: 10
                        ),
                      ),
                      Text(
                        controller.bookingDetailsModel?.appointmentDetails?.first.tokenNo ?? "",
                        style: AppTextStyle.semiBoldText
                            .copyWith(color: AppColor.primaryColor, fontSize: 23),
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
                  controller.bookingDetailsModel?.appointmentDetails?.first.createdDate ?? "",
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
      controller.bookingDetailsModel?.appointmentDetails?.first.username ?? "",
            style: AppTextStyle.semiBoldText.copyWith(
              fontSize: 18,
              color: AppColor.primaryColor
            ),
          ),
          SizedBox(
            height: 3.w,
          ),
          Row(
            children: [
              Text(
                "$gender : ",
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.navyBlueColor
                ),
              ),
              Text(
                controller.bookingDetailsModel?.appointmentDetails?.first.gender ?? "",
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.greyColor
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                "$age : ",
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.navyBlueColor
                ),
              ),
              Text(
                controller.bookingDetailsModel?.appointmentDetails?.first.userage ?? "",
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.greyColor
                ),
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
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.navyBlueColor
                ),
              ),
              Text(
                controller.bookingDetailsModel?.appointmentDetails?.first.userphoneno ?? "",
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.greyColor
                ),
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
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.navyBlueColor
                ),
              ),
              Text(
                controller.bookingDetailsModel?.appointmentDetails?.first.useremail ?? "",
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.greyColor
                ),
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
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.navyBlueColor
                ),
              ),
              Text(
                controller.bookingDetailsModel?.appointmentDetails?.first.address ?? "",
                style: AppTextStyle.semiBoldText.copyWith(
                    fontSize: 12,
                    color: AppColor.greyColor
                ),
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
}
