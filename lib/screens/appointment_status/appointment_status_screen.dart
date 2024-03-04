import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/appointment_status/appointment_success_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:sizer/sizer.dart';

class AppointmentStatusScreen extends StatefulWidget {
  const AppointmentStatusScreen({super.key});

  @override
  State<AppointmentStatusScreen> createState() =>
      _AppointmentStatusScreenState();
}

class _AppointmentStatusScreenState extends State<AppointmentStatusScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.appBgColor,
      drawerEnableOpenDragGesture: false,
      body: Column(
        children: [
          CustomAppBarWidget(
            extraContainerHeight: 19.h,
            sizedBoxHeight: 16.h,
            showTextField: false,
            showDrawer: false,
            showAppBarText: true,
            appBarText: appointmentStatus,
            searchText: "",
            openDrawerTap: () {},
            paddingTop: 10.0,
            paddingBottom: 0.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  paymentStatus,
                  style: AppTextStyle.textSemiBold
                      .copyWith(color: AppColor.titleAndButtonColor),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  // height: 8.h,
                  // width: 90.w,
                  decoration: BoxDecoration(
                      color: AppColor.containerColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        receivedPayment,
                        style: AppTextStyle.textNormal,
                      ),
                      SvgPicture.asset(
                        AppAssets.success,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  appointmentStatus,
                  style: AppTextStyle.textSemiBold
                      .copyWith(color: AppColor.titleAndButtonColor),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  height: 34.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color: AppColor.containerColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointmentSuccess,
                          style: AppTextStyle.textNormal,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColor.searchColor,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              waitingDoctorApproval,
                              style: AppTextStyle.textNormal,
                            ),
                            SvgPicture.asset(
                              AppAssets.waiting,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Divider(
                          color: AppColor.searchColor,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ButtonWidget(
                          text: reschedule,
                          bColor: AppColor.titleAndButtonColor,
                          borderRadius: 8,
                          onTap: () {
                            Get.to(const AppointmentSuccessScreen());
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        ButtonWidget(
                          text: cancel,
                          bColor: AppColor.redColor,
                          borderRadius: 8,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
