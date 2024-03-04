import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/appointment_status/appointment_status_screen.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:sizer/sizer.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key});

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
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
            showTextField: true,
            showDrawer: false,
            showAppBarText: true,
            appBarText: bookAppointment,
            searchText: searchText,
            openDrawerTap: () {},
            paddingTop: 0.0,
            paddingBottom: 0.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      appointmentType,
                      style: AppTextStyle.textSemiBold.copyWith(color: AppColor.titleAndButtonColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ListView.builder(
                        physics: const ScrollPhysics(),
                        itemCount: 5,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(00),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(const AppointmentStatusScreen());
                                },
                                child: Container(
                                  // height: 8.h,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                      color: AppColor.containerColor,
                                      borderRadius: BorderRadius.circular(18)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SvgPicture.asset(
                                          AppAssets.video,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              appointmentOnline,
                                              style: AppTextStyle.textSemiBold.copyWith(
                                                  color: AppColor.titleAndButtonColor,
                                                  fontSize: 12
                                              ),
                                            ),
                                            Text(
                                              onlineConsult,
                                              style: AppTextStyle.textLight.copyWith(
                                                  fontSize: 10
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.arrow_back_ios,
                                          textDirection: TextDirection.rtl,
                                          color: AppColor.titleAndButtonColor,
                                          size: 12.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          );
                        }
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
