import 'package:get/get.dart';
import 'package:secrekey/presentation/bindings/home_binding.dart';
import 'package:secrekey/presentation/bindings/settings_binding.dart';
import 'package:secrekey/presentation/bindings/tools_binding.dart';
import 'package:secrekey/presentation/bindings/vault_binding.dart';
import 'package:secrekey/presentation/ui/home.dart';
import 'package:secrekey/presentation/ui/secrekey_settings_page.dart';
import 'package:secrekey/presentation/ui/secrekey_tools_page.dart';
import 'package:secrekey/presentation/ui/secrekey_vault_page.dart';
import 'package:secrekey/util/route_name.dart';

class AppRoute {
  AppRoute._();

  static final routes = [
    GetPage(
      name: RouteName.home,
      page: () => const Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.tools,
      page: () => const SecreKeyToolsPage(),
      binding: ToolsBinding(),
    ),
    GetPage(
      name: RouteName.vault,
      page: () => const SecreKeyVaultPage(),
      binding: VaultBinding(),
    ),
    GetPage(
      name: RouteName.settings,
      page: () => const SecreKeySettingsPage(),
      binding: SettingsBinding(),
    ),
  ];
}
