import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/book_appoinment/select_slot_screen.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:sizer/sizer.dart';

class GeneralPhysiciansScreen extends StatefulWidget {
  const GeneralPhysiciansScreen({super.key});

  @override
  State<GeneralPhysiciansScreen> createState() =>
      _GeneralPhysiciansScreenState();
}

class _GeneralPhysiciansScreenState extends State<GeneralPhysiciansScreen> {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          generalPhysicians,
                          style: AppTextStyle.textSemiBold
                              .copyWith(color: AppColor.titleAndButtonColor),
                        ),
                        GestureDetector(
                          onTap: () {
                            showBottomSheet();
                          },
                          child: const Icon(
                            Icons.filter_alt_outlined,
                            color: AppColor.titleAndButtonColor,
                            size: 32,
                          ),
                        )
                      ],
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
                                  Get.to(const SelectSlotScreen());
                                },
                                child: Container(
                                  // height: 8.h,
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                      color: AppColor.containerColor,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 14),
                                        child: CircleAvatar(
                                          radius: 21,
                                          backgroundColor:
                                              AppColor.titleAndButtonColor,
                                          child: CircleAvatar(
                                            radius: 19,
                                            backgroundImage: AssetImage(
                                                AppAssets.dummyDoctor),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            doctorName,
                                            style: AppTextStyle.textSemiBold
                                                .copyWith(
                                                    color: AppColor
                                                        .titleAndButtonColor,
                                                    fontSize: 12),
                                          ),
                                          const SizedBox(height: 2),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: AppColor.yellowColor,
                                                size: 16,
                                              ),
                                              Text(
                                                ratingText.toString(),
                                                style: AppTextStyle.textLight
                                                    .copyWith(fontSize: 10),
                                              ),
                                              Text(
                                                feedbackText,
                                                style: AppTextStyle.textLight
                                                    .copyWith(fontSize: 10),
                                              ),
                                            ],
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
                              const SizedBox(
                                height: 12,
                              ),
                            ],
                          );
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> showBottomSheet() async {
    return await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container();
      },
    );
  }
}
