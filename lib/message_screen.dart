import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/Components/Utils/open_container.dart';
import 'package:redesigned/chat_screen.dart';
import 'package:redesigned/main.dart';
import 'package:redesigned/search_message_screen.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: ((context, constraints) => constraints.maxWidth > 840
            ? const MessageScreenDesktop()
            : const MessageScreenMobile()));
  }
}

class MessageScreenMobile extends StatefulWidget {
  const MessageScreenMobile({super.key});

  @override
  State<MessageScreenMobile> createState() => _MessageScreenMobileState();
}

class MessageSearchAnchor extends StatefulWidget {
  const MessageSearchAnchor({super.key});

  @override
  State<MessageSearchAnchor> createState() => _MessageSearchAnchorState();
}

class _MessageSearchAnchorState extends State<MessageSearchAnchor> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        transitionType: ContainerTransitionType.fadeThrough,
        middleColor: MainApp.of(context).getSurface(),
        closedShape: const CircleBorder(),
        closedColor: Colors.transparent,
        openElevation: 0,
        closedElevation: 0,
        closedBuilder: (context, openContainer) => SizedBox(
              height: 45,
              width: 45,
              child: IconButton(
                  onPressed: () {
                    openContainer();
                  },
                  icon: const Icon(
                    Icons.search,
                    weight: 600,
                  )),
            ),
        openBuilder: (context, controller) => const SearchMessageScreen());
  }
}

class _MessageScreenMobileState extends State<MessageScreenMobile> {
  Set<String> currentFilters = {};
  List<Chat> chatData = chats;
  List<String> newChatSelected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: MainApp.of(context).getSurface(),
        title: const Text(
          "Messages",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        actions: <Widget>[
          const MessageSearchAnchor(),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
                color: Colors.black,
                child: Image.asset(
                  'images/prof.png',
                  height: 30,
                )),
          ),
          const SizedBox(width: 16)
        ],
      ),
      backgroundColor: MainApp.of(context).getSurface(),
      body: ListView(
        children: [
          // Subheader Notes
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Text(
              "Notes",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),

          // NotesList
          SizedBox(
              height: 140,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: notes
                      .map((e) => NoteWidget(
                            note: e,
                          ))
                      .toList())),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: Text(
              "Chats",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                const SizedBox(width: 8),
                ...filters.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: FilterChip(
                        side: BorderSide.none,
                        backgroundColor:
                            MainApp.of(context).getSurfaceContainerHigh(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        label: Text(e),
                        labelPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        selected: currentFilters.contains(e),
                        onSelected: (bool isSelected) {
                          setState(() {
                            isSelected
                                ? currentFilters.add(e)
                                : currentFilters.remove(e);
                            currentFilters.isEmpty
                                ? chatData = chats
                                : chatData = chats.where((element) {
                                    if (element.newMessage > 0 &&
                                        currentFilters.contains('Unread')) {
                                      return true;
                                    } else if (element.newMessage == 0 &&
                                        currentFilters.contains('Read')) {
                                      return true;
                                    } else if (element.isActive &&
                                        currentFilters.contains('Active')) {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  }).toList();
                          });
                        },
                      ),
                    ))
              ],
            ),
          ),

          ...chatData.map((e) => OpenContainer(
              useRootNavigator: true,
              tappable: false,
              transitionType: ContainerTransitionType.fade,
              transitionDuration: Durations.medium3,
              reverseTransitionDuration: Durations.short4,
              middleColor: MainApp.of(context).getSurface(),
              closedColor: MainApp.of(context).getSurface(),
              openColor: MainApp.of(context).getSurface(),
              openElevation: 0,
              closedElevation: 0,
              clipBehavior: Clip.none,
              closedBuilder: (context, _) => ChatWidget(
                    chat: e,
                    openChat: () {
                      _();
                    },
                  ),
              openBuilder: (context, _) => MobileChatScreen(
                    person: e.person,
                  ))),
          const SizedBox(height: 120)
        ],
      ),
    );
  }
}

class MessageScreenDesktop extends StatefulWidget {
  const MessageScreenDesktop({super.key});

  @override
  State<MessageScreenDesktop> createState() => _MessageScreenDesktopState();
}

class _MessageScreenDesktopState extends State<MessageScreenDesktop> {
  List<String> currentFilters = [];
  List chatData = [];
  Person? currectActive;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainApp.of(context).getSurfaceContainerLowest(),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Row(
          children: <Widget>[
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                  color: MainApp.of(context).getSurface(),
                  borderRadius: BorderRadius.circular(14)),
              width: MediaQuery.sizeOf(context).width / 3.5,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: SearchBar(
                      backgroundColor: WidgetStatePropertyAll(
                          MainApp.of(context).getSurfaceContainerHigh()),
                      leading: const SizedBox(
                        height: 40,
                        width: 40,
                        child: Icon(Symbols.search),
                      ),
                      hintText: "Search messages",
                      onTap: () {},
                      elevation: const WidgetStatePropertyAll(0),
                      trailing: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                "images/prof.png",
                                height: 36,
                                width: 36,
                              ),
                              Positioned.fill(
                                  child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {},
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 55,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        const SizedBox(width: 8),
                        ...filters.map((e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: FilterChip(
                                side: BorderSide(
                                    color: currentFilters.contains(e)
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                        : Theme.of(context)
                                            .colorScheme
                                            .outlineVariant),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                label: Text(e),
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 2),
                                selected: currentFilters.contains(e),
                                onSelected: (bool isSelected) {
                                  setState(() {
                                    isSelected
                                        ? currentFilters.add(e)
                                        : currentFilters.remove(e);
                                    currentFilters.isEmpty
                                        ? chatData = chats
                                        : chatData = chats.where((element) {
                                            if (element.newMessage > 0 &&
                                                currentFilters
                                                    .contains('Unread')) {
                                              return true;
                                            } else if (element.newMessage ==
                                                    0 &&
                                                currentFilters
                                                    .contains('Read')) {
                                              return true;
                                            } else if (element.isActive &&
                                                currentFilters
                                                    .contains('Active')) {
                                              return true;
                                            } else {
                                              return false;
                                            }
                                          }).toList();
                                  });
                                },
                              ),
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView(
                    children: chats
                        .map((e) => ChatWidgetDesktop(
                            chat: e,
                            onPressed: () {
                              setState(() {
                                currectActive = e.person;
                              });
                            }))
                        .toList(),
                  ))
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: currectActive != null
                  ? DesktopChatScreen(person: currectActive!)
                  : Container(
                      decoration: BoxDecoration(
                          color: MainApp.of(context).getSurface()),
                      padding: const EdgeInsets.symmetric(),
                      child: const Center(
                        child: Text("Messages"),
                      ),
                    ),
            )),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}

class ChatWidgetDesktop extends StatelessWidget {
  const ChatWidgetDesktop(
      {super.key, required this.chat, required this.onPressed});
  final Chat chat;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        onTap: () {
          onPressed();
        },
        title: Text(
          chat.person.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        leading: CircleAvatar(
          radius: 28,
          child: Image.asset(chat.person.pfpPath),
        ),
        subtitle: Text(
          maxLines: 1,
          chat.lastMessageState == LastMessageState.sentByUserAndSeen
              ? "Seen"
              : chat.lastMessageState == LastMessageState.sentByUserAndUnseen
                  ? "Sent"
                  : chat.newMessage > 1
                      ? "${chat.newMessage} new messages"
                      : chat.lastMessage,
          style: TextStyle(
              fontSize: 14,
              fontWeight:
                  chat.newMessage == 0 ? FontWeight.w500 : FontWeight.w700,
              letterSpacing: 0),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              chat.lastTime,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600),
            ),
            // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
      ),
    );
  }
}

Set<String> filters = {'Unread', 'Read', 'Groups', 'Active', 'Starred'};

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.chat, required this.openChat});
  final Function openChat;
  final Chat chat;

  Widget chatBottomSheet() => ListView(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.attach_file_outlined),
            title: const Text("Send Attachment"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.pin_drop_outlined),
            title: const Text("Pin"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Symbols.delete_outline),
            title: const Text("Delete"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.message_outlined),
            title: const Text("Mute Messages"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(Icons.phone_outlined),
            title: const Text("Mute Calls"),
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openChat();
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: CircleAvatar(
                  radius: 24,
                  child: Image.asset(chat.person.pfpPath),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        chat.person.name,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                            color: chat.isActive
                                ? Theme.of(context).colorScheme.error
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20)),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Message
                  Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    chat.lastMessageState == LastMessageState.sentByUserAndSeen
                        ? "Seen"
                        : chat.lastMessageState ==
                                LastMessageState.sentByUserAndUnseen
                            ? "Sent"
                            : chat.newMessage > 1
                                ? "${chat.newMessage} new messages"
                                : chat.lastMessage,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: chat.newMessage == 0
                            ? FontWeight.w500
                            : FontWeight.w700,
                        letterSpacing: 0),
                  ),
                ],
              )),
              const SizedBox(width: 18),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.horizontal,
                children: [
                  Text(
                    chat.lastTime,
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          useRootNavigator: true,
                          showDragHandle: true,
                          isDismissible: true,
                          enableDrag: true,
                          context: context,
                          builder: (context) => chatBottomSheet());
                    },
                    icon: const Icon(Icons.more_vert),
                  )
                ],
              )
            ],
          )),
    );
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({super.key, required this.note});
  final Note note;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(children: [
            const SizedBox(
              height: 40,
            ),
            PfpView(p: note.person, size: 55)
          ]),
          Container(
            constraints: const BoxConstraints(maxWidth: 120),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12)),
            child: Text(
              note.note,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PfpView extends StatelessWidget {
  const PfpView({super.key, required this.p, required this.size});
  final Person p;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            p.pfpPath,
            height: size,
            width: size,
          ),
        ),
        Container(
            alignment: Alignment.center,
            width: size + 40,
            child: Text(
              p.userName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ))
      ],
    );
  }
}

// Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//     child:
//      SizedBox(
//       height: 56,
//       child:
//        SearchBar(
//         padding: const MaterialStatePropertyAll(
//             EdgeInsets.symmetric(horizontal: 14)),
//         leading: const Icon(
//           Symbols.search,
//           size: 22,
//           weight: 600,
//         ),
//         hintText: "Search Messages",
//         shadowColor:
//             const MaterialStatePropertyAll(Colors.transparent),
//         elevation: const MaterialStatePropertyAll(0),
//         backgroundColor: MaterialStatePropertyAll(
//             MainApp.of(context).getSurfaceContainerHigh()),
//         trailing: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: Image.asset(
//               'images/prof.png',
//               height: 30,
//             ),
//           ),
//         ],
//       ),
//     )),
