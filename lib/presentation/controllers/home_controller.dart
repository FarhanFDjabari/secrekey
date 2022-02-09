import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secrekey/presentation/ui/secrekey_settings_page.dart';
import 'package:secrekey/presentation/ui/secrekey_tools_page.dart';
import 'package:secrekey/presentation/ui/secrekey_vault_page.dart';

class HomeController extends GetxController {
  var currentPage = 0.obs;

  final List<Widget> _screens = const [
    SecreKeyToolsPage(),
    SecreKeyVaultPage(),
    SecreKeySettingsPage(),
  ];

  set changePage(int page) => currentPage.value = page;

  Widget get screen => _screens[currentPage.value];

  @override
  void onClose() async {
    await Hive.close();
    super.onClose();
  }
}
