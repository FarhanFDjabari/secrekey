import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:secrekey/presentation/controllers/tools_controller.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/styles/text_styles.dart';

class SaveKeyDialog extends StatelessWidget {
  SaveKeyDialog({
    Key? key,
    required this.newKey,
  }) : super(key: key);

  final String newKey;
  final _newKey = TextEditingController();
  final _keyDesc = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final toolsController = Get.find<ToolsController>();

  @override
  Widget build(BuildContext context) {
    _newKey.text = newKey;
    return Dialog(
      backgroundColor: cMistyWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Save New Key to Vault',
                  style: kTextTheme.bodyText2!.copyWith(
                    color: cBaseBlack,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _newKey,
                  decoration: InputDecoration(
                    labelText: 'Key',
                    labelStyle: kTextTheme.bodyText2!.copyWith(
                      color: cMilkyGreyBlue,
                      fontSize: 14,
                    ),
                    focusColor: cMilkyGreyBlue,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: cMilkyGreyBlue),
                    ),
                  ),
                  style: kTextTheme.bodyText2!.copyWith(
                    color: cMilkyGreyBlue,
                    fontSize: 14,
                  ),
                  cursorColor: cMilkyGreyBlue,
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _keyDesc,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: kTextTheme.bodyText2!.copyWith(
                      color: cMilkyGreyBlue,
                      fontSize: 14,
                    ),
                    focusColor: cMilkyGreyBlue,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: cMilkyGreyBlue),
                    ),
                  ),
                  maxLines: 5,
                  maxLength: 100,
                  style: kTextTheme.bodyText2!.copyWith(
                    color: cMilkyGreyBlue,
                    fontSize: 14,
                  ),
                  cursorColor: cMilkyGreyBlue,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      toolsController.saveNewKey(
                        _newKey.text,
                        _keyDesc.text,
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: cMilkyGreyBlue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
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
      ),
    );
  }
}
