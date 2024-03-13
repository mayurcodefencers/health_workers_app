import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/home/home_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/add_patient/add_patient_screen.dart';
import 'package:health_workers/screens/consulting/consulting_screen.dart';
import 'package:health_workers/screens/notification/notification_screen.dart';
import 'package:health_workers/widgets/button_widget.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: Obx(()
    {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColor.primaryColor,
          ),
        );
      }
      // else if (controller.loginModel == null) {
      //   return const Center(child: Text('No data available'));
      // }
      else {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 5.w,
                  vertical: 5.h,
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      controller.userImage.toString() ??
                          "",
                      fit: BoxFit.fill,
                      width: 50,
                      height: 50,
                      // fit: BoxFit.cover
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        welComeBackHome,
                        style: AppTextStyle.mediumText
                            .copyWith(
                            color: AppColor.primaryColor, fontSize: 12),
                      ),
                      Text(
                        controller.userName
                            .toString() ?? "",
                        style: AppTextStyle.semiBoldText.copyWith(
                            color: AppColor.navyBlueColor, fontSize: 14),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const NotificationScreen());
                    },
                    child: SvgPicture.asset(
                      AppAssets.notification
                    )
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const ConsultingScreen());
                  },
                  child: Container(
                    height: 15.h,
                    width: 40.w,
                    // padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColor.pureWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19101828),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: -1,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          AppAssets.bookAppointmentHome,
                          // height: 10.h,
                          // width: 20.w,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          bookDoctor,
                          style: AppTextStyle.mediumText.copyWith(
                              color: AppColor.navyBlueColor,
                              fontSize: 14
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const PatientRegisterScreen());
                  },
                  child: Container(
                    height: 15.h,
                    width: 40.w,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColor.pureWhiteColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19101828),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: -1,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 1.h,
                        ),
                        Image.asset(
                          AppAssets.addMember,
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Text(
                          addMember,
                          style: AppTextStyle.mediumText.copyWith(
                              color: AppColor.navyBlueColor,
                              fontSize: 14
                          ),
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 15.h,
              width: 40.w,
              // padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColor.pureWhiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19101828),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    spreadRadius: -1,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.test,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      bookTest,
                      style: AppTextStyle.mediumText.copyWith(
                          color: AppColor.navyBlueColor,
                          fontSize: 14
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Text(
              currentToken,
              style: AppTextStyle.mediumText.copyWith(
                  fontSize: 20,
                  color: AppColor.navyBlueColor
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Container(
              height: 12.h,
              width: 30.w,
              // padding: const EdgeInsets.all(10),
              // margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColor.lightBlueColor,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Text(
                  "10",
                  style: AppTextStyle.semiBoldText
                      .copyWith(color: AppColor.primaryColor, fontSize: 60),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  upcomingBookings,
                  style: AppTextStyle.semiBoldText
                      .copyWith(color: AppColor.primaryColor, fontSize: 16),
                ),
                ButtonWidget(
                  text: viewAll,
                  width: 25.w,
                  height: 5.h,
                  textStyle: AppTextStyle.normalText.copyWith(
                    color: AppColor.pureWhiteColor,
                  ),
                  onTap: () {},
                  borderRadius: 10,
                )
              ],
            ),
            SizedBox(
              height: 1.h,
            ),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: 5,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(00),
                  itemBuilder: (BuildContext context, int index) {
                    return bookingListWidget();
                  }),
            ),
          ],
        );
      }
    }));

  }

  Widget bookingListWidget() {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.pureWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19101828),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: -1,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(AppAssets.profilePic),
          ),
          SizedBox(
            width: 6.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dr. Parthiv Joshi",
                style: AppTextStyle.semiBoldText
                    .copyWith(color: AppColor.navyBlueColor, fontSize: 16),
              ),
              Text(
                "Mr Mukesh Parmar",
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 14),
              ),
              Text(
                "+91 7990230441",
                style: AppTextStyle.mediumText
                    .copyWith(color: AppColor.greyColor, fontSize: 10),
              ),
              Row(
                children: [
                  Text(
                    "05-03-2024",
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.greyColor, fontSize: 10),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(
                    "12:00AM",
                    style: AppTextStyle.mediumText
                        .copyWith(color: AppColor.greyColor, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(18),
            // margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColor.lightBlueColor,
                borderRadius: BorderRadius.circular(4)),
            child: Text(
              "10",
              style: AppTextStyle.semiBoldText
                  .copyWith(color: AppColor.primaryColor, fontSize: 23),
            ),
          )
        ],
      ),
    );
  }
}
