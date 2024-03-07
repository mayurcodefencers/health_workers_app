import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/booking/booking_screen.dart';
import 'package:health_workers/screens/home/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const BookingScreen(),
    const HomeScreen(),
    const BookingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(35), topLeft: Radius.circular(35)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: pageIndex,
            onTap: _onItemTapped,
            backgroundColor: AppColor.primaryColor,
            unselectedLabelStyle: AppTextStyle.normalText
                .copyWith(fontSize: 10, color: AppColor.greyColor),
            selectedLabelStyle: AppTextStyle.normalText
                .copyWith(fontSize: 10, color: AppColor.whiteColor),
            selectedItemColor: AppColor.whiteColor,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: pageIndex == 0
                    ? SvgPicture.asset(
                        AppAssets.home,
                        color: AppColor.whiteColor,
                      )
                    : SvgPicture.asset(
                        AppAssets.home,
                        color: AppColor.greyColor,
                      ),
                label: home,
              ),
              BottomNavigationBarItem(
                icon: pageIndex == 1
                    ? SvgPicture.asset(
                        AppAssets.booking,
                        color: AppColor.whiteColor,
                      )
                    : SvgPicture.asset(
                        AppAssets.booking,
                        color: AppColor.greyColor,
                      ),
                label: bookings,
              ),
              BottomNavigationBarItem(
                icon: pageIndex == 2
                    ? SvgPicture.asset(
                        AppAssets.camera,
                        color: AppColor.whiteColor,
                      )
                    : SvgPicture.asset(
                        AppAssets.camera,
                        color: AppColor.greyColor,
                      ),
                label: profile,
              ),
              BottomNavigationBarItem(
                icon: pageIndex == 3
                    ? SvgPicture.asset(
                        AppAssets.profile,
                        color: AppColor.whiteColor,
                      )
                    : SvgPicture.asset(
                        AppAssets.profile,
                        color: AppColor.greyColor,
                      ),
                label: profile,
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
