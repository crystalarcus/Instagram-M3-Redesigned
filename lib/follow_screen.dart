import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/profile_screen.dart';
import 'package:redesigned/main.dart';
// import 'package:redesigned/main.dart';

class FollowScreen extends StatefulWidget {
  FollowScreen({super.key, required this.name});
  final String name;
  final List<FollowPerson> followers = followersList;
  final List<FollowPerson> following = followersList;
  @override
  State<FollowScreen> createState() => _FollowScreenState();
}

class _FollowScreenState extends State<FollowScreen> {
  // late List<FollowPerson> _myFollowers;
  List<FollowPerson> mutual = [];

  @override
  void initState() {
    super.initState();
    // _myFollowers = MainApp.of(context).myFollower;
    for (FollowPerson element in widget.followers) {
      if (MainApp.of(context).isFollowing(element)) {
        mutual.add(element);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.surfaceContainerHighest,
              title: Text(widget.name),
              leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back)),
              bottom: TabBar(tabs: [
                Tab(text: '${widget.followers.length} Followers'),
                Tab(text: '${widget.following.length} Following'),
                Tab(text: '${mutual.length} Mutuals'),
              ]),
            ),
            body: Container(
              decoration: BoxDecoration(
                  color: MainApp.of(context).getSurfaceContainerLowest()),
              child: TabBarView(children: [
                ListView(
                  children: widget.followers
                      .map((e) => Follows(
                          isFollowing: e.isFollowing,
                          person: Person(
                              name: e.name,
                              userName: e.userName,
                              pfpPath: e.pfpPath)))
                      .toList(),
                ),
                ListView(
                  children: widget.followers
                      .map((e) => Follows(
                          isFollowing: e.isFollowing,
                          person: Person(
                              name: e.name,
                              userName: e.userName,
                              pfpPath: e.pfpPath)))
                      .toList(),
                ),
                ListView(
                  children: mutual
                      .map((e) => Follows(
                          isFollowing: e.isFollowing,
                          person: Person(
                              name: e.name,
                              userName: e.userName,
                              pfpPath: e.pfpPath)))
                      .toList(),
                )
              ]),
            )));
  }
}
