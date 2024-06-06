import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redesigned/Components/Utils/classes.dart';

class StoryView extends StatefulWidget {
  const StoryView({super.key, required this.story});
  final StoryGroup story;
  @override
  State<StoryView> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late int length;
  int currentIndex = 0;
  void createController() {
    _controller = AnimationController(
        vsync: this, duration: widget.story.stories[currentIndex].duration)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) async {
        if (status == AnimationStatus.completed && currentIndex == length - 1) {
          await Future.delayed(const Duration(milliseconds: 600), () {
            context.pop();
          });
        } else if (status == AnimationStatus.completed &&
            currentIndex != length - 1) {
          setState(() {
            currentIndex++;
            createController();
          });
        }
      });
    _controller.forward();
  }

  @override
  void initState() {
    length = widget.story.stories.length;
    createController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          GestureDetector(
              // splashFactory: NoSplash.splashFactory,
              // highlightColor: Colors.transparent,
              // hoverColor: Colors.transparent,
              onTapDown: (details) {
                _controller.stop();
              },
              onTapUp: (details) {
                _controller.forward();
              },
              child: Listener(
                  onPointerUp: (event) {
                    if (event.position.dx >
                        MediaQuery.of(context).size.width / 2) {
                      if (currentIndex == length - 1) {
                        context.pop();
                        return;
                      }
                      currentIndex++;
                    } else if (currentIndex == 0) {
                    } else {
                      currentIndex--;
                    }
                    _controller.reset();
                    _controller.forward();
                  },
                  child: Center(
                    child: CachedNetworkImage(
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      placeholderFadeInDuration: const Duration(seconds: 0),
                      placeholder: (context, url) => Icon(
                          Icons.account_circle_rounded,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                      fit: BoxFit.contain,
                      imageUrl: widget.story.stories[currentIndex].pathToMedia,
                    ),
                  ))),
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back)),
                  const SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      height: 45,
                      width: 45,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      placeholderFadeInDuration: const Duration(seconds: 0),
                      placeholder: (context, url) => Icon(
                          Icons.account_circle_rounded,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                      fit: BoxFit.contain,
                      imageUrl: widget.story.person.pfpPath,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.story.person.name,
                        // currentIndex.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${widget.story.stories[0].uploadTime} ago",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert))
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                  children: widget.story.stories
                      .mapIndexed((index, element) => Expanded(
                              child: Row(
                            children: [
                              Expanded(
                                  child: LinearProgressIndicator(
                                      value: currentIndex > index
                                          ? 1
                                          : currentIndex < index
                                              ? 0
                                              : _controller.value)),
                              SizedBox(width: index == length - 1 ? 0 : 4)
                            ],
                          )))
                      .toList())
            ],
          ),
          Column(
            children: [
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 90,
                      child: SearchBar(
                        textStyle: const WidgetStatePropertyAll(
                            TextStyle(height: 1.2)),
                        shadowColor:
                            const WidgetStatePropertyAll(Colors.transparent),
                        padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 12)),
                        leading: Icon(MdiIcons.replyOutline),
                        hintText: "Reply to this story",
                      )),
                  SizedBox(
                      height: 56,
                      width: 56,
                      child: IconButton.filledTonal(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_outline)))
                ],
              ),
              const SizedBox(
                height: 12,
              )
            ],
          )
        ],
      ),
    ));
  }
}
