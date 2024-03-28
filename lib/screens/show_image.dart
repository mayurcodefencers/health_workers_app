import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import 'package:health_workers/controllers/booking/bookin_details_controller.dart';
import 'package:health_workers/controllers/meeting/meeting_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:printing/printing.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowImageScreen extends StatefulWidget {
  const ShowImageScreen({Key? key}) : super(key: key);

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  final BookingDetailsController controller = Get.put(BookingDetailsController());
  final MeetingController meetingController = Get.put(MeetingController());
  final GlobalKey webViewKey = GlobalKey();
  final GlobalKey repaintBoundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    print("Imageeeeeeeee");
    controller.bookingDetails(meetingController.storeAppointmentIdHistory!.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          imageDisplay,
          style: AppTextStyle.boldText.copyWith(color: AppColor.primaryColor, fontSize: 22),
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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.w),
            child: GestureDetector(
              onTap: () {
                printDoc();
              },
              child: const Icon(
                Icons.print,
                color: AppColor.primaryColor,
                size: 26,
              ),
            ),
          )
        ],
      ),
      body: RepaintBoundary(
        key: repaintBoundaryKey,
        child: WebView(
          key: webViewKey,
          initialUrl: controller.bookingDetailsModel?.doctorDoc?.first.file ?? "",
          javascriptMode: JavascriptMode.unrestricted,
          zoomEnabled: true,
          gestureNavigationEnabled: true,
        ),
      ),
    );
  }

  Future<void> printDoc() async {
    print("INSIDE FUNCTION");
    final doc = pw.Document();
    final boundary = repaintBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(
            pw.MemoryImage(pngBytes),
          ),
        );
      },
    ));

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
    print("DONE");
  }
}
