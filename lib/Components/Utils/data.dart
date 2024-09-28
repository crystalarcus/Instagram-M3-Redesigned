import 'package:redesigned/Components/Utils/classes.dart';

List<List<Comment>> comments = [
  [
    Comment(
        person: accounts[25].person,
        text: "For Inazuma’s sake, someone please stop her",
        dateTime: "8 min",
        replies: <CommentReply>[
          CommentReply(
              replyTo: accounts[25].person.userName,
              person: accounts[21].person,
              text: "Ysss",
              dateTime: DateTime(2024, 3, 4, 12, 24, 4)),
          CommentReply(
              replyTo: accounts[25].person.userName,
              person: accounts[12].person,
              text: "Mayb yess",
              dateTime: DateTime(2024, 3, 4, 12, 24, 4)),
          CommentReply(
              replyTo: accounts[25].person.userName,
              person: accounts[15].person,
              text: "This can be a serious thing if you think logically about it.",
              dateTime: DateTime(2024, 3, 4, 12, 24, 4)),
          CommentReply(
              replyTo: accounts[25].person.userName,
              person: accounts[16].person,
              text: "Lmaooo 😭",
              dateTime: DateTime(2024, 3, 4, 12, 24, 4)),
          CommentReply(
              replyTo: accounts[25].person.userName,
              person: accounts[18].person,
              text: "Agreed",
              dateTime: DateTime(2024, 3, 4, 12, 24, 4)),
        ]),
    Comment(
        person: accounts[20].person,
        text:
            "All soldiers, alert. Gather all ships and  take people out of Inazuma.",
        dateTime: "18 min"),
    Comment(
        person: accounts[24].person,
        text: "Always ready for free food 🔥",
        dateTime: "26 min"),
    Comment(
        person: accounts[16].person,
        text: "Will I get some beer there ?",
        dateTime: "39 min"),
  ]
];

List<List<Notif>> notifications = [
  [
    StoryLikeNotification(
        notifier: accounts[0].person, time: '5 min', storyNum: 1),
    FollowNotification(notifier: accounts[23].person, time: '2 hr'),
    CommentLikeNotficaiton(
        notifier: accounts[21].person,
        time: '24 min',
        postID: 001,
        commentText: comments[0][1].text),
    StoryLikeNotification(
        notifier: accounts[16].person, time: '12 min', storyNum: 0),
  ],
  [
    CommentReplyNotficaiton(
        notifier: accounts[18].person,
        time: '34 min',
        reply: "Yes, that's what I thought",
        commentText: "Hey, this looks just like the previous post",
        postID: 001,
        isLiked: false),
    StoryLikeNotification(
        notifier: accounts[14].person, time: '16 min', storyNum: 1),
    CommentLikeNotficaiton(
        notifier: accounts[2].person,
        time: '3 min',
        postID: 002,
        commentText: comments[0][0].text),
    StoryLikeNotification(
        notifier: accounts[10].person, time: '46 min', storyNum: 0),
    CommentLikeNotficaiton(
        notifier: accounts[8].person,
        time: '5 hr',
        postID: 001,
        commentText: comments[0][1].text),
    PostLikeNotification(
        notifier: accounts[4].person, time: '9 hr', postID: 002)
  ],
  [
    StoryLikeNotification(
        notifier: accounts[9].person, time: '1 day', storyNum: 1),
    CommentLikeNotficaiton(
        notifier: accounts[0].person,
        time: '1 day',
        postID: 004,
        commentText: comments[0][1].text),
    PostLikeNotification(
        notifier: accounts[6].person, time: '1 day', postID: 002),
    StoryLikeNotification(
        notifier: accounts[12].person, time: '1 day', storyNum: 1),
    CommentLikeNotficaiton(
        notifier: accounts[3].person,
        time: '1 day',
        postID: 003,
        commentText: comments[0][0].text),
  ]
];

List<String> downloadImages = [
  "https://img.freepik.com/free-photo/sunset-savannah_1048-4710.jpg?t=st=1713011145~exp=1713014745~hmac=c6681071fb5d115bd6169c2480887907acedd17e0b76976fe4bfb91a017a5070&w=1060"
];

List<Chat> chats = [
  Chat(
      person: accounts[13].person,
      newMessage: 2,
      lastMessage: "Yup, saw that too !",
      lastTime: "16:23",
      isActive: true),
  Chat(
      person: accounts[24].person,
      newMessage: 3,
      lastMessage: "Wake up sleepy head",
      lastTime: "13:35",
      isActive: true),
  Chat(
      person: accounts[12].person,
      newMessage: 0,
      lastMessage: "Byee!!!",
      lastTime: "10:23"),
  Chat(
      person: accounts[21].person,
      newMessage: 1,
      lastMessage:
          "A human gave me a flower today, do you know what to do with this ?",
      lastTime: "10:04",
      isActive: true),
  Chat(
      person: accounts[17].person,
      newMessage: 3,
      lastMessage: "How do you cook this ?",
      lastTime: "6:24"),
  Chat(
      person: accounts[10].person,
      newMessage: 0,
      lastMessage: "Good Night~",
      lastMessageState: LastMessageState.sentByUserAndSeen,
      lastTime: "1 day"),
  Chat(
      person: accounts[28].person,
      newMessage: 0,
      lastMessage: "I will be leaving now",
      lastTime: "1 day",
      isActive: true),
  Chat(
      person: accounts[9].person,
      newMessage: 0,
      lastMessage: "Alrighty!",
      lastMessageState: LastMessageState.sentByUserAndUnseen,
      lastTime: "2 day"),
  Chat(
      person: accounts[27].person,
      newMessage: 2,
      lastMessageState: LastMessageState.sentByUserAndSeen,
      lastMessage: "Cya Later!",
      lastTime: "2 day"),
];

List<Account> accounts = [
  Account(
      person: Person(
          name: "Aether",
          userName: "i.need.primos",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1t8ON-QsNgAC1ry7OHNzBbG1uLiLIjES2'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Alhaitham",
          userName: "grand_sage",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1Y0QB4V0MeyoRUO0QQZu5qFMhT7ajlxzb'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Ayaka",
          userName: "am_i_ayaya",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1dlzU80M9PEuPhX2qKo1QpvsWyaXIcv-F'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Ayato",
          userName: "kamisato.ayato",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1dlzU80M9PEuPhX2qKo1QpvsWyaXIcv-F'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Bennet",
          userName: "who.threw.that.stone",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1SiEfxr1q--HXdBy8q1ckx7IirlLt3R52'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Childe",
          userName: "not.a.child",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1sp3oMTRkRXPRMXZfaRq6cRt3oNrNvwCt'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Chongyun",
          userName: "conqurer.of.demon.2",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1QD_kj1U4vstuKn1wBCWtzbrtlMYsG-7y'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Eula",
          userName: "dance_with_claymore",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1C5XUQeqY8bvi2DE0KRi7zc_XIW3721C1'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Fischl",
          userName: "princess_purple",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1KSuYNIP2S9luQxptHYzOoKa8URJozIe1'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Furina de Fontaine",
          userName: "furina_sunshine",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1HNDR8qiIArymcwzzThjXPblRf04nnSMn'),
      bio: "Your Friendly Celebrity Archon of Teyvat",
      pronouns: "she/her",
      followers: ['cook.with.shogun', 'please_die_soon', 'princess_purple'],
      following: ['cook.with.shogun'],
      posts: []),
  Account(
      person: Person(
          name: "Director  Hu",
          userName: "please_die_soon",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1CQm-RSOfQxlKrXTOHlj_5JqhsqLsu8rq'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Arataki Itto",
          userName: "the.one.and.oni",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1fuW9MzvqzgKl7Pt90v4eNUpMCRde1aGW'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Kaedehara Kazuha",
          userName: "born_in_canada",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1_ItVD4thjd2pjrthRRwL3zOcRYncTKJV'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Keqing",
          userName: "ke_queen",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=11X_C6Kuddo4oN3NEBl9uyJ_rjEp0UDdN'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Lisa",
          userName: "library_momy",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1ImyUUqXDNoOMAG-CQd6wAmCJpUS4F1nQ'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Lumine",
          userName: "prinzessin_von_abyss",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1WkCovKGcGiTR1IbeJVIb8q4I7jZSdAxl'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Mona Megistus",
          userName: "hat_girl",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1BLZvqwu3Sah4NkisgGo1oMq-HSIpy2qV'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Nahida",
          userName: "all_knowing_kid",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1FjyMwEPYPNPXkOBKMGRApIS9LHwHpGGe'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Navia",
          userName: "boss_girl",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1SrM-csyz5iCWM3rzDGK_OVCJ83I1swN4'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Raiden Shogun",
          userName: "cook.with.shogun",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1nnB-bR3zVtWpgrDfSDEyFM0vi0iVss1S'),
      followers: ['please_die_soon', 'princess_purple', 'furina_sunshine'],
      following: ['furina_sunshine'],
      posts: []),
  Account(
      person: Person(
          name: "Kujou Sara",
          userName: "crow.girl.sara",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1-Kbjq30deI8v3Hb5SZo-7mUGkx-4Te1z'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Shenhe",
          userName: "frozen_momy",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1FTdyeb7AQRE1GPxPCQNQPIw4lCN5p5r6'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Skirk",
          userName: "skir7x",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=15hTDclZREA7NSTgiTEclmSEW3xZNz_YH'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Venti",
          userName: "alkahol.iz.nat.fo.kidz",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1foQW29-ihziU6MMFYY7mc0VxLCYGkT81'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Wanderer",
          userName: "eons_adrift",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1ip4pOCckeEwKwDPxDl-cfA09rWifMwyD'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Xiao",
          userName: "conqurer_of_demons",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1u0z89yW1WxTUutqhQ-8DrcBlC1IAC5tI'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Yae Miko",
          userName: "sussy_fox_lady",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1ECGhGr_tUXRlbPSOM0w8qa_OZ0krp9h7'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Yelan",
          userName: "got.those.arms",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1fTisKjCd5c_VEbSBgyIE0pissAajfVyk'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Zhongli",
          userName: "ceo_of_geo",
          pfpPath:
              'https://drive.google.com/uc?export=view&id=1JVAFXYHJXOTyRwoU9wtTlVOFm1w-I7_P'),
      followers: [],
      following: [],
      posts: []),
];

Person getPersonFromUserName(String userName) {
  for (var element in accounts) {
    if (element.person.userName == userName) {
      return element.person;
    }
  }
  throw (Error());
}

Account getAccountFromUserName(String userName) {
  for (var element in accounts) {
    if (element.person.userName == userName) {
      return element;
    }
  }
  throw (Error());
}

List<Story> myStories = [
  Story(
      duration: const Duration(seconds: 7),
      pathToMedia: '1w35ptuh4ixOJK6tJLbpwArG5xEQ6dS47',
      type: StoryType.image,
      uploadTime: '23 min'),
  Story(
      duration: const Duration(seconds: 7),
      pathToMedia: '10wPKtmDBC8ylKcqWplQ3LOtreucDkxAN',
      type: StoryType.image,
      uploadTime: '23 min'),
  Story(
      duration: const Duration(seconds: 7),
      pathToMedia: '1swN0I0kJVE-YogucSzCcObVkdQ-ORnh2',
      type: StoryType.image,
      uploadTime: '23 min'),
  Story(
      duration: const Duration(seconds: 7),
      pathToMedia: '1JpcQdKOF3N2MJe00fSvvjSxAvhdbLAo4',
      type: StoryType.image,
      uploadTime: '23 min')
];

List<Note> notes = [
  Note(person: accounts[9].person, note: "Goodbye"),
  Note(person: accounts[10].person, note: "Finally completed my long work !"),
  Note(person: accounts[24].person, note: "blahhh!"),
  Note(person: accounts[16].person, note: "I'll be sleeping whole day today"),
  Note(
      person: accounts[19].person,
      note: "I am never cooking fried tofu again 😭"),
];

List<ChatText> chatTexts = [
  ChatText(
      text: "cyaa, byee",
      time: "8:26",
      textid: 13,
      repliedTo: 12,
      sentByUser: true),
  ChatText(text: "byee", time: "8:26", textid: 12),
  ChatText(text: "Okayy than, see ya tomorrow", time: "8:25", textid: 11),
  ChatText(
      text: "Alr, I will call them all",
      time: "8:25",
      textid: 10,
      repliedTo: 9,
      sentByUser: true),
  ChatText(
      text: "Ya, it's been a long time since we all went out together",
      time: "8:25",
      textid: 9,
      repliedTo: 8),
  ChatText(
      text: "Okay, should I call others too ??",
      time: "8:25",
      textid: 8,
      sentByUser: true),
  ChatText(textid: 7, text: "I am in 👍", time: "8:24", repliedTo: 5),
  ChatText(
      textid: 6,
      text: "A new park just opened last week",
      time: "8:24",
      sentByUser: true),
  ChatText(
      textid: 5,
      text: "So wanna go hangout morrow ?",
      time: "8:24",
      sentByUser: true),
  ChatText(
      textid: 4,
      text: "Had hard time getting into my room, its on second floor",
      time: "8:24"),
  ChatText(
      textid: 3, text: "Heyy, don't remind me it", time: "8:23", repliedTo: 2),
  ChatText(
      textid: 2,
      text: "Hope you don't get scared while sleepin at night",
      time: "8:23",
      sentByUser: true),
  ChatText(textid: 1, text: "Just got shifted to the new house", time: "8:23"),
  ChatText(textid: 0, text: "hii", time: "8:23"),
];

List<Reel> reels = [
  Reel(
      person: accounts[13].person,
      title: "Drawing still life",
      description: "",
      pathToMedia: "reels/v1.mp4",
      postId: 006,
      likes: 132,
      playCount: 4231),
];

const String linkToPfp =
    "https://drive.google.com/uc?export=view&id=1LB2B4h_hzLjZUb7AWAS8XNkrVa9JQ1yu";
