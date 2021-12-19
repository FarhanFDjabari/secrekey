import 'package:flutter/material.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/styles/text_styles.dart';

class SecreKeySettingsPage extends StatefulWidget {
  static const routeName = '/settings-page';
  const SecreKeySettingsPage({Key? key}) : super(key: key);

  @override
  _SecreKeySettingsPageState createState() => _SecreKeySettingsPageState();
}

class _SecreKeySettingsPageState extends State<SecreKeySettingsPage> {
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
          ],
        ),
      ),
    );
  }
}
