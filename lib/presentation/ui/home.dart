import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secrekey/presentation/controllers/home_controller.dart';
import 'package:secrekey/styles/colors.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.screen),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: cMilkyGreyBlue,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, color: cBaseBlack),
          ),
        ),
        child: GetX<HomeController>(
          init: HomeController(),
          initState: (_) {},
          builder: (_) {
            return NavigationBar(
              onDestinationSelected: (index) => controller.changePage = index,
              selectedIndex: controller.currentPage.value,
              destinations: const [
                NavigationDestination(
                  icon: Icon(
                    Icons.tune_rounded,
                    color: cLightGreyBlue,
                  ),
                  selectedIcon: Icon(
                    Icons.tune_rounded,
                    color: cMistyWhite,
                  ),
                  label: 'Tools',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.pin_outlined,
                    color: cMilkyGreyBlue,
                  ),
                  selectedIcon: Icon(
                    Icons.pin_outlined,
                    color: cMistyWhite,
                  ),
                  label: 'Vault',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.settings_outlined,
                    color: cMilkyGreyBlue,
                  ),
                  selectedIcon: Icon(
                    Icons.settings_outlined,
                    color: cMistyWhite,
                  ),
                  label: 'Settings',
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
