import 'dart:convert';

import 'package:get/get.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/complete_model.dart';
import 'package:health_workers/model/missing_model.dart';

class MeetingController extends GetxController {
  final RxBool isLoading = false.obs;
  RxInt isType = 0.obs;
  final ApiService _apiService = ApiService();
  MissingMeetingModel? missingMeetingModel;
  CompleteMeetingModel? completeMeetingModel;
  List<String> type = [
    upcoming,
    missedAppointment,
    history
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getMissingList() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };


      final response = await _apiService.getDataWithForm(
          AppConstant.missingMeeting,
          headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageMissingList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("MissingListSuccess");
        missingMeetingModel = MissingMeetingModel.fromJson(jsonMap);

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
      print("ErrorMissingList $e");
      isLoading.value = false;
    }
  }

  Future<void> getCompleteList() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };


      final response = await _apiService.getDataWithForm(
          AppConstant.completeMeeting,
          headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageCompleteList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("CompleteListSuccess");
        completeMeetingModel = CompleteMeetingModel.fromJson(jsonMap);

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
      print("ErrorCompleteList $e");
      isLoading.value = false;
    }
  }
}