import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:health_workers/widgets/drawer_widget.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.appBgColor,
      drawer: DrawerWidget(),
      drawerEnableOpenDragGesture: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBarWidget(
              extraContainerHeight: 18.h,
              sizedBoxHeight: 15.h,
              showTextField: false,
              searchText: "",
              openDrawerTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              showAppBarText: true,
              appBarText: profile,
              paddingTop: 0.h,
              paddingBottom: 0.h,
            ),
            Container(
              height: 28.h,
              width: 90.w,
              decoration: BoxDecoration(
                  color: AppColor.containerColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 3.h, left: 2.w),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 14),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColor.titleAndButtonColor,
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundImage:
                                      AssetImage(AppAssets.dummyDoctor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              dummyName,
                              style: AppTextStyle.textFieldLabelText.copyWith(
                                color: AppColor.titleAndButtonColor,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: EdgeInsets.only(right: 5.w, top: 1.5.h),
                        child: SvgPicture.asset(
                          AppAssets.edit,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 1.5.h),
                    child: Row(
                      children: [
                        Text(
                          "$phone ",
                          style: AppTextStyle.textNormal,
                        ),
                        Text(
                          "  :  $dummyNumber ",
                          style: AppTextStyle.textNormal,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 0.3.h),
                    child: Row(
                      children: [
                        Text(
                          "$emailOnly ",
                          style: AppTextStyle.textNormal,
                        ),
                        Text(
                          "  :  $dummyEmail ",
                          style: AppTextStyle.textNormal,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 0.3.h),
                    child: Row(
                      children: [
                        Text(
                          "$addressOnly ",
                          style: AppTextStyle.textNormal,
                        ),
                        Text(
                          "  :  $address ",
                          style: AppTextStyle.textNormal,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 0.3.h),
                    child: Row(
                      children: [
                        Text(
                          "$ageText ",
                          style: AppTextStyle.textNormal,
                        ),
                        Text(
                          "  :  $age ",
                          style: AppTextStyle.textNormal,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, top: 0.3.h),
                    child: Row(
                      children: [
                        Text(
                          "$gender ",
                          style: AppTextStyle.textNormal,
                        ),
                        Text(
                          "  :  $maleText ",
                          style: AppTextStyle.textNormal,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: Text(
                    familyMembers,
                    style: AppTextStyle.textSemiBold
                        .copyWith(color: AppColor.titleAndButtonColor),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Container(
                  // height: 28.h,
                  width: 90.w,
                  decoration: BoxDecoration(
                      color: AppColor.containerColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: 5,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 14),
                                    child: CircleAvatar(
                                      radius: 23,
                                      backgroundColor: AppColor.titleAndButtonColor,
                                      child: CircleAvatar(
                                        radius: 21,
                                        backgroundImage: AssetImage(AppAssets.dummyDoctor),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    dummyName,
                                    style: AppTextStyle.textSemiBold.copyWith(
                                      color: AppColor.titleAndButtonColor,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_back_ios_new,
                                    textDirection: TextDirection.rtl,
                                    color: AppColor.titleAndButtonColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                      },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
