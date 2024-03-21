import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/controllers/profile/profile_controller.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    transactionDetails();
    super.initState();
  }

  Future<void> transactionDetails() async {
    await controller.getTransactionList();
  }

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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        } else if (controller.transactionModel == null) {
          return const Center(child: Text('No data available'));
        } else {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: controller
                            .transactionModel?.upcomingMeetinglist?.length ??
                        0,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(00),
                    itemBuilder: (BuildContext context, int index) {
                      return transactionContainer(index);
                    }),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget transactionContainer(int index) {
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
              controller.transactionModel?.upcomingMeetinglist?[index].amount ??
                  "",
              style: AppTextStyle.mediumText
                  .copyWith(color: AppColor.navyBlueColor, fontSize: 16),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: AppTextStyle.mediumText
                      .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
                ),
                Text(
                  controller.transactionModel?.upcomingMeetinglist?[index]
                          .doctorname ??
                      "",
                  style: AppTextStyle.normalText
                      .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: AppTextStyle.mediumText
                      .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
                ),
                Text(
                  controller.transactionModel?.upcomingMeetinglist?[index]
                          .createdDate ??
                      "",
                  style: AppTextStyle.normalText
                      .copyWith(fontSize: 12, color: AppColor.navyBlueColor),
                ),
              ],
            ),
            controller.transactionModel?.upcomingMeetinglist?[index]
                        .paymentType ==
                    "1"
                ? SvgPicture.asset(AppAssets.credit)
                : SvgPicture.asset(AppAssets.debit)
          ],
        ));
  }
}
