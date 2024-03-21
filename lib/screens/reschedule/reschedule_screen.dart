import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/controllers/booking/bookin_details_controller.dart';
import 'package:health_workers/controllers/consulting/consulting_controller.dart';
import 'package:health_workers/controllers/meeting/meeting_controller.dart';
import 'package:health_workers/controllers/reschedule/reschedule_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class RescheduleScreen extends StatefulWidget {
  const RescheduleScreen({super.key});

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  final RescheduleController controller = Get.put(RescheduleController());
  final ConsultingController consultingController =
      Get.put(ConsultingController());
  final BookingDetailsController detailsController =
      Get.put(BookingDetailsController());
  final MeetingController meetingController = Get.put(MeetingController());

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    missingDetails();
  }

  Future<void> missingDetails() async {
    await detailsController
        .bookingDetails(controller.storeAppointmentIdReschedule!.value);
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
            reschedule,
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
          if (detailsController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }
          // else if (detailsController.bookingDetailsModel == null) {
          //   return const Center(child: Text('No data available'));
          // }
          else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  doctorContainer(),
                  patientContainer(),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectDate,
                          style: AppTextStyle.mediumText.copyWith(
                              color: AppColor.navyBlueColor, fontSize: 14),
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
                            titleTextStyle: AppTextStyle.semiBoldText.copyWith(
                                fontSize: 10, color: AppColor.primaryColor),
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
                            todayDecoration: BoxDecoration(
                              color: AppColor.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            weekendDecoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                shape: BoxShape.circle),
                            selectedDecoration: BoxDecoration(
                                color: AppColor.primaryColor,
                                shape: BoxShape.circle),
                            defaultDecoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                shape: BoxShape.circle),
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
                            if (!isSameDay(
                                controller.selectedDay.value, selectedDay)) {
                              setState(() {
                                controller.selectedDay.value = selectedDay;
                                _focusedDay = focusedDay;
                                _rangeStart = null;
                                _rangeEnd = null;
                                _rangeSelectionMode =
                                    RangeSelectionMode.toggledOff;
                              });
                            }
                          },
                          onRangeSelected: (start, end, focusedDay) {
                            setState(() {
                              controller.selectedDay.value = null;
                              _focusedDay = focusedDay;
                              _rangeStart = start;
                              _rangeEnd = end;
                              _rangeSelectionMode =
                                  RangeSelectionMode.toggledOn;
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
                              },
                              child: Obx(
                                () => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.shift[index],
                                      style: AppTextStyle.mediumText.copyWith(
                                          color: AppColor.navyBlueColor,
                                          fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    Container(
                                      height: 6.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                        color:
                                            index == controller.isShift?.value
                                                ? AppColor.primaryColor
                                                : AppColor.whiteColor,
                                        border: Border.all(
                                            color: AppColor.primaryColor),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: Text(
                                          index == 0
                                              ? consultingController
                                                      .timeScheduleModel
                                                      .value
                                                      .timeschedule
                                                      ?.morningShift ??
                                                  "11"
                                              : consultingController
                                                      .timeScheduleModel
                                                      .value
                                                      .timeschedule
                                                      ?.eveningShift ??
                                                  "11",
                                          style:
                                              AppTextStyle.normalText.copyWith(
                                            color: index ==
                                                    controller.isShift?.value
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 10 / 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Center(
                          child: ButtonWidget(
                            text: rescheduleNow,
                            borderRadius: 8,
                            width: 50.w,
                            textStyle: AppTextStyle.mediumText
                                .copyWith(color: AppColor.whiteColor),
                            onTap: () async {
                              print("dgffg");
                              String formattedDate = DateFormat('yyyy-MM-dd').format(controller.selectedDay.value ?? DateTime.now());

                              await controller.rescheduleAppointment(
                                controller.storeAppointmentIdReschedule!.value,
                                formattedDate,
                                controller.isShift?.value == 0
                                    ? consultingController.timeScheduleModel
                                            .value.timeschedule?.morningShift
                                            .toString() ??
                                        "11"
                                    : consultingController.timeScheduleModel
                                            .value.timeschedule?.eveningShift
                                            .toString() ??
                                        "11",
                              );
                              print("dateeeeeeeeee ${controller.storeAppointmentIdReschedule!.value}");
                              print("dateeeeeeeeee $formattedDate");
                            },
                          ),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        }));
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
                    detailsController.bookingDetailsModel?.appointmentDetails
                            ?.first.doctorname?[0]
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
                    detailsController.bookingDetailsModel?.appointmentDetails
                            ?.first.doctorname ??
                        "",
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.primaryColor, fontSize: 18),
                  ),
                  Text(
                    detailsController.bookingDetailsModel?.appointmentDetails
                            ?.first.departmentname ??
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
                        detailsController.bookingDetailsModel
                                ?.appointmentDetails?.first.tokenNo ??
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
                detailsController.bookingDetailsModel?.appointmentDetails?.first
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
            detailsController
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
                detailsController.bookingDetailsModel?.appointmentDetails?.first
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
                detailsController.bookingDetailsModel?.appointmentDetails?.first
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
                detailsController.bookingDetailsModel?.appointmentDetails?.first
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
                detailsController.bookingDetailsModel?.appointmentDetails?.first
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
                detailsController.bookingDetailsModel?.appointmentDetails?.first
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
}
