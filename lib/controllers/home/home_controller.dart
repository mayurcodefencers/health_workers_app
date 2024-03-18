import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/controllers/consulting/consulting_controller.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/upcoming_model.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  RxString? userStatus = "".obs;
  RxString? token = "".obs;
  RxString? userImage = "".obs;
  RxString? userName = "".obs;
  RxString? hwId = "".obs;
  final ApiService _apiService = ApiService();
  UpcomingModel? upcomingModel;
  final ConsultingController consultingController = Get.put(ConsultingController());

  @override
  void onInit() {
    super.onInit();
    initializeSharedPreferences();
    upcomingList();
    consultingController.getWalletAmount();
  }


  Future<void> initializeSharedPreferences() async {
    userImage?.value = pref?.getString("userImage") ?? "";
    userName?.value = pref?.getString("userName") ?? "";
    token?.value = pref?.getString("token") ?? "";
    hwId?.value = pref?.getString("hwId") ?? "";
  }


  Future<void> upcomingList() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };


      final response = await _apiService.getDataWithForm(
          AppConstant.upcoming,
          headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageUpcomingList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("UpcomingListSuccess");
        upcomingModel = UpcomingModel.fromJson(jsonMap);

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
      print("ErrorUpcomingList $e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

}