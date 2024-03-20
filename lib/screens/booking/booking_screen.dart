import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/booking/booking_controller.dart';
import 'package:health_workers/controllers/home/home_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/booking/booking_details.dart';
import 'package:sizer/sizer.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingController controller = Get.put(BookingController());
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.selectedValueAllDoctor!.value = "";
    controller.bookingListModel?.nexttokenlist?.length = 0;
    controller.getAllDoctorList();
  }

  Future<void> bookingList() async {
    await controller.getAllDoctorList();
  }

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
          ));
        } else if (controller.allDoctorModel == null) {
          return const Center(child: Text('No Data Available'));
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctor,
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  allDoctorWidget(),
                  SizedBox(
                    height: 1.h,
                  ),
                //   controller.currentTokenModel?.currenttoken?.isNotEmpty == true
                //       ? Column(
                //   children: [
                //     Text(
                //       currentToken,
                //       style: AppTextStyle.mediumText.copyWith(
                //           fontSize: 20, color: AppColor.navyBlueColor),
                //     ),
                //     SizedBox(
                //       height: 1.h,
                //     ),
                //     Center(
                //       child: Container(
                //         height: 15.h,
                //         width: 40.w,
                //         // padding: const EdgeInsets.all(10),
                //         // margin: const EdgeInsets.all(10),
                //         decoration: BoxDecoration(
                //             color: AppColor.lightBlueColor,
                //             borderRadius: BorderRadius.circular(4)),
                //         child: Center(
                //           child: Text(
                //             controller.currentTokenModel?.currenttoken ?? "",
                //             style: AppTextStyle.semiBoldText.copyWith(
                //                 color: AppColor.primaryColor,
                //                 fontSize: 60),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ) : const SizedBox(),
                  controller.bookingListModel?.nexttokenlist?.length != null
                      ? Column(
                          children: [
                             ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.bookingListModel
                                        ?.nexttokenlist?.length ??
                                    0,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(00),
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () {
                                      controller.storeAppointmentId?.value =
                                          controller.bookingListModel!.nexttokenlist![index]
                                          .id.toString();
                                      Get.to(
                                          () => const BookingDetailsScreen());
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColor.pureWhiteColor,
                                        borderRadius:
                                            BorderRadius.circular(12),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                controller
                                                        .bookingListModel
                                                        ?.nexttokenlist![
                                                            index]
                                                        .username![0]
                                                        .toUpperCase() ??
                                                    "",
                                                style: AppTextStyle
                                                    .semiBoldText
                                                    .copyWith(
                                                        color: AppColor
                                                            .whiteColor,
                                                        fontSize: 22),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 6.w,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                        .bookingListModel
                                                        ?.nexttokenlist![
                                                            index]
                                                        .doctorname ??
                                                    "Doctor Name",
                                                style: AppTextStyle
                                                    .semiBoldText
                                                    .copyWith(
                                                        color: AppColor
                                                            .navyBlueColor,
                                                        fontSize: 16),
                                              ),
                                              Text(
                                                controller
                                                        .bookingListModel
                                                        ?.nexttokenlist![
                                                            index]
                                                        .username ??
                                                    "",
                                                style: AppTextStyle.mediumText
                                                    .copyWith(
                                                        color: AppColor
                                                            .greyColor,
                                                        fontSize: 14),
                                              ),
                                              Text(
                                                controller
                                                        .bookingListModel
                                                        ?.nexttokenlist![
                                                            index]
                                                        .userphoneno ??
                                                    "",
                                                style: AppTextStyle.mediumText
                                                    .copyWith(
                                                        color: AppColor
                                                            .greyColor,
                                                        fontSize: 10),
                                              ),
                                              Text(
                                                controller
                                                        .bookingListModel
                                                        ?.nexttokenlist![
                                                            index]
                                                        .date ??
                                                    "",
                                                style: AppTextStyle.mediumText
                                                    .copyWith(
                                                        color: AppColor
                                                            .greyColor,
                                                        fontSize: 10),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          Container(
                                            padding: const EdgeInsets.all(18),
                                            // margin: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color:
                                                    AppColor.lightBlueColor,
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            child: Text(
                                              controller
                                                      .bookingListModel
                                                      ?.nexttokenlist![index]
                                                      .tokenNo ??
                                                  "",
                                              style: AppTextStyle.semiBoldText
                                                  .copyWith(
                                                      color: AppColor
                                                          .primaryColor,
                                                      fontSize: 23),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ],
                        ) : const Text("No Bookings Available")
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget allDoctorWidget() {
    return Obx(() => DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              fillColor: AppColor.skyBlueColor,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.skyBlueColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.skyBlueColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: (String? value) {
              return value == null ? "Choose Doctor" : null;
            },
            items: controller.dropdownValuesAllDoctor.value
                .map<DropdownMenuItem<String>>((dynamic value) {
              String? allDoctorValue = value?['name'];
              return DropdownMenuItem<String>(
                onTap: () {
                  controller.storeAllListDoctorId?.value = value['id'];
                  controller.getAllBookingList(
                    controller.storeAllListDoctorId!.value,
                    homeController.hwId!.value,
                  );
                  // controller.getCurrentToken(
                  //   controller.storeAllListDoctorId!.value,
                  //   homeController.hwId!.value,
                  // );
                },
                value: allDoctorValue ?? "",
                child: Text(allDoctorValue ?? ""),
              );
            }).toList(),
            onChanged: controller.onSelectedAllDoctor,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
              color: AppColor.navyBlueColor,
            ),
            value: controller.selectedValueAllDoctor!.value.isNotEmpty
                ? controller.selectedValueAllDoctor!.value
                : null,
            hint: Text(
              selectDoctor,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            isExpanded: false,
          ),
        ));
  }
}
