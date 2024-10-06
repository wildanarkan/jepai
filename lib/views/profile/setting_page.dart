import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final GetStorage _storage = GetStorage();
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    isDarkMode = _storage.read('isDarkMode') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            title: Text(
              'Dark Mode',
              style: theme.textTheme.bodyLarge,
            ),
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
                _storage.write('isDarkMode', isDarkMode);
                Get.changeThemeMode(isDarkMode ? ThemeMode.dark : ThemeMode.light);
              });
            },
          ),
        ],
      ),
    );
  }
}
