import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/book_appoinment/booked_appointment_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:health_workers/widgets/text_field_widget.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectSlotScreen extends StatefulWidget {
  const SelectSlotScreen({super.key});

  @override
  State<SelectSlotScreen> createState() => _SelectSlotScreenState();
}

class _SelectSlotScreenState extends State<SelectSlotScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int? isSelected;
  List<String> timeList =
  [
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 AM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
  ];

  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.appBgColor,
      drawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBarWidget(
              extraContainerHeight: 19.h,
              sizedBoxHeight: 16.h,
              showTextField: true,
              showDrawer: false,
              showAppBarText: true,
              appBarText: bookAppointment,
              searchText: searchText,
              openDrawerTap: () {},
              paddingTop: 0.0,
              paddingBottom: 0.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                // height: 20.h,
                padding: const EdgeInsets.all(12),
                // margin: const EdgeInsets.all(14),
                // width: 90.w,
                decoration: BoxDecoration(
                    color: AppColor.containerColor,
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.favorite_border,
                        color: AppColor.redColor,
                        size: 18,
                      ),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 14),
                          child: CircleAvatar(
                            radius: 29,
                            backgroundColor: AppColor.titleAndButtonColor,
                            child: CircleAvatar(
                              radius: 27,
                              backgroundImage: AssetImage(AppAssets.dummyDoctor),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctorName,
                              style: AppTextStyle.textSemiBold.copyWith(
                                  fontSize: 12,
                                  color: AppColor.titleAndButtonColor),
                            ),
                            Text(
                              bloodAnalysis,
                              style:
                                  AppTextStyle.textLight.copyWith(fontSize: 10),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppColor.yellowColor,
                                  size: 16,
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  ratingText.toString(),
                                  style: AppTextStyle.textLight
                                      .copyWith(fontSize: 10),
                                ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  feedbackText,
                                  style: AppTextStyle.textLight
                                      .copyWith(fontSize: 10),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      color: AppColor.searchColor,
                    ),
                    Row(
                      children: [
                        Text(
                          about,
                          style: AppTextStyle.textSemiBold.copyWith(
                              fontSize: 12, color: AppColor.titleAndButtonColor),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          doctorName,
                          style: AppTextStyle.textSemiBold.copyWith(
                              fontSize: 12, color: AppColor.titleAndButtonColor),
                        ),
                      ],
                    ),
                    Text(
                      demoText,
                      style: AppTextStyle.textLight.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColor.containerColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appointmentFor,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 12, color: AppColor.titleAndButtonColor),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                        label: name,
                        controller: nameController,
                        keyboardType: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        label: phone,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        selectDate,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 12, color: AppColor.titleAndButtonColor),
                      ),
                      const SizedBox(
                        height: 16,
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
                          titleTextStyle: AppTextStyle.textSemiBold.copyWith(
                              fontSize: 10, color: AppColor.titleAndButtonColor),
                          leftChevronIcon: const Icon(
                            Icons.arrow_right,
                            // textDirection: TextDirection.rtl,
                            size: 30,
                            color: AppColor.textFieldBorderColor,
                          ),
                          rightChevronIcon: const Icon(
                            Icons.arrow_right,
                            size: 30,
                            color: AppColor.textFieldBorderColor,
                          ),
                          titleCentered: true,
                          leftChevronMargin: EdgeInsets.only(left: 30.w),
                        ),
                        rangeEndDay: _rangeEnd,
                        calendarStyle: const CalendarStyle(
                          isTodayHighlighted: false,
                          weekendDecoration: BoxDecoration(
                              color: AppColor.appBgColor,
                              shape: BoxShape.circle
                          ),
                          selectedDecoration: BoxDecoration(
                              color: AppColor.titleAndButtonColor,
                              shape: BoxShape.circle
                          ),
                          defaultDecoration: BoxDecoration(
                            color: AppColor.appBgColor,
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
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        selectTime,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 12, color: AppColor.titleAndButtonColor),
                      ),
                      GridView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10),
                        itemCount: timeList.length,
                        itemBuilder: (ctx, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                isSelected = index;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: isSelected == index ? AppColor.titleAndButtonColor : AppColor.appBgColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Center(
                                child: Text(
                                  timeList[index].toString(),
                                  style: AppTextStyle.textNormal.copyWith(
                                    color: isSelected == index ? AppColor.containerColor : AppColor.textFieldBorderColor,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 8 / 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),),
                      const SizedBox(
                        height: 18,
                      ),
                      ButtonWidget(
                        text: next,
                        borderRadius: 8,
                        onTap: () {
                          Get.to(const BookedAppointmentScreen());
                        },
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
