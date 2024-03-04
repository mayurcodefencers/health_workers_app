import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:health_workers/constants/app_const_assets.dart';
import 'package:health_workers/core/theme/app_color.dart';
import 'package:health_workers/core/theme/app_text_style.dart';
import 'package:sizer/sizer.dart';

class CustomAppBarWidget extends StatefulWidget {
  final double? heightC;
  final double? extraContainerHeight;
  final double? sizedBoxHeight;
  final bool? showTextField;
  final bool? showAppBarText;
  final bool? showDrawer;
  final double paddingTop;
  final double paddingBottom;
  final Function() openDrawerTap;
  final double? width;
  final Widget? child;
  final String? appBarText;
  final String searchText;

  const CustomAppBarWidget({
    Key? key,
    this.heightC,
    this.extraContainerHeight,
    this.sizedBoxHeight,
    this.showTextField = false,
    this.showAppBarText = false,
    this.showDrawer = true,
    required this.paddingTop,
    required this.paddingBottom,
    required this.openDrawerTap,
    this.width,
    this.child,
    this.appBarText,
    required this.searchText,
  }) : super(key: key);

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.appBgColor,
      height: widget.extraContainerHeight,
      // height: 19.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: widget.sizedBoxHeight,
            // height: 16.h,
            child: Container(
              height: widget.heightC,
              width: widget.width,
              decoration: const BoxDecoration(
                color: AppColor.titleAndButtonColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: widget.paddingTop, bottom: widget.paddingBottom),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.showDrawer == true
                        ? GestureDetector(
                            onTap: widget.openDrawerTap,
                            child: SvgPicture.asset(AppAssets.drawerIcon,
                                height: 10.h,
                                width: 10.w,
                                fit: BoxFit.scaleDown),
                          )
                        : GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 4.w),
                              child: const Icon(
                                Icons.arrow_back,
                                color: AppColor.containerColor,
                                size: 24.0,
                              ),
                            ),
                          ),
                    widget.showAppBarText == true
                        ? Center(
                          child: Text(
                              widget.appBarText ?? "",
                              style: AppTextStyle.textSemiBold
                                  .copyWith(fontSize: 20),
                            ),
                        )
                        : Container(),
                    SvgPicture.asset(AppAssets.cart,
                        height: 10.h, width: 10.w, fit: BoxFit.scaleDown),
                  ],
                ),
              ),
            ),
          ),
          widget.showTextField == true
              ? Positioned(
                  top: 12.h,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    height: 6.5.h,
                    width: 100.w,
                    child: TextFormField(
                      style: AppTextStyle.textFieldUserText,
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: widget.searchText,
                          hintStyle: AppTextStyle.textLight
                              .copyWith(color: AppColor.searchColor),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 30,
                              color: AppColor.searchColor,
                            ),
                            onPressed: () => searchController.clear(),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide.none),
                          filled: true,
                          fillColor: AppColor.containerColor),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
