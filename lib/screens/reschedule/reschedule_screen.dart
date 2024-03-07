import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/reschedule/reschedule_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class RescheduleScreen extends StatefulWidget {
  const RescheduleScreen({super.key});

  @override
  State<RescheduleScreen> createState() => _RescheduleScreenState();
}

class _RescheduleScreenState extends State<RescheduleScreen> {
  final RescheduleController controller = Get.put(RescheduleController());
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            doctorContainer(),
            patientContainer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                vertical: 2.h
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selectDate,
                    style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.navyBlueColor,
                        fontSize: 14
                    ),
                  ),
                  TableCalendar(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
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
                        textDirection: TextDirection.rtl,
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
                          color: AppColor.whiteColor,
                          shape: BoxShape.circle
                      ),
                      selectedDecoration: BoxDecoration(
                          color: AppColor.primaryColor,
                          shape: BoxShape.circle
                      ),
                      defaultDecoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          shape: BoxShape.circle
                      ),
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
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          _rangeStart = null;
                          _rangeEnd = null;
                          _rangeSelectionMode = RangeSelectionMode.toggledOff;
                          print("_selectedDay $_selectedDay");
                        });
                      }
                    },
                    onRangeSelected: (start, end, focusedDay) {
                      setState(() {
                        _selectedDay = null;
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
                  Text(
                    morningTime,
                    style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.navyBlueColor,
                        fontSize: 14
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Obx(() => Container(
                    height: 6.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: controller.isSelectedMorning?.value != null ? AppColor.primaryColor : AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        controller.timeListMorning!.value,
                        style: AppTextStyle.normalText.copyWith(
                          color: controller.isSelectedMorning?.value != null ? AppColor.whiteColor : AppColor.primaryColor,
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    eveningTime,
                    style: AppTextStyle.mediumText.copyWith(
                        color: AppColor.navyBlueColor,
                        fontSize: 14
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Obx(() => Container(
                    height: 6.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: controller.isSelectedEvening?.value != null ? AppColor.primaryColor : AppColor.whiteColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                      child: Text(
                        controller.timeListEvening!.value,
                        style: AppTextStyle.normalText.copyWith(
                          color: controller.isSelectedEvening?.value != null? AppColor.whiteColor : AppColor.primaryColor,
                        ),
                      ),
                    ),
                  )),
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
                        "10",
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
                "Male",
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
                "25",
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
                "+91 9809876789",
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
                "mukesh@gmail.com",
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
                "Viswas bus stand, Nr. Jakatnaka Ahmedabad",
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
