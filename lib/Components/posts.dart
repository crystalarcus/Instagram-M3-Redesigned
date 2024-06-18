import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
// import 'package:media_kit/media_kit.dart';
// import 'package:media_kit_video/media_kit_video.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/Components/Utils/save_post_sheet.dart';
import 'package:redesigned/Components/comment_sheet.dart';
// import 'package:redesigned/Components/comment_sheet.dart';
import 'package:redesigned/Components/post_viewer.dart';
import 'package:redesigned/Components/share_sheet.dart';

class MobilePost extends StatefulWidget {
  const MobilePost({
    super.key,
    required this.post,
  });
  final Post post;
  // final Function openComment;
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
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Account acc =
                          getAccountFromUserName(widget.post.person.userName);
                      context.push('/profile/true', extra: acc);
                    },
                    child: Row(
                      children: [
                        CachedNetworkImage(
                          height: 36,
                          width: 36,
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          placeholderFadeInDuration: const Duration(seconds: 0),
                          placeholder: (context, url) => Icon(
                              Icons.account_circle_rounded,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant),
                          fit: BoxFit.contain,
                          imageUrl: widget.post.person.pfpPath,
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.post.person.name,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.post.person.userName,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
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
                                return ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                                height: 50,
                                                width: 150,
                                                child: FilledButton.tonalIcon(
                                                    onPressed: () {},
                                                    icon: const Icon(Icons
                                                        .play_circle_outline),
                                                    label: const Text(
                                                      "Remix",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))),
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
                                                      "QR Code",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ))),
                                          ],
                                        )),
                                    const Divider(),
                                    ListItem(
                                      leading: const Icon(Icons.info_outline),
                                      title: "Why your're seeing this post",
                                      onTap: () {},
                                    ),
                                    ListItem(
                                      leading: const Icon(
                                          Icons.visibility_off_outlined),
                                      title: "Not interested",
                                      onTap: () {},
                                    ),
                                    ListItem(
                                      leading: const Icon(
                                          Icons.account_circle_outlined),
                                      title: "About this account",
                                      onTap: () {},
                                    ),
                                    ListItem(
                                      leading: const Icon(Icons.tune_outlined),
                                      title: "Manage suggested content",
                                      onTap: () {},
                                    ),
                                    ListItem(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      leading:
                                          const Icon(Icons.warning_amber_sharp),
                                      title: "Report this post",
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
          widget.post.type == PostType.image
              ? ImagePostWidget(imagePost: widget.post as ImagePostObject)
              // : widget.post.type == PostType.carosel
              : CarouselPostWidget(
                  imagePost: widget.post as CarouselPostObject),
          // : ReelPost(post: widget.post as ReelPostObject),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  widget.post.subTitle,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 12),
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
              const SizedBox(width: 12),
              SizedBox(
                  height: 40,
                  child: IconButton.filledTonal(
                      onPressed: () {
                        showFlexibleBottomSheet(
                            useRootNavigator: true,
                            context: context,
                            anchors: [0, 0.6, 1],
                            bottomSheetBorderRadius:
                                const BorderRadius.vertical(
                                    top: Radius.circular(24)),
                            maxHeight: 1,
                            initHeight: 0.6,
                            bottomSheetColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            minHeight: 0,
                            useRootScaffold: true,
                            isSafeArea: true,
                            builder: (BuildContext context,
                                    ScrollController controller, double d) =>
                                CommentSheet(
                                  controller: controller,
                                ));
                      },
                      // label: const Text("2.3K"),
                      icon: Icon(MdiIcons.commentTextOutline))),
              const SizedBox(width: 12),
              SizedBox(
                  height: 40,
                  child: IconButton.filledTonal(
                      onPressed: () {
                        showFlexibleBottomSheet(
                            useRootNavigator: true,
                            context: context,
                            anchors: [0, 0.6, 1],
                            bottomSheetBorderRadius:
                                const BorderRadius.vertical(
                                    top: Radius.circular(24)),
                            maxHeight: 1,
                            initHeight: 0.6,
                            bottomSheetColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            minHeight: 0,
                            useRootScaffold: true,
                            isSafeArea: true,
                            builder: (BuildContext context,
                                    ScrollController controller, double d) =>
                                ShareSheet(
                                  controller: controller,
                                ));
                      },
                      // label: const Text("Share"),
                      icon: Icon(MdiIcons.sendVariantOutline))),
              const Spacer(),
              SizedBox(
                  height: 40,
                  child: IconButton.filledTonal(
                    onPressed: () {
                      showFlexibleBottomSheet(
                        useRootNavigator: true,
                        isCollapsible: true,
                        maxHeight: 1,
                        initHeight: 1,
                        isExpand: false,
                        isSafeArea: true,
                        bottomSheetBorderRadius: const BorderRadius.vertical(
                            top: Radius.circular(24)),
                        context: context,
                        builder:
                            (context, scrollController, bottomSheetOffset) =>
                                SavePostSheet(
                          controller: scrollController,
                        ),
                      );
                    },
                    icon: const Icon(Icons.bookmark_outline),
                  )
                  //  SelectButton(
                  //   isSelected: saved,
                  //   title: "Save",
                  //   onPressed: () {
                  //     setState(() {
                  //       saved = !saved;
                  //     });
                  //   },
                  //   selectedIcon: Icons.bookmark,
                  //   unselectedIcon: Icons.bookmark_outline,
                  // )
                  ),
              const SizedBox(width: 12)
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton(
                  onPressed: () {},
                  // icon: Stack(
                  //   children: [
                  //     ClipRRect(
                  //       borderRadius: BorderRadius.circular(24),
                  //       child: CachedNetworkImage(
                  //         height: 24,
                  //         width: 24,
                  //         errorWidget: (context, url, error) =>
                  //             const Icon(Icons.error),
                  //         placeholderFadeInDuration: const Duration(seconds: 0),
                  //         placeholder: (context, url) => Icon(
                  //             Icons.account_circle_rounded,
                  //             color: Theme.of(context)
                  //                 .colorScheme
                  //                 .onSurfaceVariant),
                  //         fit: BoxFit.contain,
                  //         imageUrl: accounts[21].person.pfpPath,
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 3, left: 3),
                  //       child: ClipRRect(
                  //         borderRadius: BorderRadius.circular(24),
                  //         child: CachedNetworkImage(
                  //           height: 24,
                  //           width: 24,
                  //           errorWidget: (context, url, error) =>
                  //               const Icon(Icons.error),
                  //           placeholderFadeInDuration:
                  //               const Duration(seconds: 0),
                  //           placeholder: (context, url) => Icon(
                  //               Icons.account_circle_rounded,
                  //               color: Theme.of(context)
                  //                   .colorScheme
                  //                   .onSurfaceVariant),
                  //           fit: BoxFit.contain,
                  //           imageUrl: accounts[24].person.pfpPath,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),

                  child: const Text("23.5K Likes")),
              const SizedBox(height: 4),
              const Text("6.4K Replies")
            ],
          ),
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.title,
    required this.onTap,
    required this.leading,
    this.color,
  });
  final Color? color;
  final String title;
  final void Function() onTap;
  final Widget leading;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title),
      iconColor: color,
      onTap: onTap,
      titleTextStyle: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: color ?? Theme.of(context).colorScheme.onSurface),
    );
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
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width / 2.5,
            child: widget.post.type == PostType.image
                ? ImagePostWidget(
                    imagePost: widget.post as ImagePostObject,
                  )
                : CarouselPostWidget(
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                placeholderFadeInDuration:
                                    const Duration(seconds: 0),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                fit: BoxFit.contain,
                                imageUrl: widget.post.person.pfpPath),
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
                          physics: const ClampingScrollPhysics(),
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
                                          .surfaceContainerHighest,
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

class CarouselPostWidget extends StatefulWidget {
  const CarouselPostWidget({super.key, required this.imagePost});
  final CarouselPostObject imagePost;
  @override
  State<CarouselPostWidget> createState() => _CarouselPostWidgetState();
}

class _CarouselPostWidgetState extends State<CarouselPostWidget> {
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
            child: Stack(
              children: [
                FlutterCarousel(
                  items: widget.imagePost.imagePaths
                      .map((e) => Builder(
                            builder: (BuildContext context) =>
                                CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    placeholderFadeInDuration:
                                        const Duration(seconds: 0),
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                    fit: BoxFit.contain,
                                    imageUrl:
                                        "https://drive.google.com/uc?export=view&id=$e"),
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
                    indicatorMargin: 4,
                    slideIndicator: CircularWaveSlideIndicator(
                      indicatorRadius: 3,
                      itemSpacing: 12,
                      indicatorBackgroundColor:
                          Theme.of(context).colorScheme.surfaceContainerHigh,
                      currentIndicatorColor:
                          Theme.of(context).colorScheme.primary,
                    ),
                    floatingIndicator: true,
                    showIndicator: true,
                  ),
                ),
                // const Align(
                // alignment: Alignment.bottomRight, child: Text("2/3")),
              ],
            )));
  }
}

class ImagePostWidget extends StatefulWidget {
  const ImagePostWidget({super.key, required this.imagePost});
  final ImagePostObject imagePost;
  @override
  State<ImagePostWidget> createState() => _ImagePostWidgetState();
}

class _ImagePostWidgetState extends State<ImagePostWidget> {
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
        child: CachedNetworkImage(
            errorWidget: (context, url, error) => const Icon(Icons.error),
            placeholderFadeInDuration: const Duration(seconds: 0),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress),
                ),
            fit: BoxFit.contain,
            imageUrl:
                "https://drive.google.com/uc?export=view&id=${widget.imagePost.imagePath}"),
      ),
    );
  }
}

// class ReelPost extends StatefulWidget {
//   const ReelPost({super.key, required this.post});
//   final ReelPostObject post;
//   @override
//   State<ReelPost> createState() => _ReelPostState();
// }

// class _ReelPostState extends State<ReelPost> {
//   late final Player player;
//   late final VideoController videoController = VideoController(player);

//   @override
//   void initState() {
//     super.initState();
//     player.open(Media(widget.post.sourcePath));
//   }

//   @override
//   void dispose() {
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.sizeOf(context).width,
//       child: Video(controller: videoController),
//     );
//   }
// }

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
        child: IconButton.filledTonal(
          onPressed: onTap,
          // label: Text(widget.title),
          icon: AnimatedScale(
              duration: Durations.short3,
              scale: scaleValue,
              child: Icon(
                widget.isSelected ? widget.selectedIcon : widget.unselectedIcon,
                color: widget.isSelected
                    ? widget.selectedColor
                    : widget.unselectedColor,
              )),
        ));
  }
}

// https://drive.google.com/uc?export=view&id=1NzFWd6g29p7n-96bOBQFagS6Q1NlGviL
// https://drive.google.com/file/d/1JpcQdKOF3N2MJe00fSvvjSxAvhdbLAo4/view?usp=drive_link

// class imgData {
//   imgData({required this.name, required this.id});
//   final String name;
//   final String id;
// }

// var imgDataList = <imgData>[
//   imgData(name: "raiden", id: "1NzFWd6g29p7n-96bOBQFagS6Q1NlGviL"),
//   imgData(name: "furina", id: "1JpcQdKOF3N2MJe00fSvvjSxAvhdbLAo4")
// ];
