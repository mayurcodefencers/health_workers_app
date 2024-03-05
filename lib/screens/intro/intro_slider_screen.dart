import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:sizer/sizer.dart';

import '../../core/strings.dart';

class IntroSliderScreen extends StatefulWidget {
  const IntroSliderScreen({super.key});

  @override
  State<IntroSliderScreen> createState() => _IntroSliderScreenState();
}

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      ContentConfig(
        widgetDescription: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              bookAppointment,
              style: AppTextStyle.mediumText
                  .copyWith(fontSize: 30, color: AppColor.navyBlueColor),
            ),
            // const SizedBox(
            //   height: 4,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                vertical: 2.h
              ),
              child: Text(
                bookAppointment1,
                style: AppTextStyle.normalText
                    .copyWith(fontSize: 16, color: AppColor.navyBlueColor),
              ),
            ),
          ],
        ),
        backgroundImage: "assets/svg/bg.png",
        backgroundFilterColor: AppColor.whiteColor,
        backgroundFilterOpacity: 1.0,
        pathImage: AppAssets.bookAppointment,
        backgroundColor: AppColor.whiteColor,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        widgetDescription: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              bookDiagnosis,
              style: AppTextStyle.mediumText
                  .copyWith(fontSize: 30, color: AppColor.navyBlueColor),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 2.h
              ),
              child: Text(
                bookDiagnosis1,
                style: AppTextStyle.normalText
                    .copyWith(fontSize: 16, color: AppColor.navyBlueColor),
              ),
            ),
          ],
        ),
        backgroundImage: "assets/svg/bg.png",
        backgroundFilterColor: AppColor.whiteColor,
        backgroundFilterOpacity: 1.0,
        pathImage: AppAssets.bookDiagnosis,
        backgroundColor: AppColor.whiteColor,
      ),
    );
    listContentConfig.add(
      ContentConfig(
        widgetDescription: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              emergencyService,
              style: AppTextStyle.mediumText
                  .copyWith(fontSize: 30, color: AppColor.navyBlueColor),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 2.h
              ),
              child: Text(
                emergencyService1,
                style: AppTextStyle.normalText
                    .copyWith(fontSize: 16, color: AppColor.navyBlueColor),
              ),
            ),
          ],
        ),
        backgroundImage: "assets/svg/bg.png",
        backgroundFilterColor: AppColor.whiteColor,
        backgroundFilterOpacity: 1.0,
        pathImage: AppAssets.emergencyService,
        backgroundColor: AppColor.whiteColor,
      ),
    );
  }

  void onDonePress() {
    print("End of slides");
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top]);
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      // appBar: AppBar(
      //   backgroundColor: AppColor.appBgColor,
      //   leading: const Icon(
      //     Icons.arrow_back,
      //     color: AppColor.arrowBackColor,
      //     size: 24.0,
      //   ),
      // ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: IntroSlider(
          key: UniqueKey(),
          listContentConfig: listContentConfig,
          indicatorConfig: const IndicatorConfig(
              colorActiveIndicator: AppColor.primaryColor,
              colorIndicator: AppColor.greyColor),
          renderDoneBtn: GestureDetector(
            onTap: () {
              // Get.to(const LoginWithMobileContainer());
            },
            child: Text(
              done.toUpperCase(),
              style: const TextStyle(color: AppColor.primaryColor),
            ),
          ),
          renderSkipBtn: GestureDetector(
            onTap: () {
              // Get.to(const LoginWithMobileContainer());;
            },
            child: Text(
              skip.toUpperCase(),
              style: const TextStyle(color: AppColor.primaryColor),
            ),
          ),
          renderNextBtn: const Icon(
            Icons.arrow_back,
            color: AppColor.primaryColor,
            textDirection: TextDirection.rtl,
            size: 24.0,
          ),
          backgroundColorAllTabs: AppColor.navyBlueColor,
          // navigationBarConfig: NavigationBarConfig(
          //   navPosition: NavPosition.bottom,
          //   padding: EdgeInsets.only(
          //     top: MediaQuery.of(context).viewPadding.top > 0 ? 20 : 10,
          //     bottom: MediaQuery.of(context).viewPadding.bottom > 0 ? 20 : 10,
          //   ),
          //   backgroundColor: AppColor.containerColor,
          // ),
        ),
      ),
    );
  }
}
