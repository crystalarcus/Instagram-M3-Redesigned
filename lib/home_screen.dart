import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';
import 'package:redesigned/Components/Utils/open_container.dart';
import 'package:redesigned/Components/posts.dart';
import 'package:redesigned/main.dart';
import 'package:redesigned/search_insta_screen.dart';
import 'package:redesigned/stories_screen.dart';
import 'package:side_sheet/side_sheet.dart';
import 'Components/story_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: ((context, constraints) => constraints.maxWidth > 650
            ? const DesktopHomeScreen()
            : MobileHomeScreen(
                constraints: constraints,
              )));
  }
}

// ignore: must_be_immutable
class MobileHomeScreen extends StatefulWidget {
  MobileHomeScreen({super.key, required this.constraints});
  BoxConstraints constraints;
  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        body: SafeArea(
          child: CustomScrollView(slivers: [
            SliverAppBar(
                toolbarHeight: 63,
                forceMaterialTransparency: true,
                floating: MainApp.of(context).isSearchFloating,
                title: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                      height: 55,
                      child: OpenContainer(
                        closedElevation: 0,
                        closedColor:
                            Theme.of(context).colorScheme.surfaceContainer,
                        openColor:
                            Theme.of(context).colorScheme.surfaceContainerLow,
                        closedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(55)),
                        useRootNavigator: true,
                        closedBuilder: (context, action) => SearchBar(
                          elevation: const WidgetStatePropertyAll(0),
                          shadowColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          backgroundColor: WidgetStatePropertyAll(
                              Theme.of(context)
                                  .colorScheme
                                  .surfaceContainerHighest),
                          padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 16)),
                          leading: const Icon(
                            Symbols.search,
                            opticalSize: 24,
                            weight: 400,
                          ),
                          trailing: <Widget>[
                            Tooltip(
                              message: 'Change brightness mode',
                              child: IconButton(
                                icon: const Icon(Icons.mic_none_outlined),
                                onPressed: () {},
                                selectedIcon:
                                    const Icon(Icons.brightness_2_outlined),
                              ),
                            ),
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: CachedNetworkImage(
                                  height: 36,
                                  width: 36,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  placeholderFadeInDuration:
                                      const Duration(seconds: 0),
                                  placeholder: (context, url) => Icon(
                                      Icons.account_circle_rounded,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant),
                                  fit: BoxFit.contain,
                                  imageUrl: linkToPfp),
                            )
                          ],
                          hintStyle: WidgetStatePropertyAll(TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                              fontSize: 16,
                              letterSpacing: 0.5,
                              fontWeight: FontWeight.w500)),
                          hintText: "Search Instagram",
                          textStyle: const WidgetStatePropertyAll(
                              TextStyle(height: 1.2)),
                          onTap: () => {action()},
                        ),
                        openBuilder: (context, action) =>
                            const SearchInstaScreen(),
                      )),
                )),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Stories",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 40),
                            TextButton(
                                onPressed: () {
                                  context.push("/stories");
                                },
                                child: const Text("See all"))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                            height: 100,
                            child: OverflowBox(
                                maxWidth: widget.constraints.maxWidth,
                                alignment: Alignment.topLeft,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Column(
                                      children: <Widget>[
                                        InkWell(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            onTap: () {},
                                            child: Container(
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  border: Border.all(
                                                      width: 2.8,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: CachedNetworkImage(
                                                    height: 60,
                                                    width: 60,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                    placeholderFadeInDuration:
                                                        const Duration(
                                                            seconds: 0),
                                                    placeholder:
                                                        (context, url) => Icon(
                                                            Icons
                                                                .account_circle_rounded,
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .onSurfaceVariant),
                                                    fit: BoxFit.contain,
                                                    imageUrl: linkToPfp),
                                              ),
                                            )),
                                        const Text("Your Story")
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    StoryWidget(person: accounts[9].person),
                                    const SizedBox(width: 20),
                                    StoryWidget(person: accounts[19].person),
                                    const SizedBox(width: 20),
                                    StoryWidget(person: accounts[18].person),
                                    const SizedBox(width: 20),
                                    StoryWidget(person: accounts[5].person),
                                    // const StoryWidget(pfpPath: "images/hutao.png"),
                                  ],
                                ))),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const Row(children: [
                        SizedBox(width: 12),
                        Text("Explore Posts",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ]),
                      const SizedBox(height: 12),
                      ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: posts.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Post p = posts[index];
                            return MobilePost(post: p);
                          }
                          // posts
                          //     .map((e) => e.type == PostType.carosel
                          //         ? CarouselPost(post: e as CarouselPostObject)
                          //         : ImagePost(postObject: e as ImagePostObject))
                          //     .toList() ,
                          ),
                    ],
                  )
                ],
              ),
            )
          ]),
        ));
  }
}

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({super.key});

  @override
  State<DesktopHomeScreen> createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> {
  Set<Filters> filters = <Filters>{};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Expanded(
                  child: SearchBar(
                shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                leading: IconButton(
                  onPressed: null,
                  icon: const Icon(
                    Symbols.search,
                    weight: 600,
                  ),
                  disabledColor: Theme.of(context).colorScheme.onSurface,
                ),
                trailing: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.mic_none_outlined))
                ],
                hintText: "Search Instagram",
                onTap: () {},
              )),
              Expanded(
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                SizedBox(
                    height: 40,
                    child: FilledButton.tonalIcon(
                        onPressed: () {},
                        icon: const Icon(Icons.sync_alt_outlined),
                        label: const Text("Switch"))),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                      height: 64,
                      width: 64,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      placeholderFadeInDuration: const Duration(seconds: 0),
                      placeholder: (context, url) => Icon(
                          Icons.account_circle_rounded,
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                      fit: BoxFit.contain,
                      imageUrl: linkToPfp),
                )
              ]))
            ]),
            const SizedBox(height: 12),
            Expanded(
                child: LayoutBuilder(
                    builder: (context, constarintss) => Row(
                          children: [
                            Expanded(
                                child: Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 18, 16, 0),
                                    decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: ListView.separated(
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 8),
                                        itemCount: posts.length,
                                        itemBuilder: ((context, index) =>
                                            index == 0
                                                ? Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text("Explore",
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          constarintss.maxWidth <
                                                                  1000
                                                              ? SizedBox(
                                                                  height: 40,
                                                                  child: TextButton.icon(
                                                                      onPressed: () => SideSheet.right(
                                                                          width:
                                                                              400,
                                                                          sheetBorderRadius:
                                                                              14,
                                                                          context:
                                                                              context,
                                                                          body: storiesSheet(
                                                                              context)),
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .chevron_left),
                                                                      label: const Text(
                                                                          "Stories")))
                                                              : const SizedBox()
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 14),
                                                      Wrap(
                                                          spacing: 8,
                                                          children: Filters
                                                              .values
                                                              .map((e) =>
                                                                  FilterChip(
                                                                      color: const WidgetStatePropertyAll(
                                                                          Colors
                                                                              .transparent),
                                                                      shape: RoundedRectangleBorder(
                                                                          side: BorderSide(
                                                                              color: Theme.of(context)
                                                                                  .colorScheme
                                                                                  .outlineVariant),
                                                                          borderRadius: BorderRadius.circular(
                                                                              20)),
                                                                      label: Text(e
                                                                          .name),
                                                                      selected:
                                                                          filters
                                                                              .contains(e),
                                                                      onSelected: (selected) {
                                                                        setState(
                                                                            () {
                                                                          selected
                                                                              ? filters.add(e)
                                                                              : filters.remove(e);
                                                                        });
                                                                      }))
                                                              .toList()),
                                                      const SizedBox(
                                                          height: 22),
                                                    ],
                                                  )
                                                : DesktopPost(
                                                    post: posts[index]))))),
                            const SizedBox(width: 12),
                            constarintss.maxWidth > 1000
                                ? storiesSheet(context)
                                : const SizedBox()
                          ],
                        )))
          ]),
        ));
  }
}

Widget storiesSheet(context) => SizedBox(
      width: 400,
      child: Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  bottomLeft: Radius.circular(13))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Stories",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                        height: 64,
                        width: 64,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        placeholderFadeInDuration: const Duration(seconds: 0),
                        placeholder: (context, url) => Icon(
                            Icons.account_circle_rounded,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                        fit: BoxFit.contain,
                        imageUrl: linkToPfp),
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Crystal",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      Text("crystal_arucs",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                      height: 40,
                      child: FilledButton.tonalIcon(
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                          label: const Text("Add")))
                ]),
              ),
              const SizedBox(height: 18),
              const Divider(),
              const SizedBox(height: 18),
              Expanded(
                  child: ListView(
                children: li
                    .map((e) => StoryTile(
                        person:
                            Person(name: e[1], userName: e[0], pfpPath: e[2]),
                        notifNum: e[3]))
                    .toList(),
              ))
            ],
          )),
    );

// ignore: constant_identifier_names
enum Filters { Popular, Arts, Music, Funny, Cats, Cooking, Memes }

List li = [
  ["furina.sunshine", "Furina de Fontaine", "images/furina.png", 4],
  ["cook.with.shogun", "Raiden Shogun", "images/raiden.png", 0],
  ["please_die_soon", "Director Hu", "images/hutao.png", 2],
  ["guji_yae", "Yae Miko", "images/yaemiko.png", 0],
  ["alcohol.is.not.for.kidz", "Whos This Guy", "images/venti.png", 3],
  ["i_love_boba", "Kamisato Ayato", "images/ayato.png", 1],
  ["the.bull.chucker", "Arataki Itto", "images/itto.png", 0],
  ["not.a.child", "Tartaglia", "images/childe.png", 0],
];
