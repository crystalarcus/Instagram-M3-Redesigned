import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/profile_screen.dart';

class InterestsScreen extends StatefulWidget {
  const InterestsScreen({super.key});

  @override
  State<InterestsScreen> createState() => _InterestsScreenState();
}

class _InterestsScreenState extends State<InterestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Interests"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              ListItem(
                title: "Favorites",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FavoritesScreen(),
                      ));
                },
                currentInfo: "You dont have any favorites yet",
                subtitle:
                    "Posts from your favourites are shown higer in feeds. We don’t send notifications when you edit your favourites.",
                iconData: Icons.star_outline,
              ),
              const SizedBox(height: 12),
              ListItem(
                title: "Muted accounts",
                onTap: () {},
                currentInfo: "You haven’t muted any account yet",
                subtitle:
                    "If  you don't want to see someone's posts in your feed, see their stories  at the top of your feed or see incoming messages they send you",
                iconData: Icons.notifications_off_outlined,
              ),
              const SizedBox(height: 12),
              ListItem(
                title: "Suggested content",
                onTap: () {},
                currentInfo: "You don’t have any suggested content",
                subtitle:
                    "Content from accounts that you don’t follow. This content will be shown more in your feeds.",
                iconData: Symbols.animated_images,
              ),
            ],
          ),
        ));
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.currentInfo,
    required this.subtitle,
    required this.iconData,
  });
  final String title;
  final String currentInfo;
  final String subtitle;
  final IconData iconData;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              children: [
                Icon(iconData),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        currentInfo,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                            fontSize: 12,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        SizedBox(
          height: 45,
          width: double.maxFinite,
          child: FilledButton.icon(
              icon: const Icon(Icons.done),
              onPressed: () {},
              label: const Text("Confirm Favourites")),
        )
      ],
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SearchBar(
              onTap: () {},
              elevation: const WidgetStatePropertyAll(0),
              hintText: "Search favorites",
              leading: const Icon(
                Symbols.search,
                weight: 700,
              ),
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16)),
            ),
          ),
          const FavoritesGetStarted()
        ],
      ),
    );
  }
}

class FavoritesGetStarted extends StatefulWidget {
  const FavoritesGetStarted({super.key});

  @override
  State<FavoritesGetStarted> createState() => _FavoritesGetStartedState();
}

class _FavoritesGetStartedState extends State<FavoritesGetStarted> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Favourites",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  TextButton(onPressed: () {}, child: const Text("Remove all"))
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "You can confirm these suggested favourites based on your activity.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ...[12, 13, 15, 5, 23, 25, 3].map((i) => FavouritesItem(
              p: accounts[i].person,
              onTap: () {},
              isSelected: true,
            )),
        const Divider(),
        const Padding(
            padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
            child: Text("Suggested")),
        ...[4, 6, 24, 14, 16, 17, 26, 7].map((i) => FavouritesItem(
            p: accounts[i].person, onTap: () {}, isSelected: false))
      ],
    );
  }
}

class FavouritesItem extends StatelessWidget {
  const FavouritesItem({
    super.key,
    required this.p,
    required this.onTap,
    required this.isSelected,
  });
  final Person p;
  final bool isSelected;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                  acc: getAccountFromUserName(p.userName), newStories: true),
            ));
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      title: Text(
        p.name,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        p.userName,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, progress) =>
            CircularProgressIndicator(
          value: progress.progress,
        ),
        imageUrl: p.pfpPath,
        width: 55,
      ),
      trailing: SizedBox(
        height: 36,
        child: isSelected
            ? OutlinedButton(onPressed: () {}, child: const Text("Remove"))
            : FilledButton.tonal(onPressed: () {}, child: const Text("Add")),
      ),
    );
  }
}
