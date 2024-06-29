import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/main.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

const List<String> notifFilters = [
  "Story likes",
  "Story Replies",
  "Comment likes",
  "Comment Replies",
  "Post like",
  "Post replies"
      "Suggestions",
];

class _NotificationScreenState extends State<NotificationScreen> {
  List<String> filters = [];

  @override
  void dispose() {
    notifications = [
      [],
      [...notifications[0], ...notifications[1]],
      notifications[2]
    ];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          toolbarHeight: 64,
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: const Text(
            "Notifications",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
        ),
        body: ListView(children: [
          SizedBox(
              height: 55,
              child: ListView(scrollDirection: Axis.horizontal, children: [
                const SizedBox(
                  width: 12,
                ),
                ...notifFilters.map((e) => Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: FilterChip(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        selected: filters.contains(e),
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              filters.add(e);
                            } else {
                              filters.remove(e);
                            }
                          });
                        },
                        label: Text(e)))),
              ])),
          header(context, "New"),
          ...notifications[0].map((e) => NotifWidget(notification: e)),
          // const Divider(),
          header(context, "Today"),
          ...notifications[1].map((e) => NotifWidget(notification: e)),
          // const Divider(),
          header(context, "Yesterday"),
          ...notifications[2].map((e) => NotifWidget(notification: e)),
        ]));
  }
}

Widget header(BuildContext context, String text) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(24, 16, 24, 4),
    child: Text(
      text,
      style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.onSurfaceVariant),
    ),
  );
}

class NotifWidget extends StatefulWidget {
  const NotifWidget({super.key, required this.notification});
  final Notif notification;
  @override
  State<NotifWidget> createState() => _NotifWidgetState();
}

class _NotifWidgetState extends State<NotifWidget> {
  late final NotifType type;

  @override
  void initState() {
    type = widget.notification.notifType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholderFadeInDuration: const Duration(seconds: 0),
                  placeholder: (context, url) => Icon(
                      Icons.account_circle_rounded,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  fit: BoxFit.contain,
                  imageUrl: widget.notification.notifier.pfpPath,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color:
                              Theme.of(context).colorScheme.surfaceContainer),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.notification.notifier.userName,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.2,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    widget.notification.time,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.2,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.notification.textContent,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0),
                              ),
                              type == NotifType.commentLike
                                  ? Text(
                                      (widget.notification
                                              as CommentLikeNotficaiton)
                                          .commentText,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurfaceVariant,
                                          fontSize: 14),
                                    )
                                  : type == NotifType.commentReply
                                      ? Text(
                                          (widget.notification
                                                  as CommentReplyNotficaiton)
                                              .commentText,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurfaceVariant,
                                              fontSize: 14),
                                        )
                                      : const SizedBox()
                            ],
                          )),
                          const SizedBox(width: 16),
                          type == NotifType.follow
                              ? MainApp.of(context)
                                      .isFollowing(widget.notification.notifier)
                                  ? TextButton(
                                      onPressed: () {
                                        setState(() {
                                          MainApp.of(context).myFollower.remove(
                                              widget.notification.notifier);
                                        });
                                      },
                                      child: const Text("Followng"))
                                  : FilledButton(
                                      onPressed: () {
                                        setState(() {
                                          MainApp.of(context).myFollower.add(
                                              widget.notification.notifier);
                                        });
                                      },
                                      child: const Text("Follow"))
                              : type == NotifType.commentReply
                                  ? IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.expand_more))
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                          height: 50,
                                          width: 50,
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                          placeholderFadeInDuration:
                                              const Duration(seconds: 0),
                                          progressIndicatorBuilder: (context,
                                                  url, downloadProgress) =>
                                              Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "https://drive.google.com/uc?export=view&id=${widget.notification.contextImagePath}"),
                                    )
                        ],
                      ))),
            ],
          )),
    );
  }
}
