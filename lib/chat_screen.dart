import 'package:flutter/material.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/main.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.person});
  final Person person;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ItemScrollController controller;
  bool isScrolling = false;

  void goToChat(int id) {
    controller.scrollTo(index: id, duration: Durations.medium1);
  }

  @override
  void initState() {
    controller = ItemScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainApp.of(context).getSurface(),
      appBar: AppBar(
        toolbarHeight: 64,
        titleSpacing: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1.8,
                    color: widget.person.isStoryVisible
                        ? widget.person.newStory
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outlineVariant
                        : Colors.transparent),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    widget.person.pfpPath,
                    height: 40,
                    width: 40,
                  )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.person.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.person.userName,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                )
              ],
            )
          ],
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ScrollablePositionedList.builder(
                reverse: true,
                itemScrollController: controller,
                itemCount: chatTexts.length,
                itemBuilder: (context, index) => chatTexts[index].sentByUser
                    ? UserChat(
                        isTopSame: index < chatTexts.length - 1 &&
                            chatTexts[index + 1].sentByUser,
                        chatText: chatTexts[index],
                      )
                    // ChatTextWidget(
                    //     scrollTo: goToChat,
                    //     chatText: chatTexts[index],
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: chatTexts[index].sentByUser ||
                    //               (index > 0 && chatTexts[index - 1].sentByUser)
                    //           ? const Radius.circular(22)
                    //           : Radius.zero,
                    //       topRight: chatTexts[index].sentByUser &&
                    //               (index > 0 && chatTexts[index - 1].sentByUser)
                    //           ? Radius.zero
                    //           : const Radius.circular(22),
                    //       bottomLeft: chatTexts[index].sentByUser
                    //           ? const Radius.circular(22)
                    //           : Radius.zero,
                    //       bottomRight: chatTexts[index].sentByUser
                    //           ? Radius.zero
                    //           : const Radius.circular(22),
                    //     ),
                    //     vertPadding: EdgeInsets.only(
                    //       top: (index > 0 &&
                    //               chatTexts[index - 1].sentByUser ==
                    //                   chatTexts[index].sentByUser)
                    //           ? 1
                    //           : 12,
                    //       bottom: (index < chatTexts.length - 1 &&
                    //               chatTexts[index + 1].sentByUser ==
                    //                   chatTexts[index].sentByUser)
                    //           ? 1
                    //           : 12,
                    //     ),
                    //   )
                    : InterlocutorChat(
                        chatText: chatTexts[index],
                        isTopSame: index < chatTexts.length - 1 &&
                            !chatTexts[index + 1].sentByUser,
                      )),
          )),
          Padding(
              padding: const EdgeInsets.all(6),
              child: SizedBox(
                  height: 56,
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        isDense: true,
                        hintText: "Message...",
                        hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.outline),
                        prefixIcon: SizedBox(
                          height: 48,
                          width: 54,
                          child: Align(
                              alignment: Alignment.center,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                  ))),
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.attach_file_outlined,
                                size: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.emoji_emotions_outlined,
                                size: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.mic,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 4)
                          ],
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  )))
        ],
      ),
    );
  }
}

List<String> emojis = [
  "❤️",
  "👍",
  "🎉",
  "💀",
  "😀",
  "😄",
  "😁",
  "😂",
  "🤣",
  "😊",
  "😇",
  "😉",
  "😍",
  "🥰",
  "🤗",
  "🤓",
  "😎",
  "🥳",
];

class InterlocutorChat extends StatefulWidget {
  const InterlocutorChat(
      {super.key, required this.chatText, required this.isTopSame});
  final ChatText chatText;
  final bool isTopSame;
  @override
  State<InterlocutorChat> createState() => _InterlocutorChatState();
}

class _InterlocutorChatState extends State<InterlocutorChat> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: widget.isTopSame ? 2 : 16,
      ),
      widget.chatText.repliedTo != null
          ? ReplyWidget(reply: widget.chatText.repliedTo)
          : const SizedBox(),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 120),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: widget.isTopSame
                        ? Radius.zero
                        : const Radius.circular(22),
                    bottomLeft: Radius.zero,
                    topRight: const Radius.circular(22),
                    bottomRight: const Radius.circular(22),
                  ),
                  color: Theme.of(context).colorScheme.surfaceVariant),
              child: Text(
                widget.chatText.text,
                style: chatTextStyle,
              ),
            ),
          ),
        ],
      )
    ]);
  }
}

class UserChat extends StatefulWidget {
  const UserChat({super.key, required this.chatText, required this.isTopSame});
  final ChatText chatText;
  final bool isTopSame;
  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.isTopSame ? 2 : 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 120),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(22),
                        bottomLeft: const Radius.circular(22),
                        topRight: widget.isTopSame
                            ? Radius.zero
                            : const Radius.circular(22),
                        bottomRight: Radius.zero,
                      ),
                      color: Theme.of(context).colorScheme.primary),
                  child: Text(
                    widget.chatText.text,
                    style: chatTextStyle.apply(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}

class ReplyWidget extends StatelessWidget {
  const ReplyWidget({super.key, required this.reply});
  final dynamic reply;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: MainApp.of(context).getSurfaceContainer()),
      child: Text(chatTexts[reply].text),
    );
  }
}

const chatTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

// class ChatTextWidget extends StatefulWidget {
//   const ChatTextWidget(
//       {super.key,
//       required this.chatText,
//       required this.borderRadius,
//       required this.vertPadding,
//       required this.scrollTo});
//   final ChatText chatText;
//   final BorderRadius borderRadius;
//   final EdgeInsets vertPadding;
//   final void Function(int) scrollTo;

//   @override
//   State<ChatTextWidget> createState() => _ChatTextWidgetState();
// }

// class _ChatTextWidgetState extends State<ChatTextWidget> {
//   late List<String> reactions;

//   @override
//   void initState() {
//     reactions = [...widget.chatText.reactions];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//         mainAxisAlignment: widget.chatText.sentByUser
//             ? MainAxisAlignment.end
//             : MainAxisAlignment.start,
//         children: [
//           Padding(
//               padding: widget.vertPadding,
//               child: Wrap(
//                 children: [
//                   Column(
//                     crossAxisAlignment: widget.chatText.sentByUser
//                         ? CrossAxisAlignment.end
//                         : CrossAxisAlignment.start,
//                     children: [
//                       widget.chatText.repliedTo != null
//                           ? ConstrainedBox(
//                               constraints: BoxConstraints(
//                                   maxWidth:
//                                       MediaQuery.of(context).size.width - 120),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "Replied to",
//                                     style: TextStyle(
//                                         color: Theme.of(context)
//                                             .colorScheme
//                                             .outline,
//                                         fontSize: 12,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   GestureDetector(
//                                     onTap: () {
//                                       widget.scrollTo(
//                                           chatTexts[widget.chatText.repliedTo]
//                                               .textid);
//                                     },
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                           color: MainApp.of(context)
//                                               .getSurfaceContainer(),
//                                           borderRadius:
//                                               BorderRadius.circular(30),
//                                         ),
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 12, vertical: 8),
//                                         child: Text(
//                                           chatTexts[widget.chatText.repliedTo]
//                                               .text,
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .onSurfaceVariant,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w500),
//                                         )),
//                                   )
//                                 ],
//                               ),
//                             )
//                           : const SizedBox(),
//                       const SizedBox(height: 2),
//                       MenuAnchor(
//                           alignmentOffset: widget.chatText.sentByUser
//                               ? Offset.zero
//                               : const Offset(40, 0),
//                           menuChildren: <Widget>[
//                             SubmenuButton(
//                                 leadingIcon:
//                                     const Icon(Icons.emoji_emotions_outlined),
//                                 menuChildren: <Widget>[
//                                   ConstrainedBox(
//                                     constraints: BoxConstraints(
//                                         maxWidth:
//                                             MediaQuery.of(context).size.width -
//                                                 120),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(6),
//                                       child: Wrap(
//                                         children: emojis
//                                             .map(
//                                               (e) => IconButton(
//                                                 onPressed: () {
//                                                   setState(() {
//                                                     reactions.add(e);
//                                                   });
//                                                   if (kDebugMode) {
//                                                     print(reactions);
//                                                   }
//                                                 },
//                                                 icon: Text(
//                                                   e,
//                                                   style: const TextStyle(
//                                                       fontSize: 22),
//                                                 ),
//                                               ),
//                                             )
//                                             .toList(),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                                 child: Text(
//                                   "React",
//                                   style: menuItemTextStyle,
//                                 )),
//                             MenuItemButton(
//                               style: menuItemButtonStyle,
//                               leadingIcon: const Icon(
//                                 Symbols.reply,
//                                 weight: 600,
//                                 size: 22,
//                               ),
//                               onPressed: () {},
//                               child: Text(
//                                 "Reply",
//                                 style: menuItemTextStyle,
//                               ),
//                             ),
//                             MenuItemButton(
//                               style: menuItemButtonStyle,
//                               leadingIcon: const Icon(
//                                 Symbols.send,
//                                 weight: 600,
//                                 size: 22,
//                               ),
//                               onPressed: () {},
//                               child: Text(
//                                 "Forward",
//                                 style: menuItemTextStyle,
//                               ),
//                             ),
//                             MenuItemButton(
//                               style: menuItemButtonStyle,
//                               leadingIcon: const Icon(
//                                 Symbols.content_copy,
//                                 weight: 600,
//                                 size: 22,
//                               ),
//                               onPressed: () {},
//                               child: Text(
//                                 "Copy",
//                                 style: menuItemTextStyle,
//                               ),
//                             ),
//                             widget.chatText.sentByUser
//                                 ? MenuItemButton(
//                                     style: menuItemButtonStyle,
//                                     leadingIcon: const Icon(
//                                       Symbols.delete,
//                                       weight: 600,
//                                       size: 22,
//                                     ),
//                                     onPressed: () {},
//                                     child: Text(
//                                       "Unsend       ",
//                                       style: menuItemTextStyle,
//                                     ),
//                                   )
//                                 : MenuItemButton(
//                                     style: menuItemButtonStyle,
//                                     leadingIcon: const Icon(
//                                       Symbols.delete,
//                                       weight: 600,
//                                       size: 22,
//                                     ),
//                                     onPressed: () {},
//                                     child: Text(
//                                       "Delete for you",
//                                       style: menuItemTextStyle,
//                                     ),
//                                   ),
//                             MenuItemButton(
//                               style: menuItemButtonStyle,
//                               leadingIcon: Icon(
//                                 Symbols.warning,
//                                 weight: 600,
//                                 size: 22,
//                                 color: Theme.of(context).colorScheme.error,
//                               ),
//                               onPressed: () {},
//                               child: Text(
//                                 "Report",
//                                 style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w600,
//                                     color: Theme.of(context).colorScheme.error),
//                               ),
//                             ),
//                           ],
//                           builder: (context, controller, child) =>
//                               GestureDetector(
//                                   onLongPress: () {
//                                     if (controller.isOpen) {
//                                       controller.close();
//                                     } else {
//                                       controller.open();
//                                     }
//                                   },
//                                   child: Badge(
//                                     alignment: Alignment.bottomLeft,
//                                     backgroundColor: Colors.transparent,
//                                     textStyle: const TextStyle(height: 3),
//                                     isLabelVisible: reactions.isNotEmpty,
//                                     label: Wrap(
//                                       direction: Axis.horizontal,
//                                       children: reactions
//                                           .map((e) => SizedBox(
//                                               height: 30,
//                                               width: 30,
//                                               child: InkWell(
//                                                   onTap: () {},
//                                                   child: Text(e))))
//                                           .toList(),
//                                     ),
//                                     child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: widget.borderRadius,
//                                             color: widget.chatText.sentByUser
//                                                 ? Theme.of(context)
//                                                     .colorScheme
//                                                     .primary
//                                                 : Theme.of(context)
//                                                     .colorScheme
//                                                     .primaryContainer),
//                                         child: ConstrainedBox(
//                                             constraints: BoxConstraints(
//                                                 maxWidth: MediaQuery.of(context)
//                                                         .size
//                                                         .width -
//                                                     120),
//                                             child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         vertical: 12,
//                                                         horizontal: 14),
//                                                 child: Text(
//                                                   widget.chatText.text,
//                                                   style: const TextStyle(
//                                                       fontSize: 16,
//                                                       fontWeight:
//                                                           FontWeight.w500,
//                                                       color: widget.chatText
//                                                               .sentByUser
//                                                           ? Theme.of(context)
//                                                               .colorScheme
//                                                               .onPrimary
//                                                           : Theme.of(context)
//                                                               .colorScheme
//                                                               .onPrimaryContainer),
//                                                 )))),
//                                   )))
//                     ],
//                   ),
//                 ],
//               ))
//         ]);
//   }
// }

var menuItemTextStyle = const TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);
const ButtonStyle menuItemButtonStyle = ButtonStyle(
    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)));
