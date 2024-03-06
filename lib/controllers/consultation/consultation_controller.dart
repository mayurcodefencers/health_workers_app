import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:health_workers/core/strings.dart';

class ConsultationController extends GetxController {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneControllerExisting = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  RxInt isType = 0.obs;
  List<String> type = [
    newText,
    existing,
  ].obs;

  RxString? selectedValueGender = "".obs;
  RxString? selectedValueDepartment = "".obs;
  RxString? selectedValueDoctor = "".obs;
  List<String> dropdownValuesGender = {
    "Male",
    "Female",
  }.toList().obs;
  List<String> dropdownValuesDepartment = {
    "1",
    "2",
    "3",
    "4",
    "5",
  }.toList().obs;
  List<String> dropdownValuesDoctor = {
    "Doctor 1",
    "Doctor 2",
    "Doctor 3",
    "Doctor 4",
    "Doctor 5",
  }.toList().obs;


  RxInt? isSelectedMorning = 0.obs;
  RxInt? isSelectedEvening = 0.obs;

  List<String> timeListMorning =
  [
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
  ].toList().obs;

  List<String> timeListEvening =
      [
        "04:00 PM",
        "06:00 PM",
        "08:00 PM",
      ].toList().obs;

  void onSelectedGender(String? value) {
    if (value != null) {
      selectedValueGender!.value = value;
    }
  }
  void onSelectedDepartment(String? value) {
    if (value != null) {
      selectedValueDepartment!.value = value;
    }
  }
  void onSelectedDoctor(String? value) {
    if (value != null) {
      selectedValueDoctor!.value = value;
    }
  }
}
