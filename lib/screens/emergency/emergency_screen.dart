import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:health_workers/widgets/drawer_widget.dart';
import 'package:sizer/sizer.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.appBgColor,
      drawer: DrawerWidget(),
      drawerEnableOpenDragGesture: false,
      body: Column(
        children: [
          Stack(
            children: [
              CustomAppBarWidget(
                extraContainerHeight: 22.h,
                sizedBoxHeight: 21.h,
                showTextField: false,
                searchText: "",
                openDrawerTap: () {
                  scaffoldKey.currentState?.openDrawer();
                },
                paddingTop: 0.h,
                paddingBottom: 4.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(AppAssets.dummyDoctor),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dummyName,
                              style: AppTextStyle.textFieldLabelText.copyWith(
                                color: AppColor.containerColor,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              address,
                              style: AppTextStyle.textLight.copyWith(
                                  fontSize: 10, color: AppColor.containerColor),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          SvgPicture.asset(AppAssets.ambulance),
          Container(
            height: 30.h,
            width: 80.w,
            decoration: BoxDecoration(
              color: AppColor.containerColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 0.5.w,
                        width: 13.w,
                        color: AppColor.textFieldBorderColor,
                      ),
                      Center(
                        child: Text(
                          helpNeeded,
                          style: AppTextStyle.textBold.copyWith(
                              color: AppColor.textFieldBorderColor,
                              fontSize: 22),
                        ),
                      ),
                      Container(
                        height: 0.5.w,
                        width: 13.w,
                        color: AppColor.textFieldBorderColor,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    dummyNumberEmergency,
                    style: AppTextStyle.textBold
                        .copyWith(color: AppColor.redColor, fontSize: 34),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ButtonWidget(
                    text: callUs,
                    borderRadius: 10,
                    onTap : () {},
                  )
                ],
              ),
            ),
          )
        ],
      ),
      // bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
