import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class InteractionsScreen extends StatefulWidget {
  const InteractionsScreen({super.key});

  @override
  State<InteractionsScreen> createState() => _InteractionsScreenState();
}

class _InteractionsScreenState extends State<InteractionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Interactions"),
      ),
      body: ListView(
        children: [
          ListItem(
              title: "Messages and story replies",
              iconData: Symbols.reply_all_rounded,
              onTap: () {}),
          ListItem(
              title: "Tags and mentions", iconData: Icons.tag, onTap: () {}),
          ListItem(title: "Messages", iconData: Symbols.message, onTap: () {}),
          ListItem(title: "Messages", iconData: Symbols.share, onTap: () {}),
          ListItem(
              title: "Messages",
              iconData: Symbols.account_circle_off,
              onTap: () {}),
          ListItem(title: "Messages", iconData: Symbols.warning, onTap: () {}),
          ListItem(
              title: "Messages",
              iconData: Symbols.reply_all_rounded,
              onTap: () {}),
          ListItem(
              title: "Messages",
              iconData: Symbols.reply_all_rounded,
              onTap: () {}),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    required this.iconData,
    required this.onTap,
  });
  final String title;
  final IconData iconData;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      titleTextStyle: TextStyle(
          fontSize: 18,
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w400),
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      onTap: onTap,
      title: Text(title),
      leading: Icon(iconData),
    );
  }
}
