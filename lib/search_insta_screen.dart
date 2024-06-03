import 'package:flutter/material.dart';

class SearchInstaScreen extends StatefulWidget {
  const SearchInstaScreen({super.key});

  @override
  State<SearchInstaScreen> createState() => _SearchInstaScreenState();
}

class _SearchInstaScreenState extends State<SearchInstaScreen> {
  @override
  Widget build(BuildContext context) {
   final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor:colorScheme.surface ,
      body: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: colorScheme.surfaceContainer
          ),
        )
      ],
    ),
    );
  }
}

const recentSearchs = <String>["furina_sunshine","cook.with.shogun","princess_purple"];