import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/department_list_model.dart';
import 'package:health_workers/model/doctor_list_model.dart';
import 'package:health_workers/model/time_schedule_model.dart';

class ConsultationController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();
  DepartmentListModel? departmentListModel;
  DoctorListModel? doctorListModel;
  TimeScheduleModel? timeScheduleModel;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneControllerExisting = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  RxInt isType = 0.obs;
  List<String> type = [
    newText,
    existing,
  ].obs;

  RxString? selectedValueGender = "".obs;
  RxString? selectedValueDepartment = "".obs;
  RxString? selectedValueDepartmentExisting = "".obs;
  RxString? selectedValueDoctor = "".obs;
  RxString? selectedValueDoctorExisting = "".obs;

  RxString? storeDepartmentId = "".obs;

  List<String> dropdownValuesGender = {
    "Male",
    "Female",
  }.toList().obs;
  var dropdownValuesDepartment = [].obs;
  List<String> dropdownValuesDepartmentExisting = {
    "1",
    "2",
    "3",
    "4",
    "5",
  }.toList().obs;

  var dropdownValuesDoctor = [].obs;
  List<String> dropdownValuesDoctorExisting = {
    "Doctor 1",
    "Doctor 2",
    "Doctor 3",
    "Doctor 4",
    "Doctor 5",
  }.toList().obs;


  RxInt? isSelectedMorning = 0.obs;
  RxInt? isSelectedMorningExisting = 0.obs;
  RxInt? isSelectedEvening = 0.obs;
  RxInt? isSelectedEveningExisting = 0.obs;

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
    super.onInit();
    getDepartmentData();
    getTimeData();
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
        departmentListModel = DepartmentListModel.fromJson(jsonMap);
        dropdownValuesDepartment.value = departmentList;

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
        doctorListModel = DoctorListModel.fromJson(jsonMap);

        dropdownValuesDoctor.value = doctorList;


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

        timeScheduleModel = TimeScheduleModel.fromJson(jsonMap);

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
}
