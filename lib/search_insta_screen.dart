import 'package:flutter/material.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/Components/profile_view.dart';

class SearchInstaScreen extends StatefulWidget {
  const SearchInstaScreen({super.key});

  @override
  State<SearchInstaScreen> createState() => _SearchInstaScreenState();
}

class _SearchInstaScreenState extends State<SearchInstaScreen> {
  late TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colorScheme.surface,
        body: ListView(
          children: [
            TextField(
              controller: controller,
              onChanged: (value) {
                if (value.isEmpty) {}
              },
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 22, horizontal: 4),
                  filled: true,
                  fillColor: colorScheme.surface,
                  prefixIcon: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  hintText: "Search Instagram",
                  suffixIcon: IconButton(
                      onPressed: () {
                        controller.clear();
                      },
                      icon: const Icon(Icons.clear))),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 6),
                  ...filterItems.map((element) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilterChip(
                          label: Text(element),
                          onSelected: (value) {},
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Header(text: "Recent"),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Material(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(24),
                color: colorScheme.surfaceContainer,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: recentSearchs
                      .map((element) => RecentItem(
                            title: element,
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 18),
            const Header(text: "Profiles"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: searchAccounts
                    .map((element) => Padding(
                          padding: const EdgeInsets.all(12),
                          child: ProfileViewTouchable(
                            person: element.person,
                            onTap: () {},
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Header(text: "Posts"),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.count(
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    1,
                    2,
                    3,
                    4,
                    5,
                    6,
                    7,
                    8,
                    9,
                    10,
                    11,
                    12,
                    13,
                    14,
                    15,
                    16,
                    17,
                    18,
                    19,
                    20,
                    21
                  ]
                      .map((e) => SizedBox.square(
                          child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                    color: colorScheme.surfaceContainerHighest),
                              ))))
                      .toList()),
            )
          ],
        ));
  }
}

class RecentItem extends StatelessWidget {
  const RecentItem({super.key, required this.title});
  final dynamic title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      onTap: () {},
      title: Text(title),
      leading: const Icon(Icons.history),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 22,
        ),
        Text(
          text,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.outline,
              letterSpacing: 1.2),
        )
      ],
    );
  }
}

const filterItems = <String>["Profiles", "Posts", "Reels", "Photos"];

const recentSearchs = <String>[
  "furina_sunshine",
  "kamisato.ayato",
  "cook.with.shogun",
  "princess_purple",
];

var searchAccounts = <Account>[
  accounts[3],
  accounts[6],
  accounts[19],
  accounts[15],
  accounts[23],
  accounts[16],
  accounts[7],
];
