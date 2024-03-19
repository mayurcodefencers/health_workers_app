import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/dio_services/api_service.dart';
import 'package:health_workers/dio_services/api_url_constant.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/model/appoinment_list_model.dart';
import 'package:health_workers/model/book_new_user.dart';
import 'package:health_workers/model/department_list_model.dart';
import 'package:health_workers/model/doctor_list_model.dart';
import 'package:health_workers/model/time_schedule_model.dart';
import 'package:health_workers/model/wallet_amount_model.dart';
import 'package:health_workers/widgets/bottom_nav_widget.dart';
import 'package:health_workers/widgets/success_screen.dart';
import 'package:intl/intl.dart';

class ConsultingController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiService _apiService = ApiService();

  var doctorListModel = DoctorListModel().obs;
  var timeScheduleModel = TimeScheduleModel().obs;
  var departmentListModel = DepartmentListModel().obs;
  var bookUserAppointmentModel = BookUserAppointmentModel().obs;
  AppointmentListModel? appointmentListModel;
  WalletAmountModel? walletAmountModel;

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
  RxString? storeDoctorId = "".obs;
  RxString? storeDoctorPrice = "".obs;

  List<String> dropdownValuesGender = {
    "Male",
    "Female",
  }.toList().obs;
  var dropdownValuesDepartment = [].obs;

  var dropdownValuesDoctor = [].obs;

  RxInt selectedContainerIndex = RxInt(-1);
  RxString? getPatientId = "".obs;

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
          AppConstant.departmentList, headers);

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
          backgroundColor:
              AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(seconds: 2),
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

      final response =
          await _apiService.getDataWithForm(AppConstant.timeSchedule, headers);

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
          backgroundColor:
              AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(seconds: 2),
        );
        isLoading.value = false;
      }
    } catch (e) {
      print("ErrorTimeSchedule $e");
      isLoading.value = false;
    }
    // finally {
    //   isLoading.value = false;
    // }
  }

  Future<void> getWalletAmount() async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };

      final response =
          await _apiService.getDataWithForm(AppConstant.walletAmount, headers);

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);

      print("MessageWalletAmount ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("SuccessWalletAmount");
        walletAmountModel = WalletAmountModel.fromJson(jsonMap);

        // Get.to(() => const HomePage());

        isLoading.value = false;
      } else {
        Get.snackbar(
          'OOPS...!!',
          jsonMap['message'],
          backgroundColor:
              AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(seconds: 2),
        );
        isLoading.value = false;
      }
    } catch (e) {
      print("ErrorWalletAmount $e");
      isLoading.value = false;
    }
    // finally {
    //   isLoading.value = false;
    // }
  }

  Future<void> appointmentList(Map<String, dynamic> formData) async {
    try {
      isLoading.value = true;

      var token = pref?.getString("token");
      var cfToken = pref?.getString("cfToken");

      var headers = {
        'Authorization': token ?? '', // Add default value if token is null
        'CF-Token': cfToken ?? '', // Add default value if cfToken is null
      };

      final response = await _apiService.postDataWithForm(
          formData, AppConstant.appointmentList,
          headers: headers);

      String jsonString = response.data;
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      print("appointmentListModel $jsonMap");

      print("MessageAppointmentList ${jsonMap['message']}");

      if (jsonMap['status'] == "200") {
        print("AppointmentList");
        appointmentListModel = AppointmentListModel.fromJson(jsonMap);
        print("wwwwwww ${appointmentListModel!.appointmentlist!.length}");
        getWalletAmount();
        isLoading.value = false;
      } else {
        Get.snackbar(
          'OOPS...!!',
          jsonMap['message'],
          backgroundColor:
              AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(seconds: 2),
        );
        isLoading.value = false;
      }
    } catch (e) {
      print("ErrorDepartmentList $e");
      isLoading.value = false;
    }
  }

  Future<void> submitUserData(List<File> selectedImages) async {
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
      String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch((selectedDay.value ?? DateTime.now()).millisecondsSinceEpoch));

      // Add other form data
      formData.fields.addAll({
        for (var entry in {
          'department':
              storeDepartmentId!.value.toString(), // Convert to String
          'doctor': storeDoctorId!.value.toString(), // Convert to String
          'date': formattedDate.toString(),
          'time_shift': isShift?.value == 0
              ? timeScheduleModel.value.timeschedule?.morningShift.toString() ??
                  "11"
              : timeScheduleModel.value.timeschedule?.eveningShift.toString() ??
                  "11",
          'total_amount': storeDoctorPrice!.value.toString(),
          'hwid': hwId!.value.toString(),
          'uid': getPatientId!.value.toString()
        }.entries)
          MapEntry(entry.key, entry.value.toString()),
      });
      print("dndnknknfnf ${appointmentListModel?.appointmentlist?.first.id}");
      print("department ${storeDepartmentId!.value.toString()}");
      print("doctor ${storeDoctorId!.value.toString()}");
      print("date ${formattedDate.toString()}");
      print("upload_file[] $selectedImages");

      if (selectedImages.isNotEmpty) {
        for (int i = 0; i < selectedImages.length; i++) {
          String fileName = 'image_$i.jpg';
          formData.files.add(MapEntry(
            'upload_file[]',
            await dio.MultipartFile.fromFileSync(
              selectedImages[i].path,
              filename: fileName,
            ),
          ));
        }
      } else {
        formData.files.add(MapEntry(
          'upload_file[]',
          dio.MultipartFile.fromString('', filename: 'empty_file.txt'),
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
        print("SuccessBookPatient");
        bookUserAppointmentModel.value =
            BookUserAppointmentModel.fromJson(jsonMap);
        appointmentListModel?.appointmentlist = null;
        phoneController.clear();
        selectedContainerIndex.value = -1;
        selectedValueDepartment!.value = "";
        selectedValueDoctor!.value = "";
        selectedImages.clear();
        selectedDay.value = null;
        isShift?.value = 0;
        storeDoctorPrice?.value = '';

        Get.to(() => const SuccessScreen());

        isLoading.value = false;
      } else {
        Get.snackbar(
          'OOPS...!!',
          jsonMap['message'],
          backgroundColor:
              AppColor.primaryColor, // Customize the background color
          colorText: AppColor.whiteColor, // Customize the text color
          snackPosition: SnackPosition.BOTTOM, // Position of the SnackBar
          duration: const Duration(seconds: 2),
        );
        isLoading.value = false;
      }
    } catch (e) {
      print("ErrorSlotBooked $e");
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
