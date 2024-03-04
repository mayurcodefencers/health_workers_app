import 'package:flutter/material.dart';
import 'package:health_workers/core/theme/app_color.dart';

class ContainerWidget extends StatelessWidget {
  final double heightC;
  final double? width;
  final Widget? child;
  final Color? color;

  const ContainerWidget({Key? key, required this.heightC,this.width, this.color, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Container(
          height: heightC,
          width: width,
          decoration: BoxDecoration(
            color: color ?? AppColor.containerColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(30),
              bottom: Radius.circular(40),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
