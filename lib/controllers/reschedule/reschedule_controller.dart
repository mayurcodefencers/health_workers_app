import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/reschedule_model.dart';
import 'package:health_workers/widgets/bottom_nav_widget.dart';
import 'package:health_workers/widgets/success_screen.dart';

class RescheduleController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();

  RxInt? isSelectedMorning = 0.obs;
  RxInt? isSelectedEvening = 0.obs;
  RxString? storeAppointmentIdReschedule = "".obs;
  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);

  RescheduleModel? rescheduleModel;

  RxInt? isShift = 0.obs;
  List<String> type = [
    newText,
    existing,
  ].obs;
  List<String> shift = [
    morningTime,
    eveningTime,
  ].obs;

  Future<void> rescheduleAppointment(
      String appointmentId,
      String date,
      String time
      ) async {
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
        'date': date,
        'time_shift': time,
      };

      final response = await _apiService.postDataWithForm(
        formData,
        AppConstant.reschedule,
        headers: headers,
      );
      String jsonString = response.data;


      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("RescheduleMessage: ${jsonMap['message']}");


      if (jsonMap['status'] == "200") {
        print("RescheduleSuccess");
        rescheduleModel = RescheduleModel.fromJson(jsonMap);
        Get.to(() => const SuccessScreen());

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
      print("ErrorReschedule: $e");
    } finally {
      isLoading.value = false;
    }
  }
}