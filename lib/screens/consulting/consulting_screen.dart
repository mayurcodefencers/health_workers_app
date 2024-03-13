import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/consulting/consulting_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/utils/validator.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class ConsultingScreen extends StatefulWidget {
  const ConsultingScreen({super.key});

  @override
  State<ConsultingScreen> createState() => _ConsultingScreenState();
}

class _ConsultingScreenState extends State<ConsultingScreen> {
  final ConsultingController controller = Get.put(ConsultingController());

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          consultation,
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
      body: SingleChildScrollView(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ));
            } else {
              return consultingWidget();
            }
          })),
    );
  }

  Widget consultingWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            phoneNo,
            style: AppTextStyle.mediumText
                .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
          ),
          SizedBox(
            height: 1.h,
          ),
          CustomTextField(
            label: phoneNo,
            controller: controller.phoneController,
            borderRadius: 8,
            maxLength: 10,
            validator: (String? value) =>
                Validators.validateMobile(value!.trim()),
            onSubmitted: (String? value) {
              controller.appointmentList({
                'phone_no': controller.phoneController.text,
              });
            },
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 2.h,
          ),
          controller.appointmentListModel?.appointmentlist?.length != null
              ? ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller
                      .appointmentListModel?.appointmentlist?.length ?? 0,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(00),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          color: AppColor.pureWhiteColor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Container(
                            width: 8.h,
                            height: 14.w,
                            decoration: const BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                controller
                                  .appointmentListModel
                                  ?.appointmentlist
                                  ?.first
                                  .name![index].toUpperCase()
                                  .toString() ??
                                  "10",
                                style: AppTextStyle.semiBoldText.copyWith(
                                    color: AppColor.primaryColor,
                                    fontSize: 22),),
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller
                                    .appointmentListModel
                                    ?.appointmentlist
                                    ?.first
                                    .name
                                    .toString() ??
                                    "10",
                                style: AppTextStyle.semiBoldText.copyWith(
                                    color: AppColor.navyBlueColor,
                                    fontSize: 16),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Text(
                                controller
                                    .appointmentListModel
                                    ?.appointmentlist
                                    ?.first
                                    .phoneNo
                                    .toString() ??
                                    "10",
                                style: AppTextStyle.mediumText.copyWith(
                                    color: AppColor.greyColor,
                                    fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
              : const SizedBox(),
          SizedBox(
            height: 2.h,
          ),
          Text(
            department,
            style: AppTextStyle.mediumText
                .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
          ),
          SizedBox(
            height: 1.h,
          ),
          departmentWidgetNew(),
          SizedBox(
            height: 2.h,
          ),
          controller.selectedValueDepartment!.value != ""
              ? Text(
            doctor,
            style: AppTextStyle.mediumText
                .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
          )
              : const SizedBox(),
          SizedBox(
            height: 1.h,
          ),
          controller.selectedValueDepartment!.value != ""
              ? doctorWidgetNew()
              : const SizedBox(),
          SizedBox(
            height: 2.h,
          ),
          Text(
            fileUpload,
            style: AppTextStyle.mediumText
                .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
          ),
          SizedBox(
            height: 1.h,
          ),
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              AppAssets.fileUpload,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            selectDate,
            style: AppTextStyle.mediumText
                .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
          ),
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) =>
                isSameDay(controller.selectedDay.value, day),
            rangeStartDay: _rangeStart,
            availableCalendarFormats: const {
              CalendarFormat.week: 'Week',
            },
            headerStyle: HeaderStyle(
              titleTextStyle: AppTextStyle.semiBoldText
                  .copyWith(fontSize: 10, color: AppColor.primaryColor),
              leftChevronIcon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 20,
                color: AppColor.primaryColor,
              ),
              rightChevronIcon: const Icon(
                Icons.arrow_back_ios_outlined,
                // textDirection: TextDirection.rtl,
                size: 20,
                color: AppColor.primaryColor,
              ),
              titleCentered: true,
              leftChevronMargin: EdgeInsets.only(left: 30.w),
            ),
            rangeEndDay: _rangeEnd,
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: false,
              weekendDecoration: BoxDecoration(
                  color: AppColor.whiteColor, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(
                  color: AppColor.primaryColor, shape: BoxShape.circle),
              defaultDecoration: BoxDecoration(
                  color: AppColor.whiteColor, shape: BoxShape.circle),
            ),
            calendarFormat: CalendarFormat.week,
            rangeSelectionMode: _rangeSelectionMode,
            // calendarBuilders: CalendarBuilders(
            //   dowBuilder: (context, day) {
            //     if (day.weekday == DateTime.sunday) {
            //       final text = DateFormat.E().format(day);
            //
            //       return Center(
            //         child: Text(
            //           text,
            //           style: TextStyle(color: Colors.red),
            //         ),
            //       );
            //     }
            //   },
            // ),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(controller.selectedDay.value, selectedDay)) {
                setState(() {
                  controller.selectedDay.value = selectedDay;
                  _focusedDay = focusedDay;
                  _rangeStart = null;
                  _rangeEnd = null;
                  _rangeSelectionMode = RangeSelectionMode.toggledOff;
                });
              }
            },
            onRangeSelected: (start, end, focusedDay) {
              setState(() {
                controller.selectedDay.value = null;
                _focusedDay = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(
            height: 2.h,
          ),
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemCount: controller.shift.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  controller.isShift?.value = index;
                  print(
                      "snjndjfnjdnj ${controller.isShift?.value == 0 ? controller.timeScheduleModel.value.timeschedule?.first.morningShift ?? "11" : controller.timeScheduleModel.value.timeschedule?.first.eveningShift ?? "11"}");
                },
                child: Obx(
                      () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.shift[index],
                        style: AppTextStyle.mediumText.copyWith(
                            color: AppColor.navyBlueColor, fontSize: 14),
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Container(
                        height: 6.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          color: index == controller.isShift?.value
                              ? AppColor.primaryColor
                              : AppColor.whiteColor,
                          border: Border.all(color: AppColor.primaryColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            index == 0
                                ? controller.timeScheduleModel.value
                                .timeschedule?.first.morningShift ??
                                "11"
                                : controller.timeScheduleModel.value
                                .timeschedule?.first.eveningShift ??
                                "11",
                            style: AppTextStyle.normalText.copyWith(
                              color: index == controller.isShift?.value
                                  ? AppColor.whiteColor
                                  : AppColor.primaryColor,
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
              crossAxisCount: 1,
              childAspectRatio: 10 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          SvgPicture.asset(AppAssets.line),
          SizedBox(
            height: 1.h,
          ),
          controller.storeDoctorPrice!.value != ''
              ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                totalAmount,
                style: AppTextStyle.semiBoldText.copyWith(
                    color: AppColor.navyBlueColor, fontSize: 20),
              ),
              Text(
                controller.storeDoctorPrice!.value,
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.primaryColor, fontSize: 24),
              ),
            ],
          )
              : const SizedBox(),
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: ButtonWidget(
              text: payNow,
              borderRadius: 8,
              width: 50.w,
              textStyle:
              AppTextStyle.mediumText.copyWith(color: AppColor.whiteColor),
              onTap: () {},
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
        ],
      ),
    );
  }

  Widget departmentWidgetNew() {
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
              return value == null ? "Choose Department" : null;
            },
            items: controller.dropdownValuesDepartment
                .map<DropdownMenuItem<String>>((dynamic value) {
              String departmentValue = value['department'];
              return DropdownMenuItem<String>(
                onTap: () {
                  controller.storeDepartmentId?.value = value['id'];
                  controller.getDoctorData(controller.storeDepartmentId!.value);
                },
                value: departmentValue,
                child: Text(departmentValue),
              );
            }).toList(),
            onChanged: controller.onSelectedDepartment,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
              color: AppColor.navyBlueColor,
            ),
            value: controller.selectedValueDepartment!.value.isNotEmpty
                ? controller.selectedValueDepartment!.value
                : null,
            hint: Text(
              selectDepartment,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            isExpanded: false,
          ),
        ));
  }

  Widget doctorWidgetNew() {
    return Obx(() {
      if (controller.dropdownValuesDoctor.isEmpty) {
        return const Text('No doctors available');
      } else {
        return DropdownButtonHideUnderline(
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
            items: controller.dropdownValuesDoctor
                .map<DropdownMenuItem<String>>((dynamic value) {
              String doctorValue = value['name'];
              return DropdownMenuItem<String>(
                onTap: () {
                  controller.storeDoctorPrice!.value = value['price'];
                },
                value: doctorValue,
                child: Text(doctorValue),
              );
            }).toList(),
            onChanged: controller.onSelectedDoctor,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
              color: AppColor.navyBlueColor,
            ),
            value: controller.selectedValueDoctor!.value.isNotEmpty
                ? controller.selectedValueDoctor!.value
                : null,
            hint: Text(
              selectDoctor,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            isExpanded: false,
          ),
        );
      }
    });
  }

  Future<void> _captureImages() async {
    final picker = ImagePicker();

    for (int i = 0; i < 1; i++) {
      final pickedFile = await picker.pickImage(
          source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
      if (pickedFile != null) {
        setState(() {
          controller.selectedImages.add(File(pickedFile.path));
        });
      }
    }
  }

  Widget _buildImageGrid() {
    return Container(
      height: controller.selectedImages.length >= 1 ? 20.h : 3.h,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: controller.selectedImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(controller.selectedImages[index]),
          );
        },
      ),
    );
  }
}
