import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';

class StoriesScreen extends StatefulWidget {
  const StoriesScreen({super.key});
  @override
  State<StoriesScreen> createState() => _StoriesScreenState();
}

// class storyData {
//   storyData(
//       {required this.name, required this.userName, required this.pfpPath});
//   String name;
//   String userName;
//   String pfpPath;
// }

class _StoriesScreenState extends State<StoriesScreen> {
  List li = [
    ["furina.sunshine", "Furina de Fontaine", "images/furina.png", 4],
    ["cook.with.shogun", "Raiden Shogun", "images/raiden.png", 0],
    ["please_die_soon", "Director Hu", "images/hutao.png", 2],
    ["guji_yae", "Yae Miko", "images/yaemiko.png", 0],
    ["alcohol.is.not.for.kidz", "Whos This Guy", "images/venti.png", 3],
    ["i_love_boba", "Kamisato Ayato", "images/ayato.png", 1],
    ["the.bull.chucker", "Arataki Itto", "images/itto.png", 0],
    ["not.a.child", "Tartaglia", "images/childe.png", 0],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.go('/');
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            "Stories",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        placeholderFadeInDuration: Durations.short1,
                        placeholder: (context, url) => Icon(
                            Icons.account_circle_rounded,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        fit: BoxFit.contain,
                        imageUrl: linkToPfp),
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Crystal",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      Text("crystal_arucs",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                      height: 40,
                      child: FilledButton.tonalIcon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text("Add")))
                ]),
              ),
              const SizedBox(height: 18),
              const Divider(),
              Column(
                children: li
                    .map((e) => StoryTile(
                        person:
                            Person(name: e[1], userName: e[0], pfpPath: e[2]),
                        notifNum: e[3]))
                    .toList(),
              )
            ],
          ),
        ));
  }
}

class StoryTile extends StatefulWidget {
  final Person person;
  final int notifNum;
  const StoryTile({super.key, required this.person, this.notifNum = 0});
  @override
  State<StoryTile> createState() => _StoryWidget();
}

class _StoryWidget extends State<StoryTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        minVerticalPadding: 24,
        visualDensity: const VisualDensity(vertical: 4),
        onTap: () {
          context.push('/storyview',
              extra: StoryGroup(
                  person: Person(
                      name: 'Raiden Shogun',
                      userName: 'cook.with.shogun',
                      pfpPath: 'images/raiden.png'),
                  stories: [
                    Story(
                        duration: const Duration(seconds: 7),
                        pathToMedia: 'images/post/11.png',
                        type: StoryType.image,
                        uploadTime: "47 min")
                  ]));
        },
        leading: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              border: Border.all(
                  width: 2.2, color: Theme.of(context).colorScheme.primary)),
          child: CachedNetworkImage(
            height: 55,
            width: 55,
            errorWidget: (context, url, error) => const Icon(Icons.error),
            placeholderFadeInDuration: Durations.short1,
            placeholder: (context, url) => Icon(Icons.account_circle_rounded,
                color: Theme.of(context).colorScheme.onSurfaceVariant),
            fit: BoxFit.contain,
            imageUrl: widget.person.pfpPath,
          ),
        ),
        title: Text(widget.person.name,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0)),
        subtitle: Text(widget.person.userName,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0)),
        trailing: Text(
          "${widget.notifNum} new",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ));
  }
}
