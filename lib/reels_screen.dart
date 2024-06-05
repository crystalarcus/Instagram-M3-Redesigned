import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ListView(
          children: <Widget>[ReelWidget(reel: reels.first)],
        ),
        SizedBox(
          height: 64,
          child: AppBar(
            leading: IconButton(
                onPressed: () {
                  context.go('/');
                },
                icon: const Icon(Icons.arrow_back)),
            title: const Text("Reels"),
            toolbarHeight: 64,
          ),
        )
      ],
    ));
  }
}

class ReelWidget extends StatefulWidget {
  const ReelWidget({super.key, required this.reel});
  final Reel reel;
  @override
  State<ReelWidget> createState() => _ReelWidgetState();
}

class _ReelWidgetState extends State<ReelWidget> {
  // late final Player player = Player();
  // late final controller = VideoController(player);
  double videoProgress = 0.5;

  @override
  void initState() {
    // player.open(Media(widget.reel.pathToMedia));
    // player.stream.position.listen((event) {
    //   setState(() {
    //     videoProgress = event.inMilliseconds.toDouble();
    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    // player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // SizedBox(
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     child: Video(
        //       controller: controller,
        //       controls: (state) => Row(
        //         children: [
        //           IconButton(
        //               onPressed: () {
        //                 setState(() {
        //                   player.state.playing ? player.pause() : player.play();
        //                 });
        //               },
        //               icon: Icon(player.state.playing
        //                   ? Icons.pause
        //                   : Icons.play_arrow))
        //         ],
        //       ),
        //     )),

        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: CachedNetworkImage(
                              height: 50,
                              width: 50,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              placeholderFadeInDuration: Durations.short1,
                              placeholder: (context, url) => Icon(
                                  Icons.account_circle_rounded,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                              fit: BoxFit.contain,
                              imageUrl: widget.reel.person.pfpPath,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                widget.reel.person.name,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                widget.reel.person.userName,
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          )
                        ],
                      )),
                  const SizedBox(height: 16),
                  // LinearProgressIndicator(
                  //   value: player.state.playing
                  //       ? videoProgress /
                  //           player.state.duration.inMilliseconds.toDouble()
                  //       : 0,
                  // )
                ],
              ),
            )),
      ],
    );
  }
}
