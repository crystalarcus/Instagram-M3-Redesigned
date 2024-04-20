import 'package:flutter/material.dart';
import 'package:redesigned/main.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int currentIndex = 0;
  ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    _themeMode = MainApp.of(context).themeMode;
    bool isSearchFloating = MainApp.of(context).isSearchFloating;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(MainApp.of(context).isDark()
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
            title: const Text("Theme"),
            subtitle: Text(_themeMode == ThemeMode.dark
                ? "Dark"
                : _themeMode == ThemeMode.light
                    ? "Light"
                    : "System"),
            onTap: () {
              showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(milliseconds: 200),
                  transitionBuilder: (context, anim1, anim2, child) {
                    return FadeTransition(
                      opacity: anim1,
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                            parent: anim1,
                            curve: const Cubic(0.05, 0.7, 0.1, 1.0)),
                        child: child,
                      ),
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return SimpleDialog(
                      title: const Text("Choose Theme"),
                      children: [
                        RadioListTile(
                            value: ThemeMode.system,
                            groupValue: _themeMode,
                            title: const Text(
                              "System",
                              style: TextStyle(fontSize: 18),
                            ),
                            onChanged: (t) {
                              setState(() {
                                MainApp.of(context)
                                    .changeTheme(ThemeMode.system);
                                _themeMode = ThemeMode.system;
                              });
                            }),
                        RadioListTile(
                            value: ThemeMode.light,
                            groupValue: _themeMode,
                            title: const Text(
                              "Light",
                              style: TextStyle(fontSize: 18),
                            ),
                            onChanged: (t) {
                              setState(() {
                                MainApp.of(context)
                                    .changeTheme(ThemeMode.light);
                                _themeMode = ThemeMode.light;
                              });
                            }),
                        RadioListTile(
                            value: ThemeMode.dark,
                            groupValue: _themeMode,
                            title: const Text(
                              "Dark",
                              style: TextStyle(fontSize: 18),
                            ),
                            onChanged: (t) {
                              setState(() {
                                MainApp.of(context).changeTheme(ThemeMode.dark);
                                _themeMode = ThemeMode.dark;
                              });
                            }),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Done"))
                              ],
                            ))
                      ],
                    );
                  });
            },
          ),
          SwitchListTile(
              title: const Text("Floating Searchbar"),
              secondary: const Icon(Icons.arrow_upward_rounded),
              value: isSearchFloating,
              onChanged: (bool value) {
                setState(() {
                  isSearchFloating = value;
                  MainApp.of(context).isSearchFloating = value;
                });
              })
        ],
      ),
    );
  }
}
