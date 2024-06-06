import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redesigned/Components/Utils/classes.dart';

class StoryWidget extends StatelessWidget {
  final Person person;
  const StoryWidget({required this.person, super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 80),
      child: Column(
        children: <Widget>[
          InkWell(
              borderRadius: BorderRadius.circular(30),
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
                              uploadTime: "47 min"),
                          Story(
                              duration: const Duration(seconds: 7),
                              pathToMedia: 'stories/navia1.png',
                              type: StoryType.image,
                              uploadTime: "41 min"),
                          Story(
                              duration: const Duration(seconds: 7),
                              pathToMedia: 'stories/navia3.png',
                              type: StoryType.image,
                              uploadTime: "36 min"),
                          Story(
                              duration: const Duration(seconds: 7),
                              pathToMedia: 'stories/navia2.png',
                              type: StoryType.image,
                              uploadTime: "21 min"),
                        ]));
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                        width: 2.8,
                        color: Theme.of(context).colorScheme.primary)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    height: 65,
                    width: 65,
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    placeholderFadeInDuration: const Duration(seconds: 0),
                    placeholder: (context, url) => Icon(
                        Icons.account_circle_rounded,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                    fit: BoxFit.contain,
                    imageUrl: person.pfpPath,
                  ),
                ),
              )),
          Text(
            overflow: TextOverflow.ellipsis,
            person.userName,
            style: const TextStyle(),
            softWrap: true,
          )
        ],
      ),
    );
  }
}
