import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controllers/consultation/consultation_controller.dart';

class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  final ConsultationController newController = Get.put(ConsultationController());
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
        child: Obx(() => Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h
              ),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.pureWhiteColor,
                    borderRadius: BorderRadius.circular(4)),
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  itemCount: newController.type.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        newController.isType.value = index;
                        // String? getUserId = pref?.getString("userId");
                        // controller.isSelectedBooking.value == 0
                        //     ? controller.getOrderListData(controller.userLoginId!.value)
                        //     : controller.pastOrderListData(getUserId!);
                      },
                      child: Obx(
                            () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 10.h,
                              width: 30.w,
                              decoration: BoxDecoration(
                                  color: newController.isType.value == index
                                      ? AppColor.primaryColor
                                      : AppColor.pureWhiteColor,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                child: Text(
                                  newController.type[index].toString(),
                                  style: AppTextStyle.semiBoldText.copyWith(
                                    fontSize: 16,
                                    color: newController.isType.value == index
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
                    crossAxisCount: 2,
                    childAspectRatio: 10 / 3,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 10,
                  ),
                ),
              ),
            ),
            newController.isType.value == 0 ? newUserWidget() : existingUserWidget(),
          ],
        ),)
      ),
    );
  }
  Widget newUserWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 5.w
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          CustomTextField(
            label: name,
            controller: newController.nameController,
            borderRadius: 8,
            keyboardType: null,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            email,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          CustomTextField(
            label: emailEnter,
            controller: newController.emailController,
            borderRadius: 8,
            keyboardType: null,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            phoneNo,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          CustomTextField(
            label: phoneNo,
            controller: newController.phoneController,
            borderRadius: 8,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            age,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          CustomTextField(
            label: age,
            controller: newController.ageController,
            borderRadius: 8,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            gender,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          genderWidgetNew(),
          SizedBox(
            height: 2.h,
          ),
          Text(
            address,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          CustomTextField(
            label: age,
            controller: newController.addressController,
            borderRadius: 8,
            maxLine: 3,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            department,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          departmentWidgetNew(),
          SizedBox(
            height: 2.h,
          ),
          Text(
            doctor,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          doctorWidgetNew(),
          SizedBox(
            height: 2.h,
          ),
          Text(
            fileUpload,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
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
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: newController.timeListMorning.length,
            itemBuilder: (ctx, index) {
              return Obx(() => GestureDetector(
                onTap: () {
                  newController.isSelectedMorning?.value = index;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: newController.isSelectedMorning?.value == index ? AppColor.primaryColor : AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      newController.timeListMorning[index].toString(),
                      style: AppTextStyle.normalText.copyWith(
                        color: newController.isSelectedMorning?.value == index ? AppColor.whiteColor : AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ));
            }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 8 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),),
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
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: newController.timeListEvening.length,
            itemBuilder: (ctx, index) {
              return Obx(() => GestureDetector(
                onTap: () {
                  newController.isSelectedEvening?.value = index;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: newController.isSelectedEvening?.value == index ? AppColor.primaryColor : AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      newController.timeListEvening[index].toString(),
                      style: AppTextStyle.normalText.copyWith(
                        color: newController.isSelectedEvening?.value == index ? AppColor.whiteColor : AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ));
            }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 8 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),),
          SizedBox(
            height: 8.h,
          ),
          Center(
            child: ButtonWidget(
              text: payNow,
              borderRadius: 8,
              width: 50.w,
              textStyle: AppTextStyle.mediumText.copyWith(
                  color: AppColor.whiteColor
              ),
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
  Widget existingUserWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 5.w
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            phoneNo,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          CustomTextField(
            label: phoneNo,
            controller: newController.phoneControllerExisting,
            borderRadius: 8,
            keyboardType: TextInputType.number,
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: AppColor.pureWhiteColor,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
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
                  "Mr Mukesh Parmar",
                  style: AppTextStyle.semiBoldText.copyWith(
                      color: AppColor.navyBlueColor,
                      fontSize: 16
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  "+91 7990230441",
                  style: AppTextStyle.mediumText.copyWith(
                      color: AppColor.greyColor,
                      fontSize: 10
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            department,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          departmentWidgetNew(),
          SizedBox(
            height: 2.h,
          ),
          Text(
            doctor,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          doctorWidgetNew(),
          SizedBox(
            height: 2.h,
          ),
          Text(
            fileUpload,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
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
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: newController.timeListMorning.length,
            itemBuilder: (ctx, index) {
              return Obx(() => GestureDetector(
                onTap: () {
                  newController.isSelectedMorning?.value = index;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: newController.isSelectedMorning?.value == index ? AppColor.primaryColor : AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      newController.timeListMorning[index].toString(),
                      style: AppTextStyle.normalText.copyWith(
                        color: newController.isSelectedMorning?.value == index ? AppColor.whiteColor : AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ));
            }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 8 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),),
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
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: newController.timeListEvening.length,
            itemBuilder: (ctx, index) {
              return Obx(() => GestureDetector(
                onTap: () {
                  newController.isSelectedEvening?.value = index;
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: newController.isSelectedEvening?.value == index ? AppColor.primaryColor : AppColor.whiteColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      newController.timeListEvening[index].toString(),
                      style: AppTextStyle.normalText.copyWith(
                        color: newController.isSelectedEvening?.value == index ? AppColor.whiteColor : AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
              ));
            }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 8 / 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),),
          SizedBox(
            height: 8.h,
          ),
          Center(
            child: ButtonWidget(
              text: payNow,
              borderRadius: 8,
              width: 50.w,
              textStyle: AppTextStyle.mediumText.copyWith(
                  color: AppColor.whiteColor
              ),
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
  Widget genderWidgetNew() {
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
          return value == null ? "Choose Note from list" : null;
        },
        items: newController.dropdownValuesGender
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: newController.onSelectedGender,
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
          color: AppColor.navyBlueColor,
        ),
        value: newController.selectedValueGender!.value.isNotEmpty
            ? newController.selectedValueGender!.value
            : null,
        hint: Text(
            selectGender,
            style: AppTextStyle.mediumText.copyWith(
              color: AppColor.navyBlueColor,
              fontSize: 14
          ),
        ),
        isExpanded: false,
      ),
    ));
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
          return value == null ? "Choose Note from list" : null;
        },
        items: newController.dropdownValuesDepartment
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: newController.onSelectedDepartment,
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
          color: AppColor.navyBlueColor,
        ),
        value: newController.selectedValueDepartment!.value.isNotEmpty
            ? newController.selectedValueDepartment!.value
            : null,
        hint: Text(
            selectDepartment,
            style: AppTextStyle.mediumText.copyWith(
              color: AppColor.navyBlueColor,
              fontSize: 14
          ),
        ),
        isExpanded: false,
      ),
    ));
  }
  Widget doctorWidgetNew() {
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
          return value == null ? "Choose Note from list" : null;
        },
        items: newController.dropdownValuesDoctor
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: newController.onSelectedDoctor,
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
          color: AppColor.navyBlueColor,
        ),
        value: newController.selectedValueDoctor!.value.isNotEmpty
            ? newController.selectedValueDoctor!.value
            : null,
        hint: Text(
            selectDoctor,
            style: AppTextStyle.mediumText.copyWith(
              color: AppColor.navyBlueColor,
              fontSize: 14
          ),
        ),
        isExpanded: false,
      ),
    ));
  }

}
