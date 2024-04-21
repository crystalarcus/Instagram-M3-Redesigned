import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/Components/comment_sheet.dart';
import 'package:redesigned/Components/post_viewer.dart';
import 'package:redesigned/main.dart';

class MobilePost extends StatefulWidget {
  const MobilePost({super.key, required this.post});
  final Post post;
  @override
  State<MobilePost> createState() => _MobilePostState();
}

class _MobilePostState extends State<MobilePost> {
  bool liked = false;
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Account acc = getAccountFromUserName(
                                  widget.post.person.userName);
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
                  widget.post.type == PostType.image
                      ? ImagePostDesktop(
                          imagePost: widget.post as ImagePostObject)
                      : CarouselPostDesktop(
                          imagePost: widget.post as CarouselPostObject),
                  const SizedBox(height: 10),
                  Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        textAlign: TextAlign.left,
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
            )));
  }
}

class DesktopPost extends StatefulWidget {
  const DesktopPost({super.key, required this.post});
  final Post post;
  @override
  State<DesktopPost> createState() => _DesktopPostState();
}

class _DesktopPostState extends State<DesktopPost> {
  bool liked = false;
  int currentPage = 0;
  bool saved = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).width /
              (2.5 * widget.post.aspectRatio)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: MainApp.of(context).getSurfaceContainer(),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 2.5,
            child: widget.post.type == PostType.image
                ? ImagePostDesktop(
                    imagePost: widget.post as ImagePostObject,
                  )
                : CarouselPostDesktop(
                    imagePost: widget.post as CarouselPostObject),
          ),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage(widget.post.person.pfpPath),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.post.person.name,
                                style: GoogleFonts.manrope(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                widget.post.person.userName,
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                    height: 40,
                                    child: SelectButton(
                                        isSelected: liked,
                                        onPressed: () {
                                          setState(() {
                                            liked = !liked;
                                          });
                                        },
                                        selectedColor: Colors.red,
                                        selectedIcon: Icons.favorite,
                                        unselectedIcon: Icons.favorite_outline,
                                        title: "23K")),
                                const SizedBox(width: 12),
                                SizedBox(
                                    height: 40,
                                    child: FilledButton.tonalIcon(
                                        onPressed: () {},
                                        icon: Icon(MdiIcons.replyOutline),
                                        label: const Text("16K"))),
                                const SizedBox(width: 12),
                                SizedBox(
                                    height: 40,
                                    child: IconButton.filledTonal(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Symbols.send,
                                          weight: 700,
                                          size: 20,
                                        ))),
                                const SizedBox(width: 12),
                                SizedBox(
                                    height: 40,
                                    child: IconButton.filledTonal(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.bookmark_outline,
                                          weight: 700,
                                          size: 20,
                                        ))),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                                style: TextStyle(fontSize: 16),
                                softWrap: true,
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor.\nIncididunt ut labore et dolore magna aliqua."),
                            const SizedBox(height: 16),
                            widget.post.tags.isNotEmpty
                                ? Text(
                                    "Tags",
                                    style: GoogleFonts.manrope(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                        fontWeight: FontWeight.w600),
                                  )
                                : const SizedBox(),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: widget.post.tags
                                  .map((e) => ActionChip(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          side: const BorderSide(
                                              color: Colors.transparent)),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant,
                                      onPressed: () {},
                                      label: Text(e)))
                                  .toList(),
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
        ],
      ),
    );
  }
}

class CarouselPostDesktop extends StatefulWidget {
  const CarouselPostDesktop({super.key, required this.imagePost});
  final CarouselPostObject imagePost;
  @override
  State<CarouselPostDesktop> createState() => _CarouselPostDesktopState();
}

class _CarouselPostDesktopState extends State<CarouselPostDesktop> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
              transitionDuration: Durations.medium1,
              pageBuilder: (context, animation, secondAnimtion) =>
                  FadeTransition(
                    opacity: animation,
                    child: CarouselPostViewer(
                        initPage: currentPage,
                        imageTag: widget.imagePost.postId.toString(),
                        post: widget.imagePost),
                  )));
        },
        child: Hero(
            tag: widget.imagePost.postId.toString(),
            child: FlutterCarousel(
              items: widget.imagePost.imagePaths
                  .map((e) => Builder(
                        builder: (BuildContext context) => Image(
                          image: AssetImage(e),
                          fit: BoxFit.contain,
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
                aspectRatio: widget.imagePost.aspectRatio,
                slideIndicator: CircularWaveSlideIndicator(
                  indicatorRadius: 4,
                  indicatorBackgroundColor:
                      Theme.of(context).colorScheme.outlineVariant,
                  currentIndicatorColor: Theme.of(context).colorScheme.primary,
                ),
                floatingIndicator: false,
                showIndicator: true,
              ),
            )));
  }
}

class ImagePostDesktop extends StatefulWidget {
  const ImagePostDesktop({super.key, required this.imagePost});
  final ImagePostObject imagePost;
  @override
  State<ImagePostDesktop> createState() => _ImagePostDesktopState();
}

class _ImagePostDesktopState extends State<ImagePostDesktop> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
            transitionDuration: Durations.medium1,
            pageBuilder: (context, animation, secondAnimtion) => FadeTransition(
                  opacity: animation,
                  child: ImagePostViewer(
                      imageTag: widget.imagePost.postId.toString(),
                      image: widget.imagePost.imagePath),
                )));
      },
      child: Hero(
          tag: widget.imagePost.postId.toString(),
          child: Image.asset(
            widget.imagePost.imagePath,
            fit: BoxFit.contain,
          )),
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
