import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/main.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;
  RxString? userStatus = "".obs;
  RxString? token = "".obs;
  RxString? userImage = "".obs;
  RxString? userName = "".obs;

  @override
  void onInit() {
    super.onInit();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    userImage?.value = pref?.getString("userImage") ?? "";
    userName?.value = pref?.getString("userName") ?? "";
    token?.value = pref?.getString("token") ?? "";
  }

}