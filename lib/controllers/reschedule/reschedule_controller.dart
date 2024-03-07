import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/core/strings.dart';

class RescheduleController extends GetxController {
  RxInt? isSelectedMorning = 0.obs;
  RxInt? isSelectedEvening = 0.obs;

  RxString? timeListMorning = "09:00 to 12:00".obs;
  RxString? timeListEvening = "04:00 to 07:00".obs;
}