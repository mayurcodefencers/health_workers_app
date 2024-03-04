import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/book_appoinment/book_appoinment_screen.dart';
import 'package:health_workers/screens/general_physicians/general_physicians_screen.dart';
import 'package:health_workers/screens/pathology/pathology_list_screen.dart';
import 'package:health_workers/screens/profile/profile_screen.dart';
import 'package:health_workers/widgets/custom_appbar_widget.dart';
import 'package:health_workers/widgets/doctor_container.dart';
import 'package:health_workers/widgets/drawer_widget.dart';
import 'package:health_workers/widgets/grid_container.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  final CarouselController bannerSliderController = CarouselController();
  int bannerSlideIndex = 0;
  late TabController _tabController;
  int selectedIndex = 0;
  final List imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
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
              searchText: searchText,
              openDrawerTap: () {
                scaffoldKey.currentState?.openDrawer();
              },
              paddingTop: 0.0,
              paddingBottom: 0.0,
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          enlargeCenterPage: true,
                          enableInfiniteScroll: true,
                          aspectRatio: 3.0,
                          autoPlay: false,
                          viewportFraction: 0.85,
                          onPageChanged: (index, reason) {
                            setState(() {
                              bannerSlideIndex = index;
                            });
                          }),
                      items: imgList
                          .map(
                            (item) => ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(item,
                                  height: 80.h,
                                  width: 100.w,
                                  fit: BoxFit.cover),
                            ),
                          )
                          .toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              bannerSliderController.animateToPage(entry.key),
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: bannerSlideIndex == entry.key
                                    ? AppColor.titleAndButtonColor
                                    : Colors.white.withOpacity(
                                        bannerSlideIndex == entry.key
                                            ? 0.9
                                            : 0.4,
                                      )),
                          ),
                        );
                      }).toList(),
                    ),
                    GridView.count(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      crossAxisCount: 2,
                      children: List.generate(6, (index) {
                        return Center(
                            child: GridContainer(
                          choice: choices[index],
                        ));
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        ourDoctors,
                        style: AppTextStyle.textBold.copyWith(
                            fontSize: 16, color: AppColor.titleAndButtonColor),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: doctorList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: AppColor.containerBgColor,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              topOffersPathology,
                              style: AppTextStyle.textBold.copyWith(
                                  fontSize: 16,
                                  color: AppColor.titleAndButtonColor),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: offersOnPathologyTestList(),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        topOffersRadiology,
                        style: AppTextStyle.textBold.copyWith(
                            fontSize: 16, color: AppColor.titleAndButtonColor),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: offersOnRadiologyTestList(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget doctorList() {
    return SizedBox(
      height: 23.h,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return DoctorContainer(
            image:
                "https://thumbs.dreamstime.com/b/doctor-completing-medical-card-17760791.jpg?w=360",
            degree: degree,
            doctorName: doctorName,
            experience: experienceText,
            rating: ratingText,
            onTapBookNow: () {},
          );
        },
      ),
    );
  }

  Widget offersOnPathologyTestList() {
    return SizedBox(
      height: 23.h,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return DoctorContainer(
            image:
                "https://thumbs.dreamstime.com/b/doctor-completing-medical-card-17760791.jpg?w=360",
            degree: degree,
            doctorName: doctorName,
            experience: experienceText,
            rating: ratingText,
            showDiscountLabel: true,
            amount: "500",
            bookNow: bookNow,
            onTapBookNow: () {},
          );
        },
      ),
    );
  }

  Widget offersOnRadiologyTestList() {
    return SizedBox(
      height: 23.h,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return DoctorContainer(
            image:
                "https://thumbs.dreamstime.com/b/doctor-completing-medical-card-17760791.jpg?w=360",
            degree: degree,
            doctorName: doctorName,
            experience: experienceText,
            rating: ratingText,
            showDiscountLabel: true,
            amount: "700",
            bookNow: bookNow,
            onTapBookNow: () {},
          );
        },
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColor.appBgColor,
            title: Text(
              exitApp,
              style: AppTextStyle.textSemiBold.copyWith(
                color: AppColor.titleAndButtonColor
              ),
            ),
            content: Text(
              exitText,
              style: AppTextStyle.textSemiBold.copyWith(
                  color: AppColor.titleAndButtonColor
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text(
                  'No',
                  style: AppTextStyle.textBold.copyWith(
                      color: AppColor.titleAndButtonColor,
                      fontSize: 12
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: Text(
                  'Yes',
                  style: AppTextStyle.textBold.copyWith(
                      color: AppColor.titleAndButtonColor,
                    fontSize: 12
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}

class Choice {
  final String? title;
  final String? icon;
  final Function()? onTap;
  final BuildContext? context;

  const Choice({this.title, this.icon, this.onTap, this.context});
}

List<Choice> choices = <Choice>[
  Choice(
    title: myProfile,
    icon: AppAssets.myProfile,
    onTap: () {
      Get.to(const ProfileScreen());
    },
  ),
  Choice(
    title: bookAppointment,
    icon: AppAssets.gridBookAppointment,
    onTap: () {
      Get.to(const BookAppointmentScreen());
    },
  ),
  Choice(
    title: radiology,
    icon: AppAssets.radiology,
    onTap: () {
      Get.to(const GeneralPhysiciansScreen());
    },
  ),
  Choice(
    title: pathology,
    icon: AppAssets.pathology,
    onTap: () {
      Get.to(const PathologyListScreen());
    },
  ),
  Choice(
    title: history,
    icon: AppAssets.history,
    onTap: () {},
  ),
  Choice(
    title: emergency24,
    icon: AppAssets.gridEmergency,
    onTap: () {},
  ),
];
