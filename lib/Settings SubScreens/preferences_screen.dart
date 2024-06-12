import 'package:flutter/material.dart';
import 'package:redesigned/main.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  ThemeMode _themeMode = ThemeMode.system;
  bool hideLikeAndShare = false;

  @override
  Widget build(BuildContext context) {
    bool isSearchFloating = MainApp.of(context).isSearchFloating;
    _themeMode = MainApp.of(context).themeMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferences"),
      ),
      body: ListView(
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
          ListTile(
            onTap: () {},
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: const Icon(Icons.translate_outlined),
            title: const Text("Language"),
            subtitle: const Text("English"),
          ),
          SwitchListTile(
              title: const Text("Hide like & share counts"),
              subtitle: const Text("These settings also apply on Threads"),
              secondary: const Icon(Icons.visibility_off_outlined),
              value: hideLikeAndShare,
              onChanged: (bool value) {
                setState(() {
                  hideLikeAndShare = value;
                });
              }),
          SwitchListTile(
              title: const Text("Floating Searchbar"),
              subtitle: const Text("Make search bar reappears when you scroll up"),
              secondary: const Icon(Icons.search),
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
