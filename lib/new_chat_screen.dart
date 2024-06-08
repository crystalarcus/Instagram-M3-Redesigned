import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/main.dart';

class NewChatScreen extends StatefulWidget {
  const NewChatScreen({super.key});

  @override
  State<NewChatScreen> createState() => _NewChatScreenState();
}

class _NewChatScreenState extends State<NewChatScreen> {
  List<String> selected = [];
  SearchController controller = SearchController();
  String search = "";
  bool firstSearch = true;
  List<Person> shownAccouns = myFollowersConst;
  Widget header(String title) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        if (controller.text == "") {
          firstSearch = true;
          shownAccouns = myFollowersConst;
        } else {
          firstSearch = false;
          shownAccouns = myFollowersConst
              .where((element) =>
                  element.name
                      .toLowerCase()
                      .contains(controller.text.toLowerCase()) ||
                  element.userName
                      .toLowerCase()
                      .contains(controller.text.toLowerCase()))
              .toList();
        }
      });
    });
    return Scaffold(
      floatingActionButton: AnimatedSwitcher(
        duration: Durations.medium2,
        reverseDuration: Durations.short3,
        switchInCurve: Easing.emphasizedDecelerate,
        switchOutCurve: Easing.emphasizedAccelerate,
        transitionBuilder: (child, animation) => ScaleTransition(
          alignment: Alignment.bottomRight,
          scale: animation,
          child: child,
        ),
        child: selected.isNotEmpty
            ? FloatingActionButton.extended(
                label: const Text("Chat"),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewGroupScreen(
                                participantsList: selected,
                              )));
                },
                icon: const Icon(Icons.add),
              )
            : const SizedBox(),
      ),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("New Chat"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SearchBar(
                  controller: controller,
                  leading: const SizedBox(
                      width: 40,
                      child: Icon(
                        Symbols.search,
                        weight: 600,
                        size: 22,
                      )),
                  shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                  hintText: "Search people")),
        ),
      ),
      body: ListView(
        children: <Widget>[
          selected.isEmpty ? const SizedBox() : header("Selected"),
          AnimatedSize(
            curve: Easing.emphasizedDecelerate,
            duration: Durations.medium4,
            clipBehavior: Clip.none,
            child: selected.isEmpty
                ? const SizedBox()
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selected
                        .map(
                          (e) => TweenAnimationBuilder<double>(
                              curve: Easing.emphasizedDecelerate,
                              tween: Tween(begin: 80, end: 180),
                              duration: Durations.medium3,
                              builder: (context, double size, child) =>
                                  ConstrainedBox(
                                    constraints: BoxConstraints(maxWidth: size),
                                    child: Chip(
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                      onDeleted: () {
                                        setState(() {
                                          selected.remove(e);
                                        });
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      label: Text(
                                        e,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      avatar: CircleAvatar(
                                          child: CachedNetworkImage(
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                    placeholderFadeInDuration: const Duration(seconds: 0),
                                              placeholder: (context, url) => Icon(
                                                  Icons.account_circle_rounded,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onSurfaceVariant),
                                              fit: BoxFit.contain,
                                              imageUrl:
                                                  getAccountFromUserName(e)
                                                      .person
                                                      .pfpPath)),
                                    ),
                                  )),
                        )
                        .toList(),
                  ),
          ),
          header(controller.text.isEmpty ? "Suggested" : "Results"),
          ...shownAccouns.map((e) => ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                onTap: () {
                  setState(() {
                    selected.contains(e.userName)
                        ? selected.remove(e.userName)
                        : selected.add(e.userName);
                  });
                },
                title: Text(e.name),
                subtitle: Text(e.userName),
                leading: CircleAvatar(
                    child: CachedNetworkImage(
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        placeholderFadeInDuration: const Duration(seconds: 0),
                        placeholder: (context, url) => Icon(
                            Icons.account_circle_rounded,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        fit: BoxFit.contain,
                        imageUrl: e.pfpPath)),
                trailing: selected.contains(e.userName)
                    ? const CircleAvatar(
                        radius: 16,
                        child: Icon(
                          Symbols.done,
                          weight: 800,
                          size: 18,
                        ),
                      )
                    : const SizedBox(),
              )),
          const SizedBox(height: 64)
        ],
      ),
    );
  }
}

class NewGroupScreen extends StatefulWidget {
  const NewGroupScreen({super.key, required this.participantsList});
  final List<String> participantsList;
  @override
  State<NewGroupScreen> createState() => _NewGroupScreenState();
}

class _NewGroupScreenState extends State<NewGroupScreen> {
  String groupName = "";

  @override
  Widget build(BuildContext context) {
    List<Person> participants = [];
    for (var element in widget.participantsList) {
      participants.add(getAccountFromUserName(element).person);
    }
    return Scaffold(
        persistentFooterButtons: [
          SizedBox(
            height: 45,
            child: FilledButton(
                onPressed: () {}, child: const Text("Create Group")),
          ),
          SizedBox(
            height: 45,
            child: OutlinedButton(
                onPressed: () {},
                child: const Text(
                  "Continue",
                  textAlign: TextAlign.center,
                )),
          ),
        ],
        appBar: AppBar(
          title: const Text("New Group"),
          toolbarHeight: 64,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  setState(() {
                    groupName = value;
                  });
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Group name"),
              ),
              const SizedBox(height: 18),
              Text(
                "Participants",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 12),
              Wrap(
                  children:
                      participants.map((e) => MemberWidget(person: e)).toList())
            ],
          ),
        ));
  }
}

class MemberWidget extends StatelessWidget {
  const MemberWidget({super.key, required this.person});
  final Person person;
  @override
  Widget build(BuildContext context) {
    const double size = 64;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(size),
              child: CachedNetworkImage(
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  placeholderFadeInDuration: const Duration(seconds: 0),
                  placeholder: (context, url) => Icon(
                      Icons.account_circle_rounded,
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                  fit: BoxFit.contain,
                  imageUrl: person.pfpPath)),
          const SizedBox(height: 6),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: size),
            child: Text(
              overflow: TextOverflow.ellipsis,
              person.name,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
