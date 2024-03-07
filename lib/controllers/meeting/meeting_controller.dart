import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/strings.dart';

class MeetingController extends GetxController {
  RxInt isType = 0.obs;
  List<String> type = [
    upcoming,
    missedAppointment,
    history
  ].obs;
}