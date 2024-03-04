import 'package:flutter/material.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class DoctorContainer extends StatelessWidget {
  final String image;
  final String doctorName;
  final String degree;
  final double rating;
  final String experience;
  final String? amount;
  final String? bookNow;
  final Function() onTapBookNow;
  final bool showDiscountLabel;

  const DoctorContainer({
    Key? key,
    required this.image,
    required this.doctorName,
    required this.degree,
    required this.rating,
    required this.experience,
    this.amount,
    this.bookNow,
    required this.onTapBookNow,
    this.showDiscountLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          // height: 22.h,
          // padding: const EdgeInsets.all(24),
          width: 45.w,
          decoration: BoxDecoration(
              color: AppColor.containerColor,
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 2.w, top: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   showDiscountLabel == true ? Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: Container(
                        height: 1.8.h,
                        width: 12.w,
                        color: AppColor.redColor,
                        child: Center(
                          child: Text(
                            discountText,
                            style: AppTextStyle.textLight.copyWith(
                              fontSize: 9,color: AppColor.containerColor
                            ),
                          ),
                        ),
                      ),
                    ) : Container(),
                    const Icon(
                      Icons.favorite_border,
                      color: AppColor.redColor,
                      size: 18,
                    ),
                  ],
                ),
              ),
              Container(
                height: 7.h,
                // width: 20.w,
                decoration: BoxDecoration(
                    color: AppColor.containerColor,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColor.arrowBackColor,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 7.0,
                      ),
                    ],
                    image: DecorationImage(
                        image: NetworkImage(
                          image
                        ),
                        fit: BoxFit.contain)),
              ),
              const SizedBox(
                height: 6,
              ),
              Center(
                child: Text(
                  doctorName,
                  style: AppTextStyle.textBold.copyWith(
                      color: AppColor.titleAndButtonColor, fontSize: 12),
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Text(
                  degree,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.textLight.copyWith(fontSize: 10),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: showDiscountLabel ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      amount ?? "",
                      style: AppTextStyle.textLight.copyWith(fontSize: 10),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: onTapBookNow,
                      child: Text(
                        bookNow ?? "",
                        style: AppTextStyle.textBold.copyWith(fontSize: 10,color: AppColor.titleAndButtonColor),
                      ),
                    ),
                  ],
                )
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.star,
                      color: AppColor.yellowColor,
                      size: 16,
                    ),
                    Text(
                      rating.toString(),
                      style: AppTextStyle.textLight.copyWith(fontSize: 10),
                    ),
                    const Spacer(),
                    Text(
                      experience,
                      style: AppTextStyle.textLight.copyWith(fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
