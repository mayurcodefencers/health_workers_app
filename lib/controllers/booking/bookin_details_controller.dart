import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/booking_details_model.dart';

class BookingDetailsController extends GetxController {
  final RxBool isLoading = false.obs;
  BookingDetailsModel? bookingDetailsModel;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> bookingDetails(String appointmentId) async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };
      var formData = {
        'appointment_id': appointmentId,
      };

      final response = await _apiService.postDataWithForm(
          formData,
          AppConstant.bookingDetails,
          headers: headers

      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageBookingDetails ${jsonMap['message']}");
      print("MessageBookingDetails ${jsonMap}");

      if (jsonMap['status'] == "200") {
        print("BookingDetailsSuccess");
        // List<dynamic> allDoctorList = jsonMap['doctorlist'];
        bookingDetailsModel = BookingDetailsModel.fromJson(jsonMap);
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
      print("ErrorBookingDetails $e");
      isLoading.value = false;
    }
  }
}