import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secrekey/presentation/controllers/settings_controller.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/styles/text_styles.dart';

class SecreKeySettingsPage extends GetView<SettingsController> {
  const SecreKeySettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: kTextTheme.headline5!.copyWith(
                color: cBaseBlack,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      'Dark Mode',
                      style: TextStyle(
                        color:
                            controller.isDark.value ? cMistyWhite : cBaseBlack,
                      ),
                    ),
                    tileColor: cMistyWhite,
                    trailing: Obx(() => CupertinoSwitch(
                          value: controller.isDark.value,
                          thumbColor: cMistyWhite,
                          activeColor: cDarkGreyBlue,
                          trackColor: cLightGreyBlue,
                          onChanged: (value) {
                            controller.changeTheme(value);
                          },
                        )),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: cMilkyGreyBlue,
                onPrimary: cDarkGreyBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.saveSettings();
              },
              child: SizedBox(
                height: 56,
                child: Center(
                  child: Text(
                    'Save Setting',
                    style: kTextTheme.button!.copyWith(
                      color: cMistyWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
