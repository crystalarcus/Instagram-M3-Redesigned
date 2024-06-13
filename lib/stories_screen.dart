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
    [accounts[09].person, 4],
    [accounts[19].person, 0],
    [accounts[10].person, 2],
    [accounts[24].person, 0],
    [accounts[25].person, 3],
    [accounts[15].person, 1],
    [accounts[17].person, 0],
    [accounts[22].person, 0],
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
                        height: 64,
                        width: 64,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        placeholderFadeInDuration: const Duration(seconds: 0),
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
                    .map((e) => StoryTile(person: e[0], notifNum: e[1]))
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
              extra: StoryGroup(person: widget.person, stories: [
                Story(
                    duration: const Duration(seconds: 7),
                    pathToMedia:
                        "https://drive.google.com/uc?export=view&id=${posts[0].coverImagePath}",
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
            placeholderFadeInDuration: const Duration(seconds: 0),
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
