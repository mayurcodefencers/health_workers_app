import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/pathology/pathology_test_total_amount_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:sizer/sizer.dart';

class PathologyListScreen extends StatefulWidget {
  const PathologyListScreen({super.key});

  @override
  State<PathologyListScreen> createState() => _PathologyListScreenState();
}

class _PathologyListScreenState extends State<PathologyListScreen> {
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
            appBarText: pathology,
            searchText: searchText,
            openDrawerTap: () {},
            paddingTop: 10.0,
            paddingBottom: 0.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(00),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                      child: Container(
                        // height: 20.h,
                        padding: const EdgeInsets.all(12),
                        // margin: const EdgeInsets.all(14),
                        // width: 90.w,
                        decoration: BoxDecoration(
                            color: AppColor.containerColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.favorite_border,
                                color: AppColor.redColor,
                                size: 18,
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  // height: 5.h,
                                  // width: 15.h,
                                  decoration: const BoxDecoration(
                                    color: AppColor.containerColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0.0, 1.0), //(x,y)
                                        blurRadius: 8.0,
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                    AppAssets.bloodAnalysis,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bloodAnalysis,
                                      style: AppTextStyle.textSemiBold.copyWith(
                                          fontSize: 12,
                                          color: AppColor.titleAndButtonColor),
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: AppColor.yellowColor,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          ratingText.toString(),
                                          style: AppTextStyle.textLight
                                              .copyWith(fontSize: 10),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          testCenterName,
                                          style: AppTextStyle.textLight
                                              .copyWith(fontSize: 10),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              color: AppColor.searchColor,
                            ),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          mrp,
                                          style: AppTextStyle.textLight
                                              .copyWith(fontSize: 10),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 2.w),
                                          child: Container(
                                            height: 1.8.h,
                                            width: 12.w,
                                            color: AppColor.redColor,
                                            child: Center(
                                              child: Text(
                                                discountText,
                                                style: AppTextStyle.textLight
                                                    .copyWith(
                                                        fontSize: 9,
                                                        color:
                                                            AppColor.containerColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      amountText,
                                      style: AppTextStyle.textSemiBold.copyWith(
                                        fontSize: 16,
                                        color: AppColor.titleAndButtonColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25.w),
                                  child: ButtonWidget(
                                    text: bookNow,
                                    height: 4.h,
                                    width: 20.w,
                                    borderRadius: 8,
                                    textStyle: AppTextStyle.textBold.copyWith(
                                      fontSize: 10,
                                    ),
                                    onTap: () {
                                      Get.to(const TestAmountScreen());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
