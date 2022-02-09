import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secrekey/data/models/generated_key.dart';
import 'package:secrekey/data/secrekey_box.dart';
import 'package:secrekey/styles/colors.dart';

class ToolsController extends GetxController {
  late TextEditingController keyController;
  late Box<GeneratedKey> box;
  var isLoading = false.obs;
  var generatedKeyLength = 4.obs;
  var includeNum = false.obs;
  var includeSym = false.obs;

  @override
  void onInit() {
    keyController = TextEditingController();
    box = SecreKeyBox.getGeneratedKeys();
    super.onInit();
  }

  @override
  void onClose() {
    keyController.dispose();
    super.onClose();
  }

  Future<void> generateNewKey() async {
    isLoading(true);
    try {
      final generatedKey = await fetchNewKey();
      keyController.text = generatedKey;
      isLoading(false);
    } catch (error) {
      isLoading(false);
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 2),
          message: error.toString(),
          backgroundColor: cLightMilkyPink,
        ),
      );
    }
  }

  Future<String> fetchNewKey() async {
    const String lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String numbers = '0123456789';
    const String symbols = '@#\$%!=+&?(){}';

    String chars = '';
    String generatedKey = 'key';
    chars += "$lowercaseLetters$uppercaseLetters";
    if (includeNum.value) chars += numbers;
    if (includeSym.value) chars += symbols;
    do {
      generatedKey = List.generate(generatedKeyLength.value, (index) {
        final randomIndex = Random.secure().nextInt(chars.length);
        return chars[randomIndex];
      }).join('');
    } while (await isKeyAlreadySaved(generatedKey));

    return generatedKey;
  }

  void saveNewKey(String newKey, String label) async {
    try {
      final generatedKey = GeneratedKey()
        ..savedKey = newKey
        ..label = label;

      box.add(generatedKey);

      Get.back();

      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Key Successfully Saved',
          backgroundColor: cTealGreen,
        ),
      );
    } catch (error) {
      Get.showSnackbar(
        const GetSnackBar(
          duration: Duration(seconds: 2),
          message: 'Key Save Failed',
          backgroundColor: cLightMilkyPink,
        ),
      );
    }
  }

  Future<bool> isKeyAlreadySaved(String generatedKey) async {
    for (var value in box.values.toList()) {
      if (value.savedKey == generatedKey) {
        return true;
      }
    }
    return false;
  }
}
