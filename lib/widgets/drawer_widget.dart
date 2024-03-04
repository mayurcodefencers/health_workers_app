import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:sizer/sizer.dart';

import '../core/theme/app_text_style.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.titleAndButtonColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
        child: Column(
          children: [
            Container(
                height: 15.h,
                width: 75.w,
                decoration: BoxDecoration(
                  color: AppColor.appBgColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 14),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColor.titleAndButtonColor,
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: AssetImage(AppAssets.dummyDoctor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dummyName,
                            style: AppTextStyle.textFieldLabelText.copyWith(
                              color: AppColor.titleAndButtonColor,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            dummyNumber,
                            style: AppTextStyle.textLight.copyWith(
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            dummyEmail,
                            style: AppTextStyle.textLight.copyWith(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppAssets.help,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      help,
                      style: AppTextStyle.textNormal
                          .copyWith(color: AppColor.containerColor),
                    ),
                    Text(
                      contactUs,
                      style: AppTextStyle.textLight.copyWith(
                        color: AppColor.containerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.containerColor,
                  textDirection: TextDirection.rtl,
                  size: 14,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  AppAssets.invite,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      inviteFrd,
                      style: AppTextStyle.textNormal
                          .copyWith(color: AppColor.containerColor),
                    ),
                    Text(
                      shareApp,
                      style: AppTextStyle.textLight.copyWith(
                        color: AppColor.containerColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.containerColor,
                  textDirection: TextDirection.rtl,
                  size: 14,
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                 const Icon(
                   Icons.logout_sharp,
                   color: AppColor.containerColor,
                   size: 24,
                 ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    logOut,
                    style: AppTextStyle.textSemiBold
                        .copyWith(color: AppColor.containerColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
