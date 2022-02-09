import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:secrekey/presentation/controllers/tools_controller.dart';
import 'package:secrekey/presentation/widgets/save_key_dialog.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/styles/text_styles.dart';

class SecreKeyToolsPage extends GetView<ToolsController> {
  const SecreKeyToolsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SecreKey',
                style: kTextTheme.headline5!.copyWith(
                  color: cBaseBlack,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Text(
                'Generated Password'.toUpperCase(),
                style: kTextTheme.subtitle1!.copyWith(
                  color: cMilkyGreyBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 75,
                decoration: BoxDecoration(
                  color: cMilkyGreyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Obx(() {
                    if (controller.keyController.text.isNotEmpty &&
                        controller.isLoading.isFalse) {
                      return TextField(
                        controller: controller.keyController,
                        style: kTextTheme.headline6!.copyWith(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        enableInteractiveSelection: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          filled: true,
                          fillColor: cMilkyGreyBlue,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(
                                  text: controller.keyController.text,
                                ),
                              );
                              Get.showSnackbar(
                                const GetSnackBar(
                                  duration: Duration(seconds: 2),
                                  messageText:
                                      Text('Password Berhasil Disalin'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: cMistyWhite,
                            ),
                          ),
                        ),
                      );
                    } else if (controller.keyController.text.isEmpty &&
                        controller.isLoading.isFalse) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.generatedKeyLength.value,
                              (index) => index > 20
                                  ? Container()
                                  : Text(
                                      '_ ',
                                      maxLines: 1,
                                      softWrap: true,
                                      style: kTextTheme.headline6!.copyWith(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.55,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: cMilkyGreyBlue,
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ),
              const SizedBox(height: 15),
              Obx(() => Text(
                    'Length: ${controller.generatedKeyLength}'.toUpperCase(),
                    style: kTextTheme.subtitle1!.copyWith(
                      color: cMilkyGreyBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
              const SizedBox(height: 8),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: cMilkyGreyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text('4'),
                    ),
                    Expanded(
                      child: SliderTheme(
                        data: const SliderThemeData(
                          trackHeight: 1.0,
                          rangeThumbShape: RoundRangeSliderThumbShape(
                              enabledThumbRadius: 30, disabledThumbRadius: 30),
                        ),
                        child: Obx(() => Slider(
                              value: controller.generatedKeyLength.toDouble(),
                              thumbColor: cMistyWhite,
                              activeColor: cMistyWhite,
                              onChanged: (value) {
                                controller.generatedKeyLength(value.toInt());
                              },
                              min: 4,
                              max: 32,
                            )),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Text('32'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Options'.toUpperCase(),
                style: kTextTheme.subtitle1!.copyWith(
                  color: cMilkyGreyBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: cMilkyGreyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Include numbers',
                      style:
                          kTextTheme.subtitle1!.copyWith(color: Colors.white),
                    ),
                    Obx(() => CupertinoSwitch(
                          value: controller.includeNum.value,
                          thumbColor: cMistyWhite,
                          activeColor: cDarkGreyBlue,
                          trackColor: cLightGreyBlue,
                          onChanged: (value) {
                            controller.includeNum(value);
                          },
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: cMilkyGreyBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Include symbols',
                      style:
                          kTextTheme.subtitle1!.copyWith(color: Colors.white),
                    ),
                    Obx(() => CupertinoSwitch(
                          value: controller.includeSym.value,
                          thumbColor: cMistyWhite,
                          activeColor: cDarkGreyBlue,
                          trackColor: cLightGreyBlue,
                          onChanged: (value) {
                            controller.includeSym(value);
                          },
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: BorderSide(
                    color: controller.keyController.text.isEmpty
                        ? Colors.grey
                        : cMilkyGreyBlue,
                    width: 1.5,
                  ),
                  primary: controller.keyController.text.isEmpty
                      ? Colors.grey
                      : cMilkyGreyBlue,
                ),
                onPressed: controller.keyController.text.isEmpty
                    ? null
                    : () {
                        _showSavePasswordModal(controller.keyController.text);
                      },
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      'Save Password'.toUpperCase(),
                      style: kTextTheme.button!.copyWith(
                        color: controller.keyController.text.isEmpty
                            ? Colors.grey
                            : cMilkyGreyBlue,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: cMilkyGreyBlue,
                  onPrimary: cDarkGreyBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {
                  await controller.generateNewKey();
                },
                child: SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      'Generate Password'.toUpperCase(),
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
      ),
    );
  }

  void _showSavePasswordModal(String key) {
    Get.dialog(
      SaveKeyDialog(newKey: key),
    );
  }
}
