import 'package:flutter/material.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:health_workers/widgets/drawer_widget.dart';
import 'package:sizer/sizer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
          CustomAppBarWidget(
            extraContainerHeight: 19.h,
            sizedBoxHeight: 16.h,
            showTextField: true,
            searchText: searchTextOnly,
            openDrawerTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            paddingTop: 0.0,
            paddingBottom: 0.0,
          ),
          Expanded(
            child: ListView.builder(
                physics: const ScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.containerColor,
                              borderRadius: BorderRadius.circular(18)
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      notificationText,
                                      style: AppTextStyle.textSemiBold.copyWith(
                                          color: AppColor.titleAndButtonColor,
                                          fontSize: 12
                                      ),
                                    ),
                                    Text(
                                      time,
                                      style: AppTextStyle.textLight.copyWith(
                                          fontSize: 8
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  notificationContent,
                                  maxLines: 4,
                                  style: AppTextStyle.textLight.copyWith(
                                      fontSize: 8
                                  ),
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
          ),
        ],
      ),
    );
  }
}
