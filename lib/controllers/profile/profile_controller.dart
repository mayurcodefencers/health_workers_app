import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/controllers/consulting/consulting_controller.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/transactionModel.dart';

class ProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();
  TransactionModel? transactionModel;
  final ConsultingController consultingController = Get.put(ConsultingController());

  @override
  void onInit() {
    super.onInit();
    // walletDetails();
  }

  // Future<void> walletDetails() async {
  //   consultingController.getWalletAmount();
  // }

  Future<void> getTransactionList() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };


      final response = await _apiService.getDataWithForm(
          AppConstant.transactionList,
          headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageTransactionList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("TransactionListSuccess");
        transactionModel = TransactionModel.fromJson(jsonMap);

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
      print("TransactionListList $e");
      isLoading.value = false;
    }
  }
}