import 'package:get/get.dart';
import 'package:health_workers/main.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = false.obs;
  Future<void> checkLoginStatus() async {
    print("LOGGEDIN VALUE: ${ isLoggedIn.value  }");

    isLoggedIn.value = pref?.getBool('isLoggedIn') ?? false;

  }

  void setLoggedIn(bool value) async {
    await pref?.setBool('isLoggedIn', value);
    isLoggedIn.value = value;
  }
}
