import 'dart:convert';
import 'dart:developer';

import 'package:get/instance_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Init {
  initialize() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    Get.lazyPut<SharedPreferences>(() => sharedPreferences);

    try {
      // Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));
      // Get.lazyPut(() => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
      // Get.lazyPut(() => FirebaseRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
      // Get.lazyPut(() => LeadsRepo(apiClient: Get.find()));
      // Get.lazyPut(() => AdminRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
      // Get.lazyPut(() => CartRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
      // Get.lazyPut(() => SplashRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

      // Get.lazyPut(() => PermissionController());
      // Get.lazyPut(() => AuthController(authRepo: Get.find()));
      // Get.lazyPut(() => FirebaseController(firebaseRepo: Get.find()));
      // Get.lazyPut(() => LeadsController(leadsRepo: Get.find()));
      // Get.lazyPut(() => AdminController(adminRepo: Get.find()));
      // Get.lazyPut(() => ChatAgoraController(agoraChatRepo: Get.find()));
      // Get.lazyPut(() => AgoraChatRepo(apiClient: Get.find()));
      // Get.lazyPut(() => CartController(cartRepo: Get.find()));
      // Get.lazyPut(() => SplashController(splashRepo: Get.find()));
    } catch (e) {
      log('---- ${e.toString()} ----', name: "ERROR AT initialize()");
    }
  }
}
