import 'dart:core';

import 'package:redesigned/Components/Utils/data.dart';

enum PostType { carosel, image, reel }

class Post {
  final Person person;
  final PostType type;
  final DateTime dateTime;
  final int postId;
  final String coverImagePath;
  final double aspectRatio;
  String subTitle;
  int likes;
  bool isLiked;
  bool saved;
  List comments;
  List<String> tags;
  Post({
    required this.person,
    required this.type,
    required this.dateTime,
    required this.postId,
    required this.aspectRatio,
    required this.subTitle,
    required this.coverImagePath,
    this.likes = 0,
    this.isLiked = false,
    this.saved = false,
    this.comments = const [],
    this.tags = const [],
  });
}

class CarouselPostObject extends Post {
  CarouselPostObject({
    required super.person,
    required super.type,
    required super.dateTime,
    required super.postId,
    required super.subTitle,
    required this.imagePaths,
    super.likes = 0,
    super.isLiked = false,
    super.saved = false,
    super.comments = const [],
    required super.aspectRatio,
    super.tags,
  }) : super(coverImagePath: imagePaths[0]);
  List<String> imagePaths;
}

class ImagePostObject extends Post {
  ImagePostObject(
      {required super.person,
      required super.type,
      required super.dateTime,
      required super.postId,
      required super.subTitle,
      required this.imagePath,
      super.likes = 0,
      super.isLiked = false,
      super.saved = false,
      required super.aspectRatio,
      super.comments = const [],
      super.tags})
      : super(coverImagePath: imagePath);
  String imagePath;
}

class ReelPostObject extends Post {
  ReelPostObject(
      {required super.person,
      required super.type,
      required super.dateTime,
      required super.postId,
      required super.subTitle,
      required this.sourcePath,
      super.likes = 0,
      super.isLiked = false,
      super.saved = false,
      required super.aspectRatio,
      super.comments = const [],
      super.tags})
      : super(coverImagePath: sourcePath);
  String sourcePath;
}

//1xqwEhw6qg-Vq9zvHGlt87_GRWqQprg-s
class Person {
  final String name;
  final String userName;
  final String pfpPath;
  final bool isStoryVisible;
  final bool newStory;
  Person(
      {required this.name,
      required this.userName,
      required this.pfpPath,
      this.isStoryVisible = false,
      this.newStory = false});
}

class Comment {
  final Person person;
  final String text;
  final String dateTime;
  int likes;
  List<CommentReply> replies;
  bool isLiked;

  Comment({
    required this.person,
    required this.text,
    required this.dateTime,
    this.likes = 0,
    this.isLiked = false,
    this.replies = const [],
  });
}

class CommentReply {
  CommentReply({
    required this.person,
    required this.text,
    required this.dateTime,
    required this.replyTo,
    this.isLiked = false,
    this.likes = 0,
  });
  final Person person;
  final DateTime dateTime;
  final String text;
  final String replyTo;
  bool isLiked;
  int likes;
}

class Reply {
  String to;
  Person person;
  String text;
  DateTime dateTime;
  Reply({
    required this.to,
    required this.person,
    required this.text,
    required this.dateTime,
  });
}

class FollowPerson extends Person {
  FollowPerson(
      {required super.name,
      required super.userName,
      required super.pfpPath,
      required this.isFollowing});
  bool isFollowing;
}

List<FollowPerson> followersList = [
  FollowPerson(
      name: accounts[12].person.name,
      userName: accounts[12].person.userName,
      pfpPath: accounts[12].person.pfpPath,
      isFollowing: true),
  FollowPerson(
      name: accounts[14].person.name,
      userName: accounts[14].person.userName,
      pfpPath: accounts[14].person.pfpPath,
      isFollowing: true),
  FollowPerson(
      name: accounts[15].person.name,
      userName: accounts[15].person.userName,
      pfpPath: accounts[15].person.pfpPath,
      isFollowing: false),
  FollowPerson(
      name: accounts[16].person.name,
      userName: accounts[16].person.userName,
      pfpPath: accounts[16].person.pfpPath,
      isFollowing: true),
  FollowPerson(
      name: accounts[4].person.name,
      userName: accounts[4].person.userName,
      pfpPath: accounts[4].person.pfpPath,
      isFollowing: true),
  FollowPerson(
      name: accounts[6].person.name,
      userName: accounts[6].person.userName,
      pfpPath: accounts[6].person.pfpPath,
      isFollowing: true),
  FollowPerson(
      name: accounts[19].person.name,
      userName: accounts[19].person.userName,
      pfpPath: accounts[19].person.pfpPath,
      isFollowing: false),
  FollowPerson(
      name: accounts[11].person.name,
      userName: accounts[11].person.userName,
      pfpPath: accounts[11].person.pfpPath,
      isFollowing: false),
  FollowPerson(
      name: accounts[23].person.name,
      userName: accounts[23].person.userName,
      pfpPath: accounts[23].person.pfpPath,
      isFollowing: false),
];

enum NotifType {
  commentLike,
  commentReply,
  postLike,
  postComment,
  storyLike,
  follow,
}

class Notif {
  final NotifType notifType;
  final Person notifier;
  final String time;
  final String textContent;
  final String contextImagePath;
  const Notif(
      {required this.notifType,
      required this.notifier,
      required this.time,
      required this.textContent,
      required this.contextImagePath});
}

class CommentReplyNotficaiton extends Notif {
  CommentReplyNotficaiton(
      {required super.notifier,
      required super.time,
      required this.reply,
      required this.postID,
      required this.commentText,
      required this.isLiked})
      : super(
            notifType: NotifType.commentReply,
            textContent: "Replied to your comment",
            contextImagePath: getPostFromPostID(postID).coverImagePath);
  final String commentText;
  final String reply;
  final bool isLiked;
  final int postID;
}

class CommentLikeNotficaiton extends Notif {
  CommentLikeNotficaiton({
    required super.notifier,
    required super.time,
    required this.postID,
    required this.commentText,
  }) : super(
            notifType: NotifType.commentLike,
            textContent: "liked your comment",
            contextImagePath: getPostFromPostID(postID).coverImagePath);
  String text = "";
  final String commentText;
  final int postID;
}

class PostCommentNotficaiton extends Notif {
  PostCommentNotficaiton(
      {required super.notifier,
      required super.time,
      required this.reply,
      required this.postID,
      required this.isLiked})
      : super(
            notifType: NotifType.commentReply,
            textContent: "commented on your post",
            contextImagePath: getPostFromPostID(postID).coverImagePath);
  String text = "";
  final String reply;
  final bool isLiked;
  final int postID;
}

class PostLikeNotification extends Notif {
  PostLikeNotification({
    required super.notifier,
    required super.time,
    required this.postID,
  }) : super(
            notifType: NotifType.postLike,
            textContent: "Liked your Post",
            contextImagePath: getPostFromPostID(postID).coverImagePath);
  final int postID;
}

class FollowNotification extends Notif {
  FollowNotification({
    required super.notifier,
    required super.time,
  }) : super(
            notifType: NotifType.follow,
            textContent: "Who you might know is on Instagram",
            contextImagePath: myStories[0].pathToMedia);
}

class StoryLikeNotification extends Notif {
  final int storyNum;
  StoryLikeNotification({
    required super.notifier,
    required super.time,
    required this.storyNum,
  }) : super(
            notifType: NotifType.postLike,
            textContent: "Liked your story",
            contextImagePath: myStories[storyNum].pathToMedia);
}

enum StoryType {
  image,
  reel,
}

class Story {
  Story(
      {required this.duration,
      required this.pathToMedia,
      required this.type,
      required this.uploadTime,
      this.isLiked = false,
      this.isViewd = false});
  Duration duration;
  bool isLiked;
  bool isViewd;
  String pathToMedia;
  StoryType type;
  String uploadTime;
}

class StoryGroup {
  Person person;
  List<Story> stories;
  StoryGroup({required this.person, required this.stories});
}

List<Post> posts = <Post>[
  CarouselPostObject(
    postId: 001,
    person: accounts[8].person,
    subTitle: "Lost in the intricate details of this architectural masterpiece",
    aspectRatio: 1 / 1,
    imagePaths: [
      "1swN0I0kJVE-YogucSzCcObVkdQ-ORnh2",
      "10wPKtmDBC8ylKcqWplQ3LOtreucDkxAN",
      "1m6RJ8X1uYkidux5XkDixn1jFRu8IXqTH",
    ],
    tags: [],
    type: PostType.carosel,
    dateTime: DateTime(2024, 3, 24, 4, 25, 34),
  ),
  ReelPostObject(
    aspectRatio: 5 / 4,
    postId: 002,
    person: accounts[22].person,
    subTitle: "Beautiful cloud mountain scenery",
    sourcePath: "1n6UUe6Yk1ZTB5DKP55lP6CNZia7_r7KE",
    type: PostType.reel,
    dateTime: DateTime(2024, 3, 16, 5, 24, 54),
  ),
  ImagePostObject(
    postId: 003,
    aspectRatio: 1,
    person: accounts[9].person,
    subTitle: "A Night view through my window",
    imagePath: "1JpcQdKOF3N2MJe00fSvvjSxAvhdbLAo4",
    type: PostType.image,
    tags: ["furina_sunshine", "furina", "hydro archon"],
    dateTime: DateTime(2024, 3, 14, 6, 24, 14),
  ),
  CarouselPostObject(
    type: PostType.carosel,
    aspectRatio: 3 / 2.5,
    person: accounts[19].person,
    imagePaths: [
      "1uVVJIsFQT-qz23Nph1rzZt_a7qwDQqI9",
      "1VFPF46ib6BmpNb18t5ovY4swmk_wuwq9",
      "1O5rHhl8yg5XhPWdhddAu1Bw2VRyrWH43",
    ],
    dateTime: DateTime(2024, 2, 23, 3, 43, 21),
    postId: 004,
    subTitle: "Today's dish, mouth watering fried rice.",
    tags: [
      "#food",
      "#yummy",
      "#delicious",
      "#homecooking",
      "#foodlover",
      "#foodgasm",
      "#chef",
      "#cooking",
      "#recipe",
      "#healthyfood",
      "#homemade",
      "#foodblog",
      "#dinner",
      "#lunch",
      "#breakfast",
      "#vegetarian",
      "#vegan",
    ],
  ),
  ImagePostObject(
    postId: 005,
    person: accounts[10].person,
    subTitle:
        "A wonderful scenery of hot air balloon . I wish I could visit there someday.",
    imagePath: "1VyZJ9yYhXcw-wCxsItBulgl3ARzTjALo",
    aspectRatio: 4 / 5,
    type: PostType.image,
    tags: [
      "#rip",
      "#gonebutnotforgotten",
      "#foreverinourhearts",
      "#flyhigh",
      "#inlovingmemory",
      "#restinpeace",
      "#celebratinglife",
      "#funeral",
      "#service",
      "#memorial",
    ],
    dateTime: DateTime(2024, 3, 16, 5, 24, 54),
  ),
  ImagePostObject(
    aspectRatio: 0.9375,
    postId: 006,
    person: accounts[27].person,
    subTitle:
        "Ready to dive in?  Immerse yourself in breathtaking VR worlds. Explore our VR offers.",
    imagePath: "1HURvDDRB2QxF7z2vFnLQ6KnFxDI4Xryn",
    type: PostType.image,
    dateTime: DateTime(2024, 3, 16, 5, 24, 54),
  ),
];

Post getPostFromPostID(int id) {
  for (var element in posts) {
    if (element.postId == id) {
      return element;
    }
  }
  throw ();
}

class Account {
  Account(
      {required this.person,
      this.bio = "",
      this.isPrivate = true,
      this.pronouns = '',
      this.followers = const [],
      this.following = const [],
      this.posts = const []});

  final Person person;
  final List<Post> posts;

  bool isPrivate;
  String bio;
  String pronouns;
  List<String> followers;
  List<String> following;
}

enum LastMessageState {
  sentByUserAndSeen,
  sentByUserAndUnseen,
  sentByOtherandSeen,
  sentByOtherAndUnseen
}

class Chat {
  Chat({
    required this.person,
    required this.newMessage,
    required this.lastMessage,
    required this.lastTime,
    this.lastMessageState = LastMessageState.sentByOtherandSeen,
    this.isActive = false,
  });
  Person person;
  int newMessage;
  String lastMessage;
  String lastTime;
  bool isActive;
  LastMessageState lastMessageState;
}

class Note {
  Note({required this.person, required this.note});
  Person person;
  String note;
}

class ChatText {
  ChatText({
    required this.text,
    required this.time,
    required this.textid,
    this.reactions = const [],
    this.repliedTo,
    this.sentByUser = false,
  });
  final String text;
  final String time;
  final dynamic repliedTo;
  final int textid;
  List<String> reactions;
  bool sentByUser;
}

class Reel {
  Reel({
    required this.person,
    required this.title,
    required this.description,
    required this.pathToMedia,
    this.audio,
    required this.postId,
    required this.likes,
    required this.playCount,
    this.comments = const [],
  });
  final Person person;
  final String title;
  final String description;
  final String pathToMedia;
  final AudioSource? audio;
  final int postId;

  // Public Data
  int likes;
  int playCount;
  List<Comment> comments;
}

class AudioSource {
  AudioSource({
    required this.accountUserName,
    required this.pathToAudio,
    required this.title,
  });
  String pathToAudio;
  String accountUserName;
  String title;
}
