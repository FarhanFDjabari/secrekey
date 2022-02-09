import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:secrekey/styles/colors.dart';

class SettingsController extends GetxController {
  late Box box;
  var isDark = Get.isDarkMode.obs;

  @override
  void onInit() {
    box = Hive.box('secreKeySettings');
    box.put('isDark', isDark);
    super.onInit();
  }

  void changeTheme(bool value) {
    isDark(value);
    Get.changeTheme(isDark.value ? kThemeDark : kThemeLight);
  }

  void saveSettings() {
    try {
      box.put('isDark', isDark.value);
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Settings saved',
          backgroundColor: cTealGreen,
        ),
      );
    } catch (error) {
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 2),
          message: '$error',
          backgroundColor: cLightMilkyPink,
        ),
      );
    }
  }
}
