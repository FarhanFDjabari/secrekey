import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:secrekey/data/models/generated_key.dart';
import 'package:secrekey/presentation/controllers/vault_controller.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/styles/text_styles.dart';

class SecreKeyVaultPage extends GetView<VaultController> {
  const SecreKeyVaultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'SecreKey Vault',
                    style: kTextTheme.headline5!.copyWith(
                      color: cBaseBlack,
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  PopupMenuButton(
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        onTap: () {},
                        height: 30,
                        child: Text(
                          'Export All Key',
                          style: kTextTheme.button!.copyWith(
                            color: cBaseBlack,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {},
                        height: 30,
                        child: Text(
                          'Import Key From Storage',
                          style: kTextTheme.button!.copyWith(
                            color: cBaseBlack,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                    child: const SizedBox(
                      height: 15,
                      child: Icon(
                        Icons.more_vert_outlined,
                        color: cBaseBlack,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            ValueListenableBuilder<Box<GeneratedKey>>(
              valueListenable: controller.box.listenable(),
              builder: (context, box, _) {
                final keyList = box.values.toList();
                if (keyList.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: keyList.length,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      itemBuilder: (_, index) => Container(
                        decoration: BoxDecoration(
                          color: cLightGreyBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: keyList[index].savedKey,
                                  ),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Password Berhasil Disalin'),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      keyList[index].savedKey,
                                      style: kTextTheme.subtitle1!.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.copy,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                              child: Center(
                                child: Divider(
                                  height: 1,
                                  color: Colors.white,
                                  thickness: 1,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  keyList[index].label,
                                  style: kTextTheme.bodyText2!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ),
                                PopupMenuButton(
                                  itemBuilder: (_) => [
                                    PopupMenuItem(
                                      onTap: () {
                                        controller.removeKey(keyList[index]);
                                      },
                                      height: 15,
                                      child: Text(
                                        'Delete Saved Key',
                                        style: kTextTheme.button!.copyWith(
                                          color: cBaseBlack,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                  child: const SizedBox(
                                    height: 15,
                                    child: Icon(
                                      Icons.more_horiz_rounded,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Center(
                    child: Text(
                      'This Vault is Empty',
                      style: kTextTheme.subtitle1!.copyWith(
                        color: cBaseBlack,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
