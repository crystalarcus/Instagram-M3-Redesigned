import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/Components/comment_sheet.dart';
import 'package:redesigned/Components/post_viewer.dart';
import 'package:redesigned/main.dart';

class CarouselPost extends StatefulWidget {
  final CarouselPostObject post;
  const CarouselPost({super.key, required this.post});
  @override
  State<CarouselPost> createState() => _CarouselPostState();
}

class _CarouselPostState extends State<CarouselPost> {
  bool liked = false;
  int currentPage = 0;
  bool saved = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      child: Container(
          width: double.infinity,
          color: MainApp.of(context).getSurfaceContainerLow(),
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Account acc =
                                getAccountFromUserName('furina_sunshine');
                            context.push('/profile/true', extra: acc);
                          },
                          child: Row(
                            children: [
                              Image(
                                image: AssetImage(widget.post.person.pfpPath),
                                height: 36,
                                width: 36,
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.post.person.name,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    widget.post.person.userName,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ],
                          )),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: const Text("3 hrs"))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                // Container(
                //     width: double.maxFinite,
                //     height: 200,
                //     padding: const EdgeInsets.all(10),
                //     child: const M3Carousel(
                //         visible: 1,
                //         width: 300,
                //         titleTextSize: 0, // number of visible slabs
                //         borderRadius: 20,
                //         slideAnimationDuration: 300, // milliseconds
                //         titleFadeAnimationDuration: 200, // milliseconds
                //         children: [
                //           {
                //             "image": "images/post/media-1.png",
                //             "title": "HuTao"
                //           },
                //           {"image": "images/raiden.png", "title": "Rae"},
                //           {"image": "images/hutao.png", "title": "HuTao"},
                //           {"image": "images/ayato.png", "title": "HuTao"},
                //           {"image": "images/itto.png", "title": "HuTao"},
                //           {"image": "images/venti.png", "title": "HuTao"},
                //           {"image": "images/yaemiko.png", "title": "HuTao"}
                //         ])),

                GestureDetector(
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).push(
                          PageRouteBuilder(
                              transitionDuration: Durations.medium1,
                              pageBuilder: (context, animation,
                                      secondAnimtion) =>
                                  FadeTransition(
                                    opacity: animation,
                                    child: CarouselPostViewer(
                                        initPage: currentPage,
                                        imageTag: widget.post.postId.toString(),
                                        post: widget.post),
                                  )));
                    },
                    child: Hero(
                        tag: widget.post.postId.toString(),
                        child: FlutterCarousel(
                          items: widget.post.imagePaths
                              .map((e) => Builder(
                                    builder: (BuildContext context) => Image(
                                      image: AssetImage(e),
                                      fit: BoxFit.cover,
                                    ),
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            initialPage: currentPage,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentPage = index;
                              });
                            },
                            viewportFraction: 1,
                            slideIndicator: CircularWaveSlideIndicator(
                              indicatorRadius: 4,
                              indicatorBackgroundColor:
                                  Theme.of(context).colorScheme.outlineVariant,
                              currentIndicatorColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            floatingIndicator: false,
                            showIndicator: true,
                          ),
                        ))),

                const SizedBox(height: 10),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      widget.post.subTitle,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0),
                    )),
                const SizedBox(
                  height: 12,
                ),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        SelectButton(
                          isSelected: liked,
                          selectedColor: Colors.red,
                          onPressed: () {
                            setState(() {
                              liked = !liked;
                            });
                          },
                          title: "2.3K",
                          selectedIcon: Icons.favorite,
                          unselectedIcon: Icons.favorite_outline,
                        ),
                        const SizedBox(width: 8),
                        SizedBox(
                            height: 40,
                            child: FilledButton.tonalIcon(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      enableDrag: true,
                                      useRootNavigator: true,
                                      useSafeArea: true,
                                      showDragHandle: true,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) =>
                                          const CommentSheet());
                                },
                                label: const Text("2.3K"),
                                icon: Icon(MdiIcons.replyOutline))),
                        const SizedBox(width: 8),
                        SizedBox(
                            height: 40,
                            child: FilledButton.tonalIcon(
                                onPressed: () {},
                                label: const Text("Share"),
                                icon: Icon(MdiIcons.sendVariantOutline))),
                        const SizedBox(width: 8),
                        SizedBox(
                            height: 40,
                            child: SelectButton(
                              isSelected: saved,
                              title: "Save",
                              onPressed: () {
                                setState(() {
                                  saved = !saved;
                                });
                              },
                              selectedIcon: Icons.bookmark,
                              unselectedIcon: Icons.bookmark_outline,
                            ))
                      ],
                    ))
              ],
            ),
          )),
    );
  }

  void showCommentSheet() {
    showModalBottomSheet<void>(
        context: context,
        enableDrag: true,
        useRootNavigator: true,
        showDragHandle: true,
        builder: (BuildContext context) {
          return ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      IconButton.filledTonal(
                          onPressed: () {
                            setState(() {
                              saved = !saved;
                            });
                          },
                          icon: Icon(
                            saved ? Icons.bookmark : Icons.bookmark_outline,
                            size: 36,
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text("Save")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton.filledTonal(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.play_circle_outline,
                            size: 36,
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text("Remix")
                    ],
                  ),
                  Column(
                    children: [
                      IconButton.filledTonal(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.qr_code,
                            size: 36,
                          )),
                      const SizedBox(
                        height: 6,
                      ),
                      const Text("QR code")
                    ],
                  ),
                ],
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("Why your're seeing this post"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.visibility_off_outlined),
                title: const Text("Not interested"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.account_circle_outlined),
                title: const Text("About this account"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.tune_outlined),
                title: const Text("Manage suggested content"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.warning_amber_sharp),
                title: const Text("Report this post"),
                onTap: () {},
              ),
            ],
          );
        });
  }
}

class ImagePost extends StatefulWidget {
  final ImagePostObject postObject;
  const ImagePost({super.key, required this.postObject});
  @override
  State<ImagePost> createState() => _ImagePostState();
}

class _ImagePostState extends State<ImagePost> {
  bool liked = false;
  bool saved = false;

  @override
  void initState() {
    // initAsync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(14)),
        child: Container(
            width: double.infinity,
            color: MainApp.of(context).getSurfaceContainerLow(),
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image(
                              image:
                                  AssetImage(widget.postObject.person.pfpPath),
                              height: 36,
                              width: 36,
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.postObject.person.name,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  widget.postObject.person.userName,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "3 hrs",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.outline),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      useRootNavigator: true,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.surface,
                                      showDragHandle: true,
                                      builder: (BuildContext context) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    SizedBox(
                                                        height: 50,
                                                        width: 150,
                                                        child: FilledButton.tonalIcon(
                                                            onPressed: () {},
                                                            icon: const Icon(Icons
                                                                .play_circle_outline),
                                                            label: const Text(
                                                                "Remix"))),
                                                    const SizedBox(
                                                      width: 16,
                                                    ),
                                                    SizedBox(
                                                        height: 50,
                                                        width: 150,
                                                        child: FilledButton.tonalIcon(
                                                            onPressed: () {},
                                                            icon: const Icon(
                                                                Icons.qr_code),
                                                            label: const Text(
                                                                "QR Code"))),
                                                  ],
                                                )),
                                            const Divider(),
                                            ListTile(
                                              titleTextStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              textColor: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              leading: const Icon(
                                                  Icons.info_outline),
                                              title: const Text(
                                                  "Why your're seeing this post"),
                                              onTap: () {},
                                            ),
                                            ListTile(
                                              titleTextStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              textColor: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              leading: const Icon(Icons
                                                  .visibility_off_outlined),
                                              title:
                                                  const Text("Not interested"),
                                              onTap: () {},
                                            ),
                                            ListTile(
                                              titleTextStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              textColor: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              leading: const Icon(Icons
                                                  .account_circle_outlined),
                                              title: const Text(
                                                  "About this account"),
                                              onTap: () {},
                                            ),
                                            ListTile(
                                              titleTextStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              textColor: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondaryContainer,
                                              leading: const Icon(
                                                  Icons.tune_outlined),
                                              title: const Text(
                                                  "Manage suggested content"),
                                              onTap: () {},
                                            ),
                                            ListTile(
                                              titleTextStyle: const TextStyle(
                                                  fontWeight: FontWeight.w600),
                                              iconColor: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                              textColor: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                              leading: const Icon(
                                                  Icons.warning_amber_sharp),
                                              title: const Text(
                                                  "Report this post"),
                                              onTap: () {},
                                            ),
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(Icons.more_vert))
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push(
                            PageRouteBuilder(
                                transitionDuration: Durations.medium1,
                                pageBuilder: (context, animation,
                                        secondAnimtion) =>
                                    FadeTransition(
                                      opacity: animation,
                                      child: ImagePostViewer(
                                          imageTag: widget.postObject.postId
                                              .toString(),
                                          image: widget.postObject.imagePath),
                                    )));
                      },
                      child: ClipRRect(
                        child: SizedBox(
                            child: Hero(
                                tag: widget.postObject.postId.toString(),
                                child:
                                    Image.asset(widget.postObject.imagePath))),
                      )),
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        widget.postObject.subTitle,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0),
                      )),
                  const SizedBox(
                    height: 12,
                  ),
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const SizedBox(width: 8),
                          SelectButton(
                            isSelected: liked,
                            selectedColor: Colors.red,
                            onPressed: () {
                              setState(() {
                                liked = !liked;
                              });
                            },
                            title: "2.3K",
                            selectedIcon: Icons.favorite,
                            unselectedIcon: Icons.favorite_outline,
                          ),
                          const SizedBox(width: 8),
                          SizedBox(
                              height: 40,
                              child: FilledButton.tonalIcon(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        enableDrag: true,
                                        useRootNavigator: true,
                                        useSafeArea: true,
                                        showDragHandle: true,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) =>
                                            const CommentSheet());
                                  },
                                  label: const Text("2.3K"),
                                  icon: Icon(MdiIcons.replyOutline))),
                          const SizedBox(width: 8),
                          SizedBox(
                              height: 40,
                              child: FilledButton.tonalIcon(
                                  onPressed: () {},
                                  label: const Text("Share"),
                                  icon: Icon(MdiIcons.sendVariantOutline))),
                          const SizedBox(width: 8),
                          SizedBox(
                              height: 40,
                              child: SelectButton(
                                isSelected: saved,
                                title: "Save",
                                onPressed: () {
                                  setState(() {
                                    saved = !saved;
                                  });
                                },
                                selectedIcon: Icons.bookmark,
                                unselectedIcon: Icons.bookmark_outline,
                              ))
                        ],
                      ))
                ],
              ),
            )));
  }
}

class ImagePostDesktop extends StatefulWidget {
  const ImagePostDesktop({super.key, required this.imagePost});
  final ImagePost imagePost;
  @override
  State<ImagePostDesktop> createState() => _ImagePostDesktopState();
}

class _ImagePostDesktopState extends State<ImagePostDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MainApp.of(context).getSurfaceContainer(),
      ),
      child: Row(
        children: [Image.asset(widget.imagePost.postObject.imagePath)],
      ),
    );
  }
}

class SelectButton extends StatefulWidget {
  const SelectButton({
    super.key,
    required this.title,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.isSelected,
    required this.onPressed,
    this.selectedColor,
    this.unselectedColor,
  });
  final String title;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final bool isSelected;
  final Function onPressed;
  final Color? selectedColor;
  final Color? unselectedColor;

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton>
    with TickerProviderStateMixin {
  double scaleValue = 1;

  void onTap() {
    widget.onPressed();
    setState(() {
      scaleValue = 1.4;
    });
    Future.delayed(Durations.short3, () {
      setState(() {
        scaleValue = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: FilledButton.tonalIcon(
          onPressed: onTap,
          label: Text(widget.title),
          icon: AnimatedScale(
              duration: Durations.short3,
              scale: scaleValue,
              child: Icon(
                size: 22,
                widget.isSelected ? widget.selectedIcon : widget.unselectedIcon,
                color: widget.isSelected
                    ? widget.selectedColor
                    : widget.unselectedColor,
              )),
        ));
  }
}
