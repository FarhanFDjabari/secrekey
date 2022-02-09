import 'package:get/get.dart';
import 'package:secrekey/presentation/controllers/home_controller.dart';
import 'package:secrekey/presentation/controllers/settings_controller.dart';
import 'package:secrekey/presentation/controllers/tools_controller.dart';
import 'package:secrekey/presentation/controllers/vault_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<ToolsController>(() => ToolsController());
    Get.lazyPut<VaultController>(() => VaultController());
  }
}
