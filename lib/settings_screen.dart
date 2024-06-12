import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:redesigned/Settings%20SubScreens/activity_screen.dart';
import 'package:redesigned/Settings%20SubScreens/interests_screen.dart';
import 'package:redesigned/Settings%20SubScreens/notification_settings_screen.dart';
import 'package:redesigned/Settings%20SubScreens/preferences_screen.dart';
import 'package:redesigned/Settings%20SubScreens/privacy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Settings",
          style: TextStyle(
              fontSize: 24, color: Theme.of(context).colorScheme.onSurface),
        ),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchBar(
              padding:
                  WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
              leading: Icon(
                Symbols.search,
                weight: 600,
              ),
              elevation: WidgetStatePropertyAll(0),
              hintText: "Search settings",
            ),
          ),
          const SizedBox(height: 8),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w400),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ActivityScreen(),
                  ));
            },
            leading: const Icon(Icons.data_usage_outlined),
            title: const Text("Activity"),
            subtitle: const Text("App usage and your activity"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PreferencesScreen(),
                  ));
            },
            leading: const Icon(Icons.auto_awesome_outlined),
            title: const Text("Preferences"),
            subtitle: const Text("Theme, Language and more"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationSettingsScreen(),
                  ));
            },
            leading: const Icon(Icons.notifications_outlined),
            title: const Text("Notifications"),
            subtitle: const Text("Manage app notifications"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrivacyScreen(),
                  ));
            },
            leading: const Icon(Icons.gpp_good_outlined),
            title: const Text("Privacy and Secrecy"),
            subtitle: const Text("Who can see your content"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InterestsScreen(),
                  ));
            },
            leading: Icon(MdiIcons.heartMultipleOutline),
            title: const Text("Your Interests"),
            subtitle: const Text("Control what you see"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {},
            leading: const Icon(Icons.people_alt_outlined),
            title: const Text("Interactions"),
            subtitle: const Text("How others interact with you"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {},
            leading: const Icon(Icons.pending_outlined),
            title: const Text("Other"),
            subtitle: const Text("Families, professional, payments and more"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {},
            leading: const Icon(Icons.help_outline),
            title: const Text("Support"),
            subtitle: const Text("Help, support and account status"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {},
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text("Account login"),
            subtitle: const Text("Manages accounts on this device"),
          ),
          ListTile(
            titleTextStyle: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            onTap: () {},
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            subtitle: const Text("App info and credits"),
          ),
          /*
        
           */
        ],
      ),
    );
  }
}
