import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:secrekey/data/models/generated_key.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/util/app_routes.dart';
import 'package:secrekey/util/route_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(GeneratedKeyAdapter());
  await Hive.openBox<GeneratedKey>('secreKey');
  await Hive.openBox('secreKeySettings');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SecreKey',
      theme: Get.isDarkMode ? kThemeDark : kThemeLight,
      getPages: AppRoute.routes,
      initialRoute: RouteName.home,
    );
  }
}
