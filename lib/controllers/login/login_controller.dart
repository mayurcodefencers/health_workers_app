import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:health_workers/controllers/auth_controller.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/login_model.dart';
import 'package:health_workers/widgets/bottom_nav_widget.dart';

class LoginController extends GetxController {
  final RxBool isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxString password = "".obs;
  RxBool showPassword = false.obs;
  final ApiService _apiService = ApiService();
  // var loginModel = LoginModel().obs;
  LoginModel? loginModel;
  final AuthController _authController = Get.put(AuthController());

  void toggleShowPassword() {
      showPassword.value = !showPassword.value;
  }

  Future<void> submitLoginData(Map<String, dynamic> formData) async {
    try {
      isLoading.value = true;
      final response = await _apiService.postDataWithForm(
        formData,
        AppConstant.login,
      );
      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("Message ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);

        loginModel = LoginModel.fromJson(jsonMap);

        String? userImage = loginModel!.userData!.first.img;
        String? userName = loginModel!.userData!.first.name;
        String? loginToken = loginModel!.userData!.first.tokenVal;
        String? hwId = loginModel!.userData!.first.id;
        String? cfToken = loginModel!.admindata!.cfToken;

        pref?.setString("userImage", userImage!);
        pref?.setString("userName", userName!);
        pref?.setString("token", loginToken!);
        pref?.setString("cfToken", cfToken!);
        pref?.setString("hwId", hwId!);

        Get.snackbar(
          'Yehhh...',
          jsonMap['message'],
          backgroundColor: AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(
              seconds: 2),
        );

        _authController.setLoggedIn(true);

        Get.to(() => const HomePage());

        emailController.clear();
        passwordController.clear();
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
    }
  }

}