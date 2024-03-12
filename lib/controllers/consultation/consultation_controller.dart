import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/book_new_user.dart';
import 'package:health_workers/model/department_list_model.dart';
import 'package:health_workers/model/doctor_list_model.dart';
import 'package:health_workers/model/time_schedule_model.dart';

class ConsultationController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();

  var doctorListModel = DoctorListModel().obs;
  var timeScheduleModel = TimeScheduleModel().obs;
  var departmentListModel = DepartmentListModel().obs;
  BookNewUserAppointmentModel? bookNewUserAppointmentModel;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneControllerExisting = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  RxInt isType = 0.obs;
  RxInt? isShift = 0.obs;
  List<String> type = [
    newText,
    existing,
  ].obs;
  List<String> shift = [
    morningTime,
    eveningTime,
  ].obs;

  RxString? selectedValueGender = "".obs;
  RxString? selectedValueDepartment = "".obs;
  RxString? selectedValueDepartmentExisting = "".obs;
  RxString? selectedValueDoctor = "".obs;
  RxString? selectedValueDoctorExisting = "".obs;
  RxString? hwId = "".obs;

  List<File> selectedImages = [];

  RxString? storeDepartmentId = "".obs;
  RxString? storeDoctorPrice = "".obs;
  RxString? storeDoctorPriceExisting = "".obs;

  List<String> dropdownValuesGender = {
    "Male",
    "Female",
  }.toList().obs;
  var dropdownValuesDepartment = [].obs;
  var dropdownValuesDepartmentExisting = [].obs;

  var dropdownValuesDoctor = [].obs;
  var dropdownValuesDoctorExisting = [].obs;


  RxString? morningShift = "".obs;
  RxString? eveningShift = "".obs;

  RxString? timeListMorning = "09:00 to 12:00".obs;
  RxString? timeListMorningExisting = "09:00 to 12:00".obs;
  RxString? timeListEvening = "04:00 to 07:00".obs;
  RxString? timeListEveningExisting = "04:00 to 07:00".obs;

  void onSelectedGender(String? value) {
    if (value != null) {
      selectedValueGender!.value = value;
    }
  }
  void onSelectedDepartment(String? value) {
    if (value != null) {
      selectedValueDepartment!.value = value;
    }
  }
  void onSelectedDepartmentExisting(String? value) {
    if (value != null) {
      selectedValueDepartmentExisting!.value = value;
    }
  }
  void onSelectedDoctor(String? value) {
    if (value != null) {
      selectedValueDoctor!.value = value;
    }
  }
  void onSelectedDoctorExisting(String? value) {
    if (value != null) {
      selectedValueDoctorExisting!.value = value;
    }
  }

  @override
  void onInit() {
    initializeSharedPreferences();
    super.onInit();
    getDepartmentData();
    getTimeData();
  }

  Future<void> initializeSharedPreferences() async {
    hwId?.value = pref?.getString("hwId") ?? "";
  }

  Future<void> getDepartmentData() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };

      final response = await _apiService.getDataWithForm(
        AppConstant.departmentList,
        headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageDepartmentList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        List<dynamic> departmentList = jsonMap['departmentlist'];
        departmentListModel.value = DepartmentListModel.fromJson(jsonMap);
        dropdownValuesDepartment.value = departmentList;
        dropdownValuesDepartmentExisting.value = departmentList;

        // Get.to(() => const HomePage());

        isLoading.value = false;
      } else {
        Get.snackbar(
          'OOPS...!!',
          jsonMap['message'],
          backgroundColor: AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(
              seconds: 2),
        );
        isLoading.value = false;
      }
    } catch (e) {
      print("ErrorDepartmentList $e");
      isLoading.value = false;
    }
  }

  Future<void> getDoctorData(String deptId) async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };
      var formData = {
        'department_id': deptId,
      };

      final response = await _apiService.postDataWithForm(
        formData,
        AppConstant.doctorList,
        headers: headers,
      );
      String jsonString = response.data;


      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("DoctorListMessage: ${jsonMap['message']}");


      if (jsonMap['status'] == "200") {
        List<dynamic> doctorList = jsonMap['doctorlist'];
        doctorListModel.value = DoctorListModel.fromJson(jsonMap);

        dropdownValuesDoctor.value = doctorList;
        dropdownValuesDoctorExisting.value = doctorList;


      } else {
        Get.snackbar(
          'Oops!',
          jsonMap['message'],
          backgroundColor: AppColor.primaryColor,
          colorText: AppColor.whiteColor,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      print("ErrorDoctorList: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTimeData() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };

      final response = await _apiService.getDataWithForm(
          AppConstant.timeSchedule,
          headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageTimeSchedule ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
          print("SuccessTime");
        timeScheduleModel.value = TimeScheduleModel.fromJson(jsonMap);

        // Get.to(() => const HomePage());

        isLoading.value = false;
      } else {
        Get.snackbar(
          'OOPS...!!',
          jsonMap['message'],
          backgroundColor: AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(
              seconds: 2),
        );
        isLoading.value = false;
      }
    } catch (e) {
      print("ErrorTimeSchedule $e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitNewUserData(Map<String, dynamic> formData) async {
    try {
      print("kndfndkf");
      isLoading.value = true;
      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");
      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };
      final response = await _apiService.postDataWithForm(
        formData,
        AppConstant.bookNewAppointment,
        headers: headers
      );
      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageNewUserBook ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);

        bookNewUserAppointmentModel = BookNewUserAppointmentModel.fromJson(jsonMap);


        Get.snackbar(
          'Yehhh...',
          jsonMap['message'],
          backgroundColor: AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(
              seconds: 2),
        );

        // Get.to(() => const HomePage());

        isLoading.value = false;
      } else {
        Get.snackbar(
          'OOPS...!!',
          jsonMap['message'],
          backgroundColor: AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(
              seconds: 2),
        );
        isLoading.value = false;
      }
    } catch (e) {
      print("ErrorLogin $e");
      isLoading.value = false;
    }  finally {
      isLoading.value = false;
    }
  }
}
