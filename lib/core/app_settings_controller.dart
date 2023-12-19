import 'dart:developer';

import 'package:get/get.dart';

import '../export.dart';

// Control global app settings language & darkmode
class AppSettingsController extends GetxController {
  final darkMode = false.obs;
  final lang = true.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // change theme from dark mode default value app setting controller
    darkMode(box.read('dark') ?? false);
    lang(box.read('language') ?? true);
    log('${lang(box.read('language') ?? true)}');
    Get.changeTheme(darkMode.value ? darkTheme : lightTheme);
    addLanguageListener();
    addThemeListener();
  }

  void addThemeListener() {
    box.listenKey('dark', (value) {
      Get.changeTheme(value ? darkTheme : lightTheme);
    });
  }

  void addLanguageListener() {
    box.listenKey('language', (value) {
      Get.updateLocale(
          value ? const Locale('en', 'US') : const Locale('ar', 'EG'));
    });
  }
}
