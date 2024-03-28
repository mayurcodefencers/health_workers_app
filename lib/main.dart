import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:health_workers/controllers/auth_controller.dart';
import 'package:health_workers/screens/home/home_screen.dart';
import 'package:health_workers/screens/intro/intro_slider_screen.dart';
import 'package:health_workers/screens/login/login_screen.dart';
import 'package:health_workers/widgets/bottom_nav_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

SharedPreferences? pref;
final formKey = GlobalKey<FormState>();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return FutureBuilder(
          future: _authController.checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                home: _authController.isLoggedIn.value ? const HomePage() : const IntroSliderScreen(),
              );
            } else {
              return const CircularProgressIndicator();
            }
          });
    });
  }
}
