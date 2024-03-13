import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/add_patient/add_patient_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/main.dart';
import 'package:health_workers/screens/consulting/consulting_screen.dart';
import 'package:health_workers/utils/validator.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

class PatientRegisterScreen extends StatefulWidget {
  const PatientRegisterScreen({super.key});

  @override
  State<PatientRegisterScreen> createState() => _PatientRegisterScreenState();
}

class _PatientRegisterScreenState extends State<PatientRegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddPatientController newController = Get.put(AddPatientController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          addMember,
          style: AppTextStyle.boldText
              .copyWith(color: AppColor.primaryColor, fontSize: 22),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColor.navyBlueColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 3.h,
            ),
            newUserWidget()
            // existingUserWidget(),
          ],
        ),
      ),
    );
  }

  Widget newUserWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              label: name,
              controller: newController.nameController,
              validator: (String? value) =>
                  Validators.validateName(value!.trim()),
              borderRadius: 8,
              keyboardType: null,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              email,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              label: emailEnter,
              controller: newController.emailController,
              validator: (String? value) =>
                  Validators.validateEmail(value!.trim()),
              borderRadius: 8,
              keyboardType: null,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              phoneNo,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              label: phoneNo,
              controller: newController.phoneController,
              validator: (String? value) =>
                  Validators.validateMobile(value!.trim()),
              borderRadius: 8,
              maxLength: 10,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              age,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              label: age,
              controller: newController.ageController,
              validator: (String? value) =>
                  Validators.validateAge(value!.trim()),
              borderRadius: 8,
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              gender,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            genderWidgetNew(),
            SizedBox(
              height: 2.h,
            ),
            Text(
              address,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomTextField(
              label: age,
              controller: newController.addressController,
              borderRadius: 8,
              validator: (String? value) =>
                  Validators.validateAddress(value!.trim()),
              maxLine: 3,
              keyboardType: null,
            ),
            SizedBox(
              height: 2.h,
            ),
            Center(
              child: ButtonWidget(
                text: addMember,
                borderRadius: 8,
                width: 50.w,
                textStyle: AppTextStyle.mediumText
                    .copyWith(color: AppColor.whiteColor),
                onTap: () {
                  Get.to(() => ConsultingScreen());
                  if (_formKey.currentState!.validate()) {
                    // String formattedDate = DateFormat('dd/MM/yyyy').format(newController.selectedDay.value!);
                    Map<String, dynamic> formData = {
                      'name': newController.nameController.text,
                      'email': newController.emailController.text,
                      'phone_no': newController.phoneController.text,
                      'age': newController.ageController.text,
                      'gender': newController.selectedValueGender!.value,
                      'address': newController.addressController.text,
                      'hwid': newController.hwId!.value,
                    };
                    newController.addPatient(formData);
                    // print("formDataaaa $formData");
                  }
                },
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget genderWidgetNew() {
    return Obx(() => DropdownButtonHideUnderline(
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(16),
              fillColor: AppColor.skyBlueColor,
              filled: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.skyBlueColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColor.skyBlueColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            validator: (String? value) {
              return value == null ? "Choose Gender" : null;
            },
            items: newController.dropdownValuesGender
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: newController.onSelectedGender,
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 30,
              color: AppColor.navyBlueColor,
            ),
            value: newController.selectedValueGender!.value.isNotEmpty
                ? newController.selectedValueGender!.value
                : null,
            hint: Text(
              selectGender,
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 14),
            ),
            isExpanded: false,
          ),
        ));
  }

// Future<List<File>> pickMultipleImages() async {
//   List<XFile> xFiles = await ImagePicker().pickMultiImage(); // Use pickMultiImage() to select multiple images
//   List<File> images = [];
//   for (XFile file in xFiles) {
//     images.add(File(file.path));
//   }
//   return images;
// }

/*  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  Future<void> _getImages() async {
    List<XFile>? pickedFiles = await _picker.pickMultiImage(
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedFiles != null) {
      setState(() {
        _selectedImages.clear();
        for (var file in pickedFiles) {
          _selectedImages.add(File(file.path));
        }
      });
    }
  }

  Future<void> _uploadImages() async {
    Dio dio = Dio();

    FormData formData = FormData();

    for (var file in _selectedImages) {
      String fileName = file.path.split("/").last;
      formData.files.add(MapEntry(
        'upload_file[]',
        await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      ));
    }

    formData.fields.addAll({
      'name': 'ere',
      'email': 'a@a.com',
      'phone_no': '12121212121',
      'age': '12121212121',
      'gender': '12121212121',
      'address': '12121212121',
      'department': '12121212121',
      'doctor': '12121212121',
      'date': '12121212121',
      'time_shift': '12121212121',
      'total_amount': '12121212121',
      'hwid': '12121212121',
    });

    try {
      Response response = await dio.post(
        'https://saasmeditech.com/Appointment_bookapi/appointment_book',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'mrXSxT4n2Ff9Dr1a1mL5',
            'CF-Token': '123',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = response.data;
        if (responseData['status'] == '200') {
          print("2000000");
          return response.data.toString();
        } else {
          return response.data.toString();
        }
      } else {
        throw Exception('Failed to upload images');
      }
    } catch (e) {
      throw Exception('Failed to upload images: $e');
    }
  }*/
}
