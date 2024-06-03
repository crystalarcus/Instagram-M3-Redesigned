import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:redesigned/Components/Utils/classes.dart';
import 'package:redesigned/Components/Utils/data.dart';

class CommentSheet extends StatelessWidget {
  const CommentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        builder: (BuildContext context) => FractionallySizedBox(
            heightFactor: 0.9,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Row(children: [
                SizedBox(
                  width: 16,
                ),
                Text("Comments", style: TextStyle(fontSize: 18))
              ]),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemCount: comments[0].length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    Comment comment = comments[0][index];
                    return CommentWidget(
                      comment: Comment(
                        person: comment.person,
                        text: comment.text,
                        dateTime: comment.dateTime,
                        likes: comment.likes,
                        // replies: [
                        //   Reply(
                        //       to: 'yaemiko',
                        //       person: accounts[13].person,
                        //       text: "Yess Lady Guji",
                        //       dateTime: DateTime(2024, 2, 24, 3, 24, 22)),
                        // ]
                      ),
                    );
                  },
                ),
              ),
              Container(
                color: Theme.of(context).colorScheme.surfaceContainerHigh,
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'images/prof.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 18),
                        hintText: "Add a comment...",
                      ),
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Symbols.send,
                          size: 24,
                          weight: 600,
                        ))
                  ],
                ),
              )
            ])));
  }
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key, required this.comment});
  final Comment comment;
  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    widget.comment.person.pfpPath,
                    height: 45,
                    width: 45,
                  ),
                )),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.comment.person.name,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Text("${widget.comment.dateTime} min"),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            maxLines: 50,
                            overflow: TextOverflow.clip,
                            widget.comment.text,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      )),

                      // const Spacer(),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton.icon(
                          style: ButtonStyle(
                              iconColor: WidgetStatePropertyAll(
                            widget.comment.isLiked
                                ? Colors.red
                                : Theme.of(context).colorScheme.onSurface,
                          )),
                          label: Text(
                            widget.comment.likes.toString(),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface),
                          ),
                          onPressed: () {
                            setState(() {
                              if (widget.comment.isLiked) {
                                widget.comment.isLiked = false;
                                widget.comment.likes -= 1;
                                return;
                              }
                              widget.comment.isLiked = true;
                              widget.comment.likes += 1;
                            });
                          },
                          icon: Icon(widget.comment.isLiked
                              ? Icons.favorite
                              : Icons.favorite_outline)),
                      const SizedBox(width: 8),
                      TextButton.icon(
                          style: ButtonStyle(
                              iconColor: WidgetStatePropertyAll(
                            Theme.of(context).colorScheme.onSurface,
                          )),
                          label: Text(widget.comment.replies.length.toString(),
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface)),
                          onPressed: () {},
                          icon: Icon(
                            MdiIcons.replyOutline,
                            size: 24,
                          )),
                      const Spacer(),
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.expand_more))
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
