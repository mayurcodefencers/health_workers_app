import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:health_workers/screens/home/home_screen.dart';
import 'package:sizer/sizer.dart';

class GridContainer extends StatelessWidget {
  final Choice choice;

  const GridContainer({
    Key? key,
    required this.choice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: choice.onTap,
      child: Stack(
        children: [
          SizedBox(
            height: 25.h,
            width: 55.w,
            child: Center(
              child: SvgPicture.asset(
                AppAssets.gridBg,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset(choice.icon.toString())),
              const SizedBox(
                height: 10,
              ),
              Text(
                choice.title.toString(),
                style: AppTextStyle.textSemiBold.copyWith(fontSize: 12),
              )
            ],
          ),
        ],
      ),
    );
  }
}
