import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:secrekey/presentation/bloc/tools/secrekey_tools_cubit.dart';
import 'package:secrekey/presentation/bloc/vault/secrekey_vault_cubit.dart';
import 'package:secrekey/presentation/ui/home.dart';
import 'package:secrekey/presentation/ui/secrekey_settings_page.dart';
import 'package:secrekey/presentation/ui/secrekey_tools_page.dart';
import 'package:secrekey/presentation/ui/secrekey_vault_page.dart';
import 'package:secrekey/styles/colors.dart';
import 'package:secrekey/styles/text_styles.dart';

import 'injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SecreKeyToolsCubit>(
          create: (_) => di.locator<SecreKeyToolsCubit>(),
        ),
        BlocProvider<SecreKeyVaultCubit>(
          create: (_) => di.locator<SecreKeyVaultCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'SecreKey',
        theme: ThemeData.light().copyWith(
          colorScheme: kColorScheme,
          brightness: Brightness.light,
          textTheme: kTextTheme,
        ),
        home: const Home(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case Home.routeName:
              return MaterialPageRoute(
                builder: (_) => const Home(),
              );
            case SecreKeyToolsPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SecreKeyToolsPage(),
              );
            case SecreKeyVaultPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SecreKeyVaultPage(),
              );
            case SecreKeySettingsPage.routeName:
              return MaterialPageRoute(
                builder: (_) => const SecreKeySettingsPage(),
              );
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found: False Route'),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
