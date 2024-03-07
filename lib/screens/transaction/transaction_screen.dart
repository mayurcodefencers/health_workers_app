import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          transaction,
          style: AppTextStyle.boldText
              .copyWith(color: AppColor.primaryColor, fontSize: 22),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColor.navyBlueColor,
          ),
        ),
      ),
      body: Column(
         children: [
           Expanded(
             child: ListView.builder(
                 physics: const BouncingScrollPhysics(),
                 itemCount: 5,
                 shrinkWrap: true,
                 padding: const EdgeInsets.all(00),
                 itemBuilder: (BuildContext context, int index) {
                   return transactionContainer();
                 }),
           ),
         ],
      ),
    );
  }
  Widget transactionContainer() {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.pureWhiteColor,
          borderRadius: BorderRadius.circular(8),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "50",
              style: AppTextStyle.mediumText.copyWith(
                  color: AppColor.navyBlueColor,
                  fontSize: 16
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transactionId,
                  style: AppTextStyle.mediumText.copyWith(
                      fontSize: 12,
                      color: AppColor.navyBlueColor
                  ),
                ),
                Text(
                  "CDE456FVTGH45678",
                  style: AppTextStyle.normalText.copyWith(
                      fontSize: 12,
                      color: AppColor.navyBlueColor
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: AppTextStyle.mediumText.copyWith(
                      fontSize: 12,
                      color: AppColor.navyBlueColor
                  ),
                ),
                Text(
                  "07-03-2024",
                  style: AppTextStyle.normalText.copyWith(
                      fontSize: 12,
                      color: AppColor.navyBlueColor
                  ),
                ),
              ],
            ),
            SvgPicture.asset(
                AppAssets.credit
            )
          ],
        )

    );
  }
}
