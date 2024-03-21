import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/add_patient_model.dart';
import 'package:health_workers/widgets/bottom_nav_widget.dart';

class AddPatientController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();

   AddPatientModel? addPatientModel;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneControllerExisting = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  RxString? selectedValueGender = "".obs;
  RxString? selectedValueDepartment = "".obs;
  RxString? selectedValueDepartmentExisting = "".obs;
  RxString? selectedValueDoctor = "".obs;
  RxString? selectedValueDoctorExisting = "".obs;
  RxString? hwId = "".obs;

  List<File> selectedImages = [];

  RxString? storeDepartmentId = "".obs;

  void onSelectedGender(String? value) {
    if (value != null) {
      selectedValueGender!.value = value;
    }
  }

  List<String> dropdownValuesGender = {
    "Male",
    "Female",
  }.toList().obs;


  @override
  void onInit() {
    initializeSharedPreferences();
    super.onInit();
  }

  Future<void> initializeSharedPreferences() async {
    hwId?.value = pref?.getString("hwId") ?? "";
  }

  Future<void> addPatient(Map<String, dynamic> formData) async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };

      final response = await _apiService.postDataWithForm(
        formData,
        AppConstant.registerUser,
        headers: headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageRegisterUser ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("RegisterSuccess");
        addPatientModel = AddPatientModel.fromJson(jsonMap);

        Get.to(() => const HomePage());
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        ageController.clear();
        addressController.clear();
        selectedValueGender!.value = "";

        Get.snackbar(
          'Yehhh...!!',
          jsonMap['message'],
          backgroundColor: AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(
              seconds: 2),
        );

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
      print("ErrorRegister $e");
      isLoading.value = false;
    }
  }


}
