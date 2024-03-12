import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/utils/validator.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controllers/consultation/consultation_controller.dart';
import 'package:http/http.dart' as http;
class ConsultationScreen extends StatefulWidget {
  const ConsultationScreen({super.key});

  @override
  State<ConsultationScreen> createState() => _ConsultationScreenState();
}

class _ConsultationScreenState extends State<ConsultationScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ConsultationController newController = Get.put(ConsultationController());
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
   var test= pref?.getString("token");
   print('my token...$test');
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
                  itemCount: newController.type.length ?? 0,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                      onTap: () {
                        newController.isType.value = index;
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
      child: Form(
        key: _formKey,
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
              validator: (String? value) => Validators.validateName(
                  value!.trim()),
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
              validator: (String? value) => Validators.validateEmail(
                  value!.trim()),
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
              validator: (String? value) => Validators.validateMobile(
                  value!.trim()),
              borderRadius: 8,
              maxLength: 10,
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
              validator: (String? value) => Validators.validateAge(
                  value!.trim()),
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
              validator: (String? value) => Validators.validateAddress(
                  value!.trim()),
              maxLine: 3,
              keyboardType: null,
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
            newController.selectedValueDepartment!.value != "" ? Text(
              doctor,
              style: AppTextStyle.mediumText.copyWith(
                  color: AppColor.navyBlueColor,
                  fontSize: 14
              ),
            ) : SizedBox(),
            SizedBox(
              height: 1.h,
            ),
            newController.selectedValueDepartment!.value != ""
            // ||
            // newController.departmentListModel.value.departmentlist?.first.id
            //     == newController.doctorListModel.value.doctorlist?.first.departmentId
                ? doctorWidgetNew() : SizedBox(),
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
              onTap: () {
                getImages();
              },
              child: SvgPicture.asset(
                AppAssets.fileUpload,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: newController.selectedImages.length > 1 ? 24.h : 2.h,
              child: GridView.builder(
                itemCount: newController.selectedImages.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5),
                // padding: EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                      child: kIsWeb
                          ? Image.network(newController.selectedImages[index].path)
                          : Image.file(
                        newController.selectedImages[index],
                        height: 60,
                        width: 60,
                      ));
                },
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
            GridView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              itemCount: newController.shift.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  onTap: () {
                    newController.isShift?.value = index;
                    print("snjndjfnjdnj ${
                        newController.isShift?.value == 0 ?
                        newController.timeScheduleModel.value.timeschedule?.first.morningShift?? "11" :
                        newController.timeScheduleModel.value.timeschedule?.first.eveningShift?? "11"
                    }");
                  },
                  child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              newController.shift[index],
                              style: AppTextStyle.mediumText.copyWith(
                                  color: AppColor.navyBlueColor,
                                  fontSize: 14
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Container(
                              height: 6.h,
                              width: 40.w,
                              decoration: BoxDecoration(
                                color: index == newController.isShift?.value
                                    ? AppColor.primaryColor
                                : AppColor.whiteColor,
                                border: Border.all(color: AppColor.primaryColor),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  index == 0
                                      ? newController.timeScheduleModel.value.timeschedule?.first.morningShift ?? "11"
                                      : newController.timeScheduleModel.value.timeschedule?.first.eveningShift ?? "11",
                                  style: AppTextStyle.normalText.copyWith(
                                    color: index == newController.isShift?.value
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
            SvgPicture.asset(
                AppAssets.line
            ),
            SizedBox(
              height: 1.h,
            ),
            newController.storeDoctorPrice!.value != '' ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalAmount,
                  style: AppTextStyle.semiBoldText.copyWith(
                      color: AppColor.navyBlueColor,
                      fontSize: 20
                  ),
                ),
                Text(
                  newController.storeDoctorPrice!.value.toString(),
                  style: AppTextStyle.mediumText.copyWith(
                      color: AppColor.primaryColor,
                      fontSize: 24
                  ),
                ),
              ],
            ) : const SizedBox(),
            SizedBox(
              height: 5.h,
            ),

            Center(
              child: ButtonWidget(
                text: payNow,
                borderRadius: 8,
                width: 50.w,
                textStyle: AppTextStyle.mediumText.copyWith(
                    color: AppColor.whiteColor
                ),
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final formData = {
                      'name' : newController.nameController.text,
                      'email' : newController.emailController.text,
                      'phone_no' : newController.phoneController.text,
                      'age' : newController.ageController.text,
                      'gender' : newController.selectedValueGender!.value,
                      'address' : newController.addressController.text,
                      'department' : newController.selectedValueDepartment!.value,
                     // 'upload_file[]' : newController.selectedImages ?? '',
                      'date' : _selectedDay,
                      'time_shift' : newController.isShift?.value == 0 ?
                      newController.timeScheduleModel.value.timeschedule?.first.morningShift?? "11" :
                      newController.timeScheduleModel.value.timeschedule?.first.eveningShift?? "11",
                      'total_amount' : newController.storeDoctorPrice!.value,
                      'hwid' : newController.hwId!.value,
                    };
                     newController.submitNewUserData(formData);
                    print("formDataaaa $formData");
                  }
                },
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
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
          departmentWidgetExisting(),
          SizedBox(
            height: 2.h,
          ),
          newController.selectedValueDepartmentExisting!.value != "" ? Text(
            doctor,
            style: AppTextStyle.mediumText.copyWith(
                color: AppColor.navyBlueColor,
                fontSize: 14
            ),
          ) : const SizedBox(),
          SizedBox(
            height: 1.h,
          ),
          newController.selectedValueDepartmentExisting!.value != "" ?
          doctorWidgetExisting()
          : const SizedBox(),
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
          SizedBox(
        height: 1.h,
      ),
          Container(
            height: 6.h,
            width: 40.w,
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                  newController.timeScheduleModel.value.timeschedule?.first.morningShift?.toString() ?? '11',                  style: AppTextStyle.normalText.copyWith(
                    color: AppColor.whiteColor,
                  )) ,
              ),
            ),
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
          Container(
            height: 6.h,
            width: 40.w,
            decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                newController.timeScheduleModel.value.timeschedule?.first.eveningShift?.toString() ?? '11',                style: AppTextStyle.normalText.copyWith(
                  color: AppColor.whiteColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          SvgPicture.asset(
              AppAssets.line
          ),
          SizedBox(
            height: 1.h,
          ),
          newController.storeDoctorPriceExisting!.value != '' ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                totalAmount,
                style: AppTextStyle.semiBoldText.copyWith(
                    color: AppColor.navyBlueColor,
                    fontSize: 20
                ),
              ),
              Text(
                newController.storeDoctorPriceExisting!.value,
                style: AppTextStyle.mediumText.copyWith(
                    color: AppColor.primaryColor,
                    fontSize: 24
                ),
              ),
            ],
          ) : const SizedBox(),
          SizedBox(
            height: 5.h,
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
          return value == null ? "Choose Gender" : null;
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
          return value == null ? "Choose Department" : null;
        },
        items: newController.dropdownValuesDepartment
            .map<DropdownMenuItem<String>>((dynamic value) {
          String departmentValue = value['department'];
          return DropdownMenuItem<String>(
            onTap: () {
              newController.storeDepartmentId?.value = value['id'];
              newController.getDoctorData(newController.storeDepartmentId!.value);
              },
            value: departmentValue,
            child: Text(departmentValue),
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
    return Obx(() {
      if (newController.dropdownValuesDoctor.isEmpty) {
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
            items: newController.dropdownValuesDoctor
                .map<DropdownMenuItem<String>>((dynamic value) {
              String doctorValue = value['name'];
              return DropdownMenuItem<String>(
                onTap: () {
                  newController.storeDoctorPrice!.value = value['price'];
                },
                value: doctorValue,
                child: Text(doctorValue),
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
        );
      }
    });
  }

  Widget departmentWidgetExisting() {
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
        items: newController.dropdownValuesDepartmentExisting
            .map<DropdownMenuItem<String>>((dynamic value) {
          String departmentValueExisting = value['department'];
          return DropdownMenuItem<String>(
            onTap: () {
              newController.storeDepartmentId?.value = value['id'];
              newController.getDoctorData(newController.storeDepartmentId!.value);
            },
            value: departmentValueExisting,
            child: Text(departmentValueExisting),
          );
        }).toList(),
        onChanged: newController.onSelectedDepartmentExisting,
        icon: const Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 30,
          color: AppColor.navyBlueColor,
        ),
        value: newController.selectedValueDepartmentExisting!.value.isNotEmpty
            ? newController.selectedValueDepartmentExisting!.value
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
  Widget doctorWidgetExisting() {
    return Obx(() {
      if (newController.dropdownValuesDoctorExisting.isEmpty) {
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
            items: newController.dropdownValuesDoctorExisting
                .map<DropdownMenuItem<String>>((dynamic value) {
              String doctorValueExisting = value['name'];
              return DropdownMenuItem<String>(
                onTap: () {
                  newController.storeDoctorPriceExisting!.value = value['price'];
                },
                value: doctorValueExisting,
                child: Text(doctorValueExisting),
              );
            }).toList(),
            onChanged: newController.onSelectedDoctorExisting,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
              color: AppColor.navyBlueColor,
            ),
            value: newController.selectedValueDoctorExisting!.value.isNotEmpty
                ? newController.selectedValueDoctorExisting!.value
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
        );
      }
    });
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
            () {
          if (xfilePick.isNotEmpty) {
            for (var i = 0; i < xfilePick.length; i++) {
              newController.selectedImages.add(File(xfilePick[i].path));
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Nothing is selected')));
          }
        },
    );
}
  Future<List<File>> pickMultipleImages() async {
    List<XFile> xFiles = await ImagePicker().pickMultiImage(); // Use pickMultiImage() to select multiple images
    List<File> images = [];
    for (XFile file in xFiles) {
      images.add(File(file.path));
    }
    return images;
  }



/*  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  Future<void> _getImages() async {
    List<XFile>? pickedFiles = await _picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedFiles != null) {
      setState(() {
        _selectedImages.clear();
        for (var file in pickedFiles) {
          _selectedImages.add(File(file.path));
        }
      });
    }
  }

  Future<void> _uploadImages() async {
    Dio dio = Dio();

    FormData formData = FormData();

    for (var file in _selectedImages) {
      String fileName = file.path.split("/").last;
      formData.files.add(MapEntry(
        'upload_file[]',
        await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      ));
    }

    formData.fields.addAll({
      'name': 'ere',
      'email': 'a@a.com',
      'phone_no': '12121212121',
      'age': '12121212121',
      'gender': '12121212121',
      'address': '12121212121',
      'department': '12121212121',
      'doctor': '12121212121',
      'date': '12121212121',
      'time_shift': '12121212121',
      'total_amount': '12121212121',
      'hwid': '12121212121',
    });

    try {
      Response response = await dio.post(
        'https://saasmeditech.com/Appointment_bookapi/appointment_book',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'mrXSxT4n2Ff9Dr1a1mL5',
            'CF-Token': '123',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.data;
        if (responseData['status'] == '200') {
          print("2000000");
          return response.data.toString();
        } else {
          return response.data.toString();
        }
      } else {
        throw Exception('Failed to upload images');
      }
    } catch (e) {
      throw Exception('Failed to upload images: $e');
    }
  }*/


}
