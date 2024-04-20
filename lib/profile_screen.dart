import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/main.dart';

class ProfileScreen extends StatefulWidget {
  final Account acc;
  final bool newStories;

  const ProfileScreen({
    super.key,
    required this.acc,
    required this.newStories,
  });
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  bool _isFollowing = true;
  bool _isFriend = true;
  late final TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _isFollowing = MainApp.of(context).isFollowing(widget.acc.person);
    _isFriend = MainApp.of(context).isFriend(widget.acc.person);
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverToBoxAdapter(
                    child: AppBar(
                      backgroundColor: colorScheme.surface,
                      leading: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.arrow_back)),
                      actions: <IconButton>[
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.more_vert))
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              // Top Row
                              children: [
                                Container(
                                  // StoryCircle
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(75),
                                      border: Border.all(
                                          width: 2,
                                          color: widget.newStories
                                              ? colorScheme.primary
                                              : colorScheme.outlineVariant)),
                                  child: Image.asset(widget.acc.person.pfpPath,
                                      height: 50, width: 50),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.acc.person.name,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: colorScheme.onSurface,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          widget.acc.person.userName,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  colorScheme.onSurfaceVariant,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0),
                                        ),
                                        IconButton(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.copy,
                                              size: 16,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 12),
                            widget.acc.pronouns.isEmpty
                                ? const SizedBox()
                                : Text(
                                    widget.acc.pronouns,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: colorScheme.onSurfaceVariant),
                                  ),
                            widget.acc.bio.isEmpty
                                ? const SizedBox()
                                : Text(
                                    widget.acc.bio,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.onSurface,
                                    ),
                                  ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                displays(24, "Posts", colorScheme.primary,
                                    colorScheme.onSurfaceVariant, () {}),
                                displays(
                                    13600,
                                    "Followers",
                                    colorScheme.primary,
                                    colorScheme.onSurfaceVariant, () {
                                  kIsWeb
                                      ? showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              SimpleDialog(
                                                insetPadding: EdgeInsets.only(
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2),
                                                elevation: 10,
                                                backgroundColor: MainApp.of(
                                                        context)
                                                    .getSurfaceContainerLowest(),
                                                title: const Text("Followers"),
                                                children: [
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            350,
                                                    width: 300,
                                                    child:
                                                        widget.acc.followers
                                                                .isEmpty
                                                            ? const Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            8,
                                                                        horizontal:
                                                                            24),
                                                                child: Text(
                                                                    "No Followers yet"),
                                                              )
                                                            : ListView(
                                                                children: widget
                                                                    .acc
                                                                    .followers
                                                                    .map((e) => Follows(
                                                                        isFollowing:
                                                                            MainApp.of(context).isUserNameFollowing(
                                                                                e),
                                                                        person:
                                                                            getPersonFromUserName(e)))
                                                                    .toList(),
                                                              ),
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  "Done"))
                                                        ],
                                                      ))
                                                ],
                                              ))
                                      : context.push(
                                          '/follow/${widget.acc.person.name}');
                                }),
                                displays(32, "Following", colorScheme.primary,
                                    colorScheme.onSurfaceVariant, () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          SimpleDialog(
                                            backgroundColor: MainApp.of(context)
                                                .getSurfaceContainerLow(),
                                            title: const Text("Following"),
                                            children: [
                                              LimitedBox(
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height -
                                                        350,
                                                child: Column(
                                                  children: widget.acc.following
                                                      .map((e) => Follows(
                                                          isFollowing: MainApp
                                                                  .of(context)
                                                              .isUserNameFollowing(
                                                                  e),
                                                          person:
                                                              getPersonFromUserName(
                                                                  e)))
                                                      .toList(),
                                                ),
                                              ),
                                              Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              "Done"))
                                                    ],
                                                  ))
                                            ],
                                          ));
                                }),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  // Following/Follow Buttons
                                  child: SizedBox(
                                      height: 40,
                                      child: _isFollowing
                                          ? FilledButton.tonalIcon(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          colorScheme
                                                              .surfaceVariant)),
                                              icon: const Icon(
                                                  Icons.remove_circle_outline),
                                              onPressed: () {
                                                setState(() {
                                                  _isFollowing = false;
                                                });
                                                MainApp.of(context)
                                                    .myFollower
                                                    .forEach((element) {
                                                  if (element.userName ==
                                                      widget.acc.person
                                                          .userName) {
                                                    MainApp.of(context)
                                                        .myFollower
                                                        .remove(element);
                                                  }
                                                });
                                              },
                                              label: const Text("Unfollow"))
                                          : FilledButton.icon(
                                              onPressed: () {
                                                setState(() {
                                                  // MainApp.of(context)
                                                  //     .setMyFollowers(_folowers);
                                                });
                                                _isFollowing = true;
                                                MainApp.of(context)
                                                    .myFollower
                                                    .add(Person(
                                                        name: widget
                                                            .acc.person.name,
                                                        userName: widget.acc
                                                            .person.userName,
                                                        pfpPath: widget.acc
                                                            .person.pfpPath));
                                              },
                                              icon: const Icon(Icons.add),
                                              label: const Text("Follow"))),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                    // Following/Follow Buttons
                                    child: SizedBox(
                                        height: 40,
                                        child: _isFriend
                                            ? OutlinedButton.icon(
                                                icon: const Icon(Icons
                                                    .person_remove_outlined),
                                                onPressed: () {
                                                  setState(() {
                                                    _isFriend = !_isFriend;
                                                  });
                                                  MainApp.of(context)
                                                      .myFriends
                                                      .forEach((element) {
                                                    if (element.userName ==
                                                        widget.acc.person
                                                            .userName) {
                                                      MainApp.of(context)
                                                          .myFriends
                                                          .remove(element);
                                                    }
                                                  });
                                                },
                                                label: const Text("Unfriend"))
                                            : FilledButton.tonalIcon(
                                                onPressed: () {
                                                  setState(() {
                                                    _isFriend = !_isFriend;
                                                  });
                                                  MainApp.of(context)
                                                      .myFriends
                                                      .add(Person(
                                                          name: widget
                                                              .acc.person.name,
                                                          userName: widget.acc
                                                              .person.userName,
                                                          pfpPath: widget.acc
                                                              .person.pfpPath));
                                                },
                                                icon: const Icon(Icons
                                                    .person_add_alt_1_outlined),
                                                label: const Text("Friend")))),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                          ],
                        )),
                  ),
                  SliverToBoxAdapter(
                    child: TabBar(controller: tabController, tabs: const [
                      Tab(
                        text: 'Posts',
                        icon: Icon(
                          Symbols.grid_view,
                          weight: 700,
                        ),
                      ),
                      Tab(
                        text: 'Reels',
                        icon: Icon(
                          Symbols.movie,
                          weight: 700,
                        ),
                      ),
                      Tab(
                        text: 'Live',
                        icon: Icon(
                          Symbols.cast,
                          weight: 700,
                        ),
                      ),
                    ]),
                  )
                ],
            body: Padding(
                padding: const EdgeInsets.only(top: 6),
                child: TabBarView(controller: tabController, children: [
                  dummyPost(Theme.of(context).colorScheme.primaryContainer),
                  dummyPost(Theme.of(context).colorScheme.outlineVariant),
                  dummyPost(Theme.of(context).colorScheme.surfaceVariant),
                ]))));
  }
}

Widget dummyPost(Color color) => GridView.count(
    crossAxisSpacing: 4,
    mainAxisSpacing: 4,
    physics: const NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 3,
    children: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
        .map((e) => SizedBox.square(
            child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(color: color),
                ))))
        .toList());

Widget displays(int data, String name, Color primary, Color onVariant,
        void Function()? onTap) =>
    InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                Text(
                  data.toString().length > 3
                      ? "${data.toString().substring(0, data.toString().length - 3)}.${data.toString()[data.toString().length - 3]}K"
                      : data.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: primary),
                ),
                SizedBox(
                    height: 25,
                    child: Text(
                      name,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: onVariant),
                    )),
              ],
            )));

class Follows extends StatefulWidget {
  const Follows({super.key, required this.isFollowing, required this.person});
  final bool isFollowing;
  final Person person;
  @override
  State<Follows> createState() => _FollowsState();
}

class _FollowsState extends State<Follows> {
  bool _isFollowing = true;

  @override
  void initState() {
    super.initState();
    _isFollowing = widget.isFollowing;
  }

  void followPress() {
    setState(() {
      if (_isFollowing) {
        _isFollowing = false;
        MainApp.of(context).myFollower.forEach((element) {
          if (element.userName == widget.person.userName) {
            MainApp.of(context).myFollower.remove(element);
          }
        });
      } else {
        _isFollowing = true;
        MainApp.of(context).myFollower.add(widget.person);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/profile/false/false',
            extra: [widget.person, followersList]);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.person.pfpPath,
                      height: 40,
                      width: 40,
                    )),
                const SizedBox(width: 8),
                SizedBox(
                    width: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.person.name,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: 'Manrope',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.10,
                            )),
                        Text(
                          widget.person.userName,
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.10,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            _isFollowing
                ? TextButton(
                    onPressed: followPress,
                    child: const Text(
                      "Unfollow",
                    ))
                : SizedBox(
                    height: 36,
                    child: FilledButton.tonal(
                        onPressed: followPress, child: const Text("Follow")))
          ],
        ),
      ),
    );
  }
}
