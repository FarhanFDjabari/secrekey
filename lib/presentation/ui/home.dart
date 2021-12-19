import 'package:flutter/material.dart';
import 'package:secrekey/presentation/ui/secrekey_settings_page.dart';
import 'package:secrekey/presentation/ui/secrekey_tools_page.dart';
import 'package:secrekey/presentation/ui/secrekey_vault_page.dart';
import 'package:secrekey/styles/colors.dart';

class Home extends StatefulWidget {
  static const routeName = '/';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  List<Widget> screens = const [
    SecreKeyToolsPage(),
    SecreKeyVaultPage(),
    SecreKeySettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Colors.white,
          indicatorColor: cMilkyGreyBlue,
          labelTextStyle: MaterialStateProperty.all(
            const TextStyle(fontSize: 14, color: cBaseBlack),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
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
        ),
      ),
    );
  }
}
