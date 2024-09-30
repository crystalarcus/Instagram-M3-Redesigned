import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redesigned/Components/Utils/animations.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/Components/Utils/open_container.dart'
    as container_transform;
import 'package:redesigned/Components/disappearing_bottom_navigation_bar.dart';
import 'package:redesigned/Components/disappearing_navigation_rail.dart';
import 'package:redesigned/follow_screen.dart';
import 'package:redesigned/new_chat_screen.dart';
import 'package:redesigned/notification_screen.dart';
import 'package:redesigned/profile_screen.dart';
import 'package:redesigned/message_screen.dart';
import 'package:redesigned/settings_screen.dart';
import 'package:redesigned/stories_screen.dart';
import 'package:redesigned/story_view_screen.dart';
import 'home_screen.dart';
// import 'package:permission_handler/permission_handler.dart';

final _router = GoRouter(routes: [
  ShellRoute(
      pageBuilder: (context, state, child) =>
          NoTransitionPage(child: RootScreen(child: child)),
      routes: [
        GoRoute(
            path: '/',
            pageBuilder: (context, state) => SlideBottomTransitionPage(
                child: const HomeScreen(), state: state)),
        GoRoute(
            path: '/notification',
            pageBuilder: (context, state) {
              return SlideBottomTransitionPage(
                  child: const NotificationScreen(), state: state);
            }),
        GoRoute(
            path: '/messages',
            pageBuilder: (context, state) => SlideBottomTransitionPage(
                child: const MessageScreen(), state: state)),
        GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => SlideBottomTransitionPage(
                child: const SettingsScreen(), state: state)),
      ]),
  // GoRoute(
  //     path: '/reels',
  //     pageBuilder: (context, state) {
  //       return SlideBottomTransitionPage(
  //           child: const ReelsScreen(), state: state);
  //     }),

  GoRoute(
      path: '/stories',
      pageBuilder: ((context, state) =>
          SlideTransitionPage(state: state, child: const StoriesScreen()))),
  GoRoute(
      path: '/profile/:new',
      pageBuilder: ((context, state) {
        var extra = state.extra as Account;
        bool newstory = state.pathParameters['new'] == 'true';
        return SlideTransitionPage(
            state: state,
            child: ProfileScreen(
              acc: extra,
              newStories: newstory,
            ));
      })),
  GoRoute(
      path: '/follow/:name',
      pageBuilder: ((context, state) {
        // var extra = state.extra as List;
        // Person person = extra[0] as Person;
        // List<FollowPerson> followers = extra[1] as List<FollowPerson>? ?? [];
        String name = state.pathParameters['name'] ?? '';
        return SlideTransitionPage(
            state: state, child: FollowScreen(name: name));
      })),
  GoRoute(
      path: '/storyview',
      pageBuilder: ((context, state) {
        var storyGroup = state.extra as StoryGroup;
        // String name = state.pathParameters['name'] ?? '';
        return SlideTransitionPage(
            state: state, child: StoryView(story: storyGroup));
      })),
]);

void main() {
  // requestPermissions();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
  // ignore: library_private_types_in_public_api
  static _MainAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>()!;
}

class _MainAppState extends State<MainApp> {
  ThemeMode themeMode = ThemeMode.system;
  void changeTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  Color seedColor = const Color.fromARGB(255, 111, 82, 138);
  bool isDark() {
    if (themeMode == ThemeMode.dark) {
      return true;
    }
    if (themeMode == ThemeMode.system &&
        SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.dark) {
      return true;
    }
    return false;
  }

  bool isSearchFloating = true;
  List<Person> myFollower = myFollowersConst;
  List<Person> myFriends = myFollowersConst.sublist(1, 5);

  bool isFollowing(Person p) {
    for (var element in myFollower) {
      if (element.userName == p.userName) {
        return true;
      }
    }
    return false;
  }

  bool isUserNameFollowing(String userName) {
    for (var element in myFollower) {
      if (element.userName == userName) {
        return true;
      }
    }
    return false;
  }

  bool isFriend(Person p) {
    for (var element in myFriends) {
      if (element.userName == p.userName) {
        return true;
      }
    }
    return false;
  }

  TextTheme textTheme = const TextTheme(
      // bodySmall: TextStyle(fontWeight: FontWeight.w500),
      // bodyMedium: TextStyle(fontWeight: FontWeight.w500),
      // bodyLarge: TextStyle(fontWeight: FontWeight.w500),
      // labelSmall: TextStyle(fontWeight: FontWeight.w500),
      // labelMedium: TextStyle(fontWeight: FontWeight.w500),
      // labelLarge: TextStyle(fontWeight: FontWeight.w500),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData.from(
        textTheme: GoogleFonts.manropeTextTheme(textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: seedColor),
      ),
      darkTheme: ThemeData.from(
          textTheme: GoogleFonts.manropeTextTheme(textTheme),
          colorScheme: ColorScheme.fromSeed(
              seedColor: seedColor, brightness: Brightness.dark)),
      themeMode: themeMode,
      debugShowCheckedModeBanner: false,
    );
  }
}

class RootScreen extends StatefulWidget {
  final Widget child;
  const RootScreen({super.key, required this.child});
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late final _barAnimation = BarAnimation(parent: _controller);
  late final _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1250),
      value: 0,
      vsync: this);
  late final _railAnimation = RailAnimation(parent: _controller);
  late final _railFabAnimation = RailFabAnimation(parent: _controller);

  int selectedIndex = 0;
  bool controllerInitialized = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      // systemNavigationBarIconBrightness: MainApp.of(context).themeMode ==
      //             ThemeMode.dark ||
      //         (MainApp.of(context).themeMode == ThemeMode.dark &&
      //             MediaQuery.platformBrightnessOf(context) == Brightness.dark)
      //     ? Brightness.light
      //     : Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = _controller.status;
    if (width > 600) {
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        _controller.forward();
      }
    } else {
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        _controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      _controller.value = width > 600 ? 1 : 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget homeScreenFAB() => FloatingActionButton(
        heroTag: 'homeFab',
        onPressed: () {
          showModalBottomSheet(
              showDragHandle: true,
              useRootNavigator: true,
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                    child: SizedBox(
                        height: 125,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton.filledTonal(
                                    onPressed: () {},
                                    padding: const EdgeInsets.all(16),
                                    icon: const Icon(Icons.add_box_outlined),
                                    iconSize: 36,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Post",
                                    style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton.filledTonal(
                                    onPressed: () {},
                                    padding: const EdgeInsets.all(16),
                                    icon: const Icon(
                                        Icons.movie_creation_outlined),
                                    iconSize: 36,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Reel",
                                    style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton.filledTonal(
                                    onPressed: () {},
                                    padding: const EdgeInsets.all(16),
                                    icon: const Icon(
                                        Icons.cast_connected_outlined),
                                    iconSize: 36,
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    "Live",
                                    style: GoogleFonts.manrope(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ])));
              });
        },
        child: const Icon(Icons.add),
      );

  Widget messageFAB() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "fab2",
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            onPressed: () {},
            child: Icon(
              Icons.videocam_outlined,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          container_transform.OpenContainer(
              transitionType:
                  container_transform.ContainerTransitionType.fadeThrough,
              transitionDuration: Durations.medium4,
              reverseTransitionDuration: Durations.short4,
              openColor: Theme.of(context).colorScheme.surface,
              middleColor: Theme.of(context).colorScheme.primaryContainer,
              closedColor: Theme.of(context).colorScheme.primaryContainer,
              openElevation: 0,
              clipBehavior: Clip.none,
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28)),
              closedElevation: 0,
              closedBuilder: (context, openContainer) =>
                  FloatingActionButton.extended(
                      heroTag: 'myfab',
                      onPressed: () {
                        openContainer();
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text("Chat")),
              openBuilder: (context, controller) => const NewChatScreen())
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MediaQuery.sizeOf(context).width > 600
          ? null
          : AnimatedSwitcher(
              switchInCurve: Easing.emphasizedDecelerate,
              switchOutCurve: Easing.emphasizedAccelerate,
              duration: Durations.medium3,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  alignment: Alignment.bottomRight,
                  scale: animation,
                  child: child,
                ),
              ),
              layoutBuilder: (currentChild, previousChildren) => Stack(
                alignment: Alignment.bottomRight,
                children: [currentChild!, ...previousChildren],
              ),
              child: currentIndex == 0
                  ? homeScreenFAB()
                  : currentIndex == 2
                      ? messageFAB()
                      : const SizedBox(),
            ),
      bottomNavigationBar: DisappearingBottomNavigationBar(
        barAnimation: _barAnimation,
        selectedIndex: currentIndex,
        onDestinationSelected: (int index) {
          if (currentIndex != index) {
            switch (index) {
              case 0:
                context.go('/');
                break;
              case 1:
                context.go('/stories');
              case 2:
                context.go('/messages');
                break;
              case 3:
                context.go('/notification');
                break;
              case 4:
                context.go('/settings');
                break;
            }
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
      body: Row(
        children: [
          DisappearingNavigationRail(
            railAnimation: _railAnimation,
            railFabAnimation: _railFabAnimation,
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) {
              setState(() {
                selectedIndex = index;
                switch (index) {
                  case 0:
                    context.push('/');
                    break;
                  case 1:
                    context.go('/reels');
                  case 2:
                    context.go('/messages');
                    break;
                  case 3:
                    context.go('/notification');
                    break;
                  case 4:
                    context.go('/settings');
                    break;
                  default:
                }
              });
            },
          ),
          Expanded(child: widget.child)
        ],
      ),
    );
  }
}

class SlideTransitionPage extends CustomTransitionPage {
  final GoRouterState state;
  SlideTransitionPage({required super.child, required this.state})
      : super(
            key: state.pageKey,
            transitionDuration: Durations.long1,
            reverseTransitionDuration: Durations.medium2,
            transitionsBuilder:
                ((context, animation, secondaryAnimation, child) =>
                    CupertinoPageTransition(
                      primaryRouteAnimation: animation,
                      secondaryRouteAnimation: secondaryAnimation,
                      linearTransition: false,
                      child: child,
                    )));
}

class SlideBottomTransitionPage extends CustomTransitionPage {
  final GoRouterState state;
  SlideBottomTransitionPage({required super.child, required this.state})
      : super(
          key: state.pageKey,
          transitionDuration: Durations.short2,
          reverseTransitionDuration: Durations.short1,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeThroughTransition(
            secondaryAnimation: secondaryAnimation,
            animation: animation,
            child: child,
          ),
        );
}

List<Person> myFollowersConst = [
  accounts[3].person,
  accounts[4].person,
  accounts[5].person,
  accounts[6].person,
  accounts[7].person,
  accounts[12].person,
  accounts[15].person,
  accounts[19].person,
  accounts[24].person,
];

// Color getsurface {
//   CorePalette p = CorePalette.of(seedColor.value);
//   return Color(p.neutral.get(isDark() ? 6 : 98));
// }

// Color getSurfaceDim() {
//   CorePalette p = CorePalette.of(seedColor.value);
//   return Color(p.neutral.get(isDark() ? 6 : 87));
// }

// Color getSurfaceBright() {
//   CorePalette p = CorePalette.of(seedColor.value);
//   return Color(p.neutral.get(isDark() ? 24 : 98));
// }

// Color getsurfaceContainerLowest {
//   CorePalette p = CorePalette.of(seedColor.value);
//   return Color(p.neutral.get(isDark() ? 4 : 100));
// }

// Color getsurfaceContainerLow {
//   CorePalette p = CorePalette.of(seedColor.value);
//   return Color(p.neutral.get(isDark() ? 10 : 96));
// }

// Color getsurfaceContainer {
//   CorePalette p = CorePalette.of(seedColor.value);
//   return Color(p.neutral.get(isDark() ? 12 : 94));
// }

// Color getsurfaceContainerHigh {
//   CorePalette p = CorePalette.of(seedColor.value);
//   return Color(p.neutral.get(isDark() ? 17 : 92));
// }

// Color getsurfaceContainerHighest {
//   CorePalette p = CorePalette.of(seedColor.value);
//   return Color(p.neutral.get(isDark() ? 22 : 90));
// }
