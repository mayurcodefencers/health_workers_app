// import 'package:demo_app/constants/app_const_assets.dart';
// import 'package:demo_app/core/strings.dart';
// import 'package:demo_app/core/theme/app_color.dart';
// import 'package:demo_app/core/theme/app_text_style.dart';
// import 'package:demo_app/screens/emergency/emergency_screen.dart';
// import 'package:demo_app/screens/home/home_screen.dart';
// import 'package:demo_app/screens/notification/notification_screen.dart';
// import 'package:demo_app/screens/profile/profile_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:sizer/sizer.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int pageIndex = 0;
//
//   final pages = [
//     const HomeScreen(),
//     const EmergencyScreen(),
//     const ProfileScreen(),
//     const NotificationScreen(),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       pageIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.appBgColor,
//       body: pages[pageIndex],
//       bottomNavigationBar: Container(
//         decoration: const BoxDecoration(
//           borderRadius: BorderRadius.only(
//               topRight: Radius.circular(35), topLeft: Radius.circular(35)),
//         ),
//         child: ClipRRect(
//           borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(35),
//             topRight: Radius.circular(35),
//           ),
//           child: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             currentIndex: pageIndex,
//             onTap: _onItemTapped,
//             backgroundColor: AppColor.containerColor,
//             unselectedLabelStyle: AppTextStyle.textNormal.copyWith(fontSize: 10),
//             selectedLabelStyle: AppTextStyle.textNormal.copyWith(fontSize: 10),
//             selectedItemColor: AppColor.titleAndButtonColor,
//             items: <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: pageIndex == 0
//                     ? SvgPicture.asset(
//                         AppAssets.home,
//                       )
//                     : SvgPicture.asset(
//                         AppAssets.home,
//                         color: AppColor.textFieldBorderColor,
//                       ),
//                 label: home,
//               ),
//               BottomNavigationBarItem(
//                 icon: pageIndex == 1
//                     ? SvgPicture.asset(
//                         AppAssets.support,
//                         color: AppColor.titleAndButtonColor,
//                       )
//                     : SvgPicture.asset(
//                         AppAssets.support,
//                       ),
//                 label: supportTeam,
//               ),
//               BottomNavigationBarItem(
//                 icon: pageIndex == 2
//                     ? SvgPicture.asset(
//                         AppAssets.profile,
//                         color: AppColor.titleAndButtonColor,
//                       )
//                     : SvgPicture.asset(
//                         AppAssets.profile,
//                       ),
//                 label: profile,
//               ),
//               BottomNavigationBarItem(
//                 icon: pageIndex == 3
//                     ? SvgPicture.asset(
//                         AppAssets.notification,
//                         color: AppColor.titleAndButtonColor,
//                       )
//                     : SvgPicture.asset(
//                         AppAssets.notification,
//                       ),
//                 label: notification,
//               ),
//             ],
//           ),
//         ),
//       ),
//       resizeToAvoidBottomInset: false,
//     );
//   }
//
//   Widget dotContainer(Color? color) {
//     return Container(
//       height: 1.h,
//       width: 10.w,
//       decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//     );
//   }
// }
