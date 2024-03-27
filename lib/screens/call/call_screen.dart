import 'package:flutter/material.dart';
import 'package:health_workers/core/strings.dart';
import 'package:health_workers/main.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallScreen extends StatefulWidget {
  final String callID;
  final String userId;
  final String userName;

  const CallScreen({
    Key? key,
    required this.callID,
    required this.userId,
    required this.userName,
  }) : super(key: key);


  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 2115087357,
      appSign: appSign,
      userID: widget.userId,
      userName: widget.userName,
      callID: widget.callID,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
    );
  }
}
