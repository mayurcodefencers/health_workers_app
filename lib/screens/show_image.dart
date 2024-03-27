import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/controllers/booking/bookin_details_controller.dart';
import 'package:health_workers/controllers/meeting/meeting_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowImageScreen extends StatefulWidget {
  const ShowImageScreen({super.key});

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  final BookingDetailsController controller =
  Get.put(BookingDetailsController());
  final MeetingController meetingController = Get.put(MeetingController());

  @override
  void initState() {
    super.initState();
    print("Imageeeeeeeee");
    controller
        .bookingDetails(meetingController.storeAppointmentIdHistory!.value);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          imageDisplay,
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
      body: WebView(
        initialUrl: controller.bookingDetailsModel?.doctorDoc?.first.file ?? "",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
