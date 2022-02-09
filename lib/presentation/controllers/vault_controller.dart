import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secrekey/data/models/generated_key.dart';
import 'package:secrekey/data/secrekey_box.dart';
import 'package:secrekey/styles/colors.dart';

class VaultController extends GetxController {
  late Box<GeneratedKey> box;

  @override
  void onInit() {
    box = SecreKeyBox.getGeneratedKeys();
    super.onInit();
  }

  void removeKey(GeneratedKey generatedKey) async {
    try {
      for (var item in box.values.toList()) {
        if (item.savedKey == generatedKey.savedKey) {
          box.delete(item.key);
        }
      }
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
