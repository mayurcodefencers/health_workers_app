import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:sizer/sizer.dart';

class TestAmountScreen extends StatefulWidget {
  const TestAmountScreen({super.key});

  @override
  State<TestAmountScreen> createState() => _TestAmountScreenState();
}

class _TestAmountScreenState extends State<TestAmountScreen> {
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
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              // height: 20.h,
              padding: const EdgeInsets.all(16),
              // margin: const EdgeInsets.all(14),
              // width: 90.w,
              decoration: BoxDecoration(
                  color: AppColor.containerColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(
                    color: AppColor.searchColor,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        addMore,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 10,
                            color: AppColor.titleAndButtonColor
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          AppAssets.addMore,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              padding: const EdgeInsets.all(16),
              // margin: const EdgeInsets.all(14),
              // width: 90.w,
              decoration: BoxDecoration(
                  color: AppColor.containerColor,
                  borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mrpText,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 10,
                            color: AppColor.titleAndButtonColor
                        ),
                      ),
                      Text(
                        mrpAmount,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 16,
                            color: AppColor.titleAndButtonColor
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        discount,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 10,
                            color: AppColor.titleAndButtonColor
                        ),
                      ),
                      Text(
                        mrpAmount,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 16,
                            color: AppColor.titleAndButtonColor
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: AppColor.searchColor,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        total,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 10,
                            color: AppColor.titleAndButtonColor
                        ),
                      ),
                      Text(
                        mrpAmount,
                        style: AppTextStyle.textSemiBold.copyWith(
                            fontSize: 16,
                            color: AppColor.titleAndButtonColor
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 26,
          ),
          const ButtonWidget(
              text: next,
              borderRadius: 8,
          )
        ],
      ),
    );
  }
}
