import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/login_with_mobile.dart';
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
              style: AppTextStyle.textBold
                  .copyWith(fontSize: 24, color: AppColor.titleAndButtonColor),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              bookAppointment1,
              style: AppTextStyle.textNormal
                  .copyWith(fontSize: 14, color: AppColor.textFieldBorderColor),
            ),
          ],
        ),
        pathImage: AppAssets.bookAppointment,
        backgroundColor: AppColor.appBgColor,
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
              style: AppTextStyle.textBold
                  .copyWith(fontSize: 24, color: AppColor.titleAndButtonColor),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              bookDiagnosis1,
              style: AppTextStyle.textNormal
                  .copyWith(fontSize: 14, color: AppColor.textFieldBorderColor),
            ),
            Text(
              bookDiagnosis2,
              style: AppTextStyle.textNormal
                  .copyWith(fontSize: 14, color: AppColor.textFieldBorderColor),
            ),
          ],
        ),
        pathImage: AppAssets.bookDiagnosis,
        backgroundColor: AppColor.appBgColor,
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
              style: AppTextStyle.textBold
                  .copyWith(fontSize: 24, color: AppColor.titleAndButtonColor),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              emergencyService1,
              style: AppTextStyle.textNormal
                  .copyWith(fontSize: 14, color: AppColor.textFieldBorderColor),
            ),
            Text(
              emergencyService2,
              style: AppTextStyle.textNormal
                  .copyWith(fontSize: 14, color: AppColor.textFieldBorderColor),
            )
          ],
        ),
        pathImage: AppAssets.emergency,
        backgroundColor: AppColor.appBgColor,
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
      backgroundColor: AppColor.appBgColor,
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
            colorActiveIndicator: AppColor.titleAndButtonColor,
            colorIndicator: AppColor.arrowBackColor
          ),
          renderDoneBtn: GestureDetector(
            onTap: () {
              Get.to(const LoginWithMobileContainer());
            },
            child: Text(
              done.toUpperCase(),
              style: const TextStyle(
                  color: AppColor.titleAndButtonColor
              ),
            ),
          ),
          renderSkipBtn: GestureDetector(
            onTap: () {
              Get.to(const LoginWithMobileContainer());;
            },
            child: Text(
              skip.toUpperCase(),
              style: const TextStyle(
                color: AppColor.titleAndButtonColor
              ),
            ),
          ),
          renderNextBtn: const Icon(
            Icons.arrow_back,
            color: AppColor.titleAndButtonColor,
            textDirection: TextDirection.rtl,
            size: 24.0,
          ),
          backgroundColorAllTabs: AppColor.redColor,
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
