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
        backgroundColor: MainApp.of(context).getSurface(),
        appBar: AppBar(
          toolbarHeight: 64,
          backgroundColor: MainApp.of(context).getSurface(),
          title: const Text(
            "Notifications",
            style:
                TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
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
                        backgroundColor: MainApp.of(context).getSurface(),
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
          ...notifications[0].map(
              (e) => NotifWidget(notification: e, textContent: e.textContent)),
          // const Divider(),
          header(context, "Today"),
          ...notifications[1].map(
              (e) => NotifWidget(notification: e, textContent: e.textContent)),
          // const Divider(),
          header(context, "Yesterday"),
          ...notifications[2].map(
              (e) => NotifWidget(notification: e, textContent: e.textContent)),
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
  const NotifWidget(
      {super.key, required this.notification, required this.textContent});
  final String textContent;
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
                child: Image.asset(
                  widget.notification.notifier.pfpPath,
                  height: 40,
                  width: 40,
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
                          color: MainApp.of(context).getSurfaceContainer()),
                      child: Row(
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.notification.notifier.userName,
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.2,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant),
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
                                widget.textContent,
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
                                      child: Image.asset(
                                        fit: BoxFit.cover,
                                        widget.notification.contextImagePath,
                                        height: 50,
                                        width: 50,
                                      ),
                                    )
                        ],
                      ))),
            ],
          )),
    );
  }
}