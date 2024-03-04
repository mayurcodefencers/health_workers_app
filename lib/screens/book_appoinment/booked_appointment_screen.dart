import 'package:flutter/material.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:sizer/sizer.dart';

class BookedAppointmentScreen extends StatefulWidget {
  const BookedAppointmentScreen({super.key});

  @override
  State<BookedAppointmentScreen> createState() =>
      _BookedAppointmentScreenState();
}

class _BookedAppointmentScreenState extends State<BookedAppointmentScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int? isSelectedBooking = 0;
  List<String> bookingHistory = [
    "Upcoming",
    "Past",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColor.appBgColor,
      drawerEnableOpenDragGesture: false,
      body: Column(
        children: [
          CustomAppBarWidget(
            extraContainerHeight: 16.h,
            sizedBoxHeight: 17.h,
            showTextField: false,
            showDrawer: false,
            showAppBarText: true,
            appBarText: bookedAppointment,
            searchText: "",
            openDrawerTap: () {},
            paddingTop: 0.0,
            paddingBottom: 0.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    itemCount: bookingHistory.length,
                    itemBuilder: (ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelectedBooking = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: isSelectedBooking == index
                                  ? AppColor.titleAndButtonColor
                                  : AppColor.containerColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Center(
                            child: Text(
                              bookingHistory[index].toString(),
                              style: AppTextStyle.textSemiBold.copyWith(
                                color: isSelectedBooking == index
                                    ? AppColor.containerColor
                                    : AppColor.titleAndButtonColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 12 / 3,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 10,
                    ),
                  ),
                  ListView.builder(
                      physics: const ScrollPhysics(),
                      itemCount: 5,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(00),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 10),
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColor.containerColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      monthName,
                                      style: AppTextStyle.textNormal,
                                    ),
                                    Text(
                                      date,
                                      style: AppTextStyle.textNormal.copyWith(
                                          color: AppColor.titleAndButtonColor,
                                          fontSize: 63
                                      ),
                                    ),
                                    Text(
                                      day,
                                      style: AppTextStyle.textNormal,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  height: 18.h,
                                  child: const VerticalDivider(color: AppColor.textFieldBorderColor,),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.h, left: 2.w),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                timing,
                                                style: AppTextStyle.textNormal.copyWith(
                                                    color: AppColor.searchColor
                                                ),
                                              ),
                                              Text(
                                                bookedTime,
                                                style: AppTextStyle.textSemiBold.copyWith(
                                                    color: AppColor.textFieldBorderColor,
                                                    fontSize: 12
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                to,
                                                style: AppTextStyle.textNormal.copyWith(
                                                    color: AppColor.searchColor
                                                ),
                                              ),
                                              Text(
                                                doctorName,
                                                style: AppTextStyle.textSemiBold.copyWith(
                                                    color: AppColor.textFieldBorderColor,
                                                    fontSize: 12
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                      child: const Divider(
                                        color: AppColor.textFieldBorderColor,
                                      ),
                                    ),
                                    Text(
                                      appointmentMode,
                                      style: AppTextStyle.textNormal.copyWith(
                                          color: AppColor.searchColor
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      mode,
                                      style: AppTextStyle.textSemiBold.copyWith(
                                          color: AppColor.textFieldBorderColor,
                                          fontSize: 12
                                      ),
                                    ),
                                  ],
                                ),
                  
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
