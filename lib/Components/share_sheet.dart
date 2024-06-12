import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/Components/profile_view.dart';

class ShareSheet extends StatefulWidget {
  const ShareSheet({super.key, required this.controller});
  final ScrollController controller;
  @override
  State<ShareSheet> createState() => _ShareSheetState();
}

class _ShareSheetState extends State<ShareSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 36,
          child: Center(
            child: Container(
              color: Theme.of(context).colorScheme.outline,
              height: 4,
              width: 32,
            ),
          ),
        ),
        Expanded(
            child: ListView(
          controller: widget.controller,
          children: [
            const Row(
              children: [
                SizedBox(width: 16),
                Text(
                  "Share",
                  style: TextStyle(fontSize: 22),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      padding: const EdgeInsets.all(22),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add,
                        size: 36,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Add to story")
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      padding: const EdgeInsets.all(22),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.link,
                        size: 36,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Copy link")
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton.filledTonal(
                      padding: const EdgeInsets.all(22),
                      onPressed: () {},
                      icon: const Icon(
                        Icons.share_outlined,
                        size: 36,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Text("Share")
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: SearchBar(
                leading: Icon(Symbols.search, weight: 600),
                hintText: "Search people",
                elevation: WidgetStatePropertyAll(0),
                padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 16, vertical: 4)),
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              shrinkWrap: true,
              children: recentSent
                  .map((e) => ProfileView(
                        person: getPersonFromUserName(e),
                        size: 74,
                      ))
                  .toList(),
            )
          ],
        ))
      ],
    );
  }
}

const List<String> recentSent = [
  "please_die_soon",
  "furina_sunshine",
  "cook.with.shogun",
  "not.a.child",
  "eons_adrift",
  "skir7x",
  "library_momy",
  "hat_girl",
  "all_knowing_kid",
  "frozen_momy",
  "princess_purple",
];
