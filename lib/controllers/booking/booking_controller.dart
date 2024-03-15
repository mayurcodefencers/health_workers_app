import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/all_doctor_model.dart';
import 'package:health_workers/model/booking_list_model.dart';

class BookingController extends GetxController {
  final RxBool isLoading = false.obs;
  RxString? storeAllListDoctorId = "".obs;
  final ApiService _apiService = ApiService();
  var dropdownValuesAllDoctor = [].obs;
  RxString? selectedValueAllDoctor = "".obs;
  var allDoctorModel = AllDoctorModel().obs;
  BookingListModel? bookingListModel;

  void onSelectedAllDoctor(String? value) {
    if (value != null) {
      selectedValueAllDoctor!.value = value;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getAllDoctorList();
  }

  Future<void> getAllDoctorList() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };


      final response = await _apiService.getDataWithForm(
          AppConstant.allDoctorList,
          headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageAllDoctorList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("AllDoctorListSuccess");
        List<dynamic> allDoctorList = jsonMap['doctorlist'];
        allDoctorModel.value = AllDoctorModel.fromJson(jsonMap);
        dropdownValuesAllDoctor.value = allDoctorList;
        print("dataaaaaa ${dropdownValuesAllDoctor.value}");

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
      print("ErrorAllDoctorList $e");
      isLoading.value = false;
    }
  }

  Future<void> getAllBookingList(String doctorId, String hwId) async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };
      var formData = {
        'doctor_id': doctorId,
        'hwid': hwId,
      };

      final response = await _apiService.postDataWithForm(
          formData,
          AppConstant.bookingList,
          headers: headers

      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageAllBookingList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("AllBookingListSuccess");
        // List<dynamic> allDoctorList = jsonMap['doctorlist'];
        bookingListModel = BookingListModel.fromJson(jsonMap);
        // dropdownValuesAllDoctor.value = allDoctorList;
        // print("dataaaaaa ${dropdownValuesAllDoctor.value}");

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
      print("ErrorAllBookingList $e");
      isLoading.value = false;
    }
  }
}