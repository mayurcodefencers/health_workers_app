import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/booking_list_model.dart';

class BookingController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();
  var dropdownValuesAllDoctor = [].obs;
  RxString? selectedValueAllDoctor = "".obs;

  BookingListModel? bookingListModel;

  void onSelectedAllDoctor(String? value) {
    if (value != null) {
      selectedValueAllDoctor!.value = value;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getMeetingList(String hwid) async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };

      var formData = {
        'hwid': hwid,
      };

      final response = await _apiService.postDataWithForm(
          formData,
          AppConstant.bookingList,
          headers: headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageBookingList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("BookingListSuccess");
        bookingListModel = BookingListModel.fromJson(jsonMap);


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
      print("ErrorBookingList $e");
      isLoading.value = false;
    }
  }
}