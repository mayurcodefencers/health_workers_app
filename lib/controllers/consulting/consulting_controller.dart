import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/book_new_user.dart';
import 'package:health_workers/model/department_list_model.dart';
import 'package:health_workers/model/doctor_list_model.dart';
import 'package:health_workers/model/time_schedule_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';

class ConsultingController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();

  var doctorListModel = DoctorListModel().obs;
  var timeScheduleModel = TimeScheduleModel().obs;
  var departmentListModel = DepartmentListModel().obs;
  BookNewUserAppointmentModel? bookNewUserAppointmentModel;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final phoneControllerExisting = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();

  RxInt isType = 0.obs;
  RxInt? isShift = 0.obs;
  List<String> type = [
    newText,
    existing,
  ].obs;
  List<String> shift = [
    morningTime,
    eveningTime,
  ].obs;

  RxString? selectedValueDepartment = "".obs;
  RxString? selectedValueDoctor = "".obs;
  RxString? hwId = "".obs;

  List<File> selectedImages = [];

  RxString? storeDepartmentId = "".obs;
  RxString? storeDoctorPrice = "".obs;

  List<String> dropdownValuesGender = {
    "Male",
    "Female",
  }.toList().obs;
  var dropdownValuesDepartment = [].obs;

  var dropdownValuesDoctor = [].obs;


  RxString? morningShift = "".obs;
  RxString? eveningShift = "".obs;

  RxString? timeListMorning = "09:00 to 12:00".obs;
  RxString? timeListEvening = "04:00 to 07:00".obs;

  Rx<DateTime?> selectedDay = Rx<DateTime?>(null);


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

  @override
  void onInit() {
    initializeSharedPreferences();
    super.onInit();
    getDepartmentData();
    getTimeData();
  }

  Future<void> initializeSharedPreferences() async {
    hwId?.value = pref?.getString("hwId") ?? "";
  }

  Future<void> getDepartmentData() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };

      final response = await _apiService.getDataWithForm(
          AppConstant.departmentList,
          headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageDepartmentList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        List<dynamic> departmentList = jsonMap['departmentlist'];
        departmentListModel.value = DepartmentListModel.fromJson(jsonMap);
        dropdownValuesDepartment.value = departmentList;

        // Get.to(() => const HomePage());

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
      print("ErrorDepartmentList $e");
      isLoading.value = false;
    }
  }

  Future<void> getDoctorData(String deptId) async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };
      var formData = {
        'department_id': deptId,
      };

      final response = await _apiService.postDataWithForm(
        formData,
        AppConstant.doctorList,
        headers: headers,
      );
      String jsonString = response.data;


      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("DoctorListMessage: ${jsonMap['message']}");


      if (jsonMap['status'] == "200") {
        List<dynamic> doctorList = jsonMap['doctorlist'];
        doctorListModel.value = DoctorListModel.fromJson(jsonMap);

        dropdownValuesDoctor.value = doctorList;


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
      print("ErrorDoctorList: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getTimeData() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };

      final response = await _apiService.getDataWithForm(
          AppConstant.timeSchedule,
          headers
      );

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageTimeSchedule ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("SuccessTime");
        timeScheduleModel.value = TimeScheduleModel.fromJson(jsonMap);

        // Get.to(() => const HomePage());

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
      print("ErrorTimeSchedule $e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> submitNewUserData( Map<String, dynamic>  data, List<File> selectedImages) async {
    try {
      print("Submitting user data...");
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");
      var headers = {
        'Authorization': token ?? '',
        'CF-Token': cfToken ?? '',
        'Content-Type': 'multipart/form-data',
      };

      dio.Dio dioClient = dio.Dio();
      dio.FormData formData = dio.FormData();
      String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDay.value!);
      // Add other form data
      formData.fields.addAll({
        for (var entry in {
          'name': nameController.text,
          'email': emailController.text,
          'phone_no': phoneController.text,
          'age': ageController.text,
          'address': addressController.text,
          'department': selectedValueDepartment!.value.toString(), // Convert to String
          'doctor': selectedValueDoctor!.value.toString(), // Convert to String
          'upload_file[]': selectedImages.toString(), // Convert to String or provide a default value
          'date': formattedDate.toString(), // Convert to String
          'time_shift': isShift?.value == 0
              ? timeScheduleModel.value.timeschedule?.first.morningShift ?? "11"
              : timeScheduleModel.value.timeschedule?.first.eveningShift ?? "11",
          'total_amount': storeDoctorPrice!.value,
          'hwid': hwId!.value,
        }.entries)
          MapEntry(entry.key, entry.value),
      });


      // Add images to FormData
      for (int i = 0; i < selectedImages.length; i++) {
        String fileName = 'image_$i.jpg'; // Adjust filename as needed
        formData.files.add(MapEntry(
          'upload_file[]', // Adjust the key as needed
          await dio.MultipartFile.fromFileSync(
            selectedImages[i].path,
            filename: fileName,
          ),
        ));
      }

      print("wwwwwwww ${formData.fields}");

      // Send POST request
      final response = await dioClient.post(
        "https://saasmeditech.com/Appointment_bookapi/appointment_book",
        data: formData,
        options: dio.Options(headers: headers),
      );

      print("Response Status Code: ${response.statusCode}");

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageTimeSchedule ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("SuccessTime");
        timeScheduleModel.value = TimeScheduleModel.fromJson(jsonMap);

        // Get.to(() => const HomePage());

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
      print("ErrorTimeSchedule $e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

}
