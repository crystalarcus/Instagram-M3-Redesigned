import 'package:redesigned/Components/Utils/classes.dart';

List<List<Comment>> comments = [
  [
    Comment(
        person: accounts[25].person,
        text: "For Inazuma’s sake, someone please stop her",
        dateTime: "8 min"),
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

Account dummy = Account(
    person: Person(name: "Raiden", userName: "cook", pfpPath: 'images/'),
    followers: [],
    following: [],
    posts: []);

List<Account> accounts = [
  Account(
      person: Person(
          name: "Aether",
          userName: "i.need.primos",
          pfpPath: 'images/aether.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Alhaitham",
          userName: "grand_sage",
          pfpPath: 'images/alhaitham.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Ayaka", userName: "am_i_ayaya", pfpPath: 'images/ayaka.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Ayato",
          userName: "kamisato.ayato",
          pfpPath: 'images/ayato.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Bennet",
          userName: "who.threw.that.stone",
          pfpPath: 'images/bennet.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Childe",
          userName: "not.a.child",
          pfpPath: 'images/childe.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Chongyun",
          userName: "conqurer.of.demon.2",
          pfpPath: 'images/chongyun.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Eula",
          userName: "dance_with_claymore",
          pfpPath: 'images/eula.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Fischl",
          userName: "princess_purple",
          pfpPath: 'images/fischl.png'),
      followers: [],
      following: [],
      posts: [posts[0]]),
  Account(
      person: Person(
          name: "Furina de Fontaine",
          userName: "furina_sunshine",
          pfpPath: 'images/furina.png'),
      bio: "Your Friendly Celebrity Archon of Teyvat",
      pronouns: "she/her",
      followers: ['cook.with.shogun', 'please_die_soon', 'princess_purple'],
      following: ['cook.with.shogun'],
      posts: [posts[1]]),
  Account(
      person: Person(
          name: "Director  Hu",
          userName: "please_die_soon",
          pfpPath: 'images/hutao.png'),
      followers: [],
      following: [],
      posts: [posts[3]]),
  Account(
      person: Person(
          name: "Arataki Itto",
          userName: "the.one.and.oni",
          pfpPath: 'images/itto.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Kaedehara Kazuha",
          userName: "born_in_canada",
          pfpPath: 'images/kazuha.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Keqing", userName: "ke_queen", pfpPath: 'images/keqing.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Lisa", userName: "library_momy", pfpPath: 'images/lisa.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Lumine",
          userName: "prinzessin_von_abyss",
          pfpPath: 'images/lumine.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Mona Megistus",
          userName: "hat_girl",
          pfpPath: 'images/mona.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Nahida",
          userName: "all_knowing_kid",
          pfpPath: 'images/nahida.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Navia", userName: "boss_girl", pfpPath: 'images/navia.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Raiden Shogun",
          userName: "cook.with.shogun",
          pfpPath: 'images/raiden.png'),
      followers: ['please_die_soon', 'princess_purple', 'furina_sunshine'],
      following: ['furina_sunshine'],
      posts: [posts[2]]),
  Account(
      person: Person(
          name: "Kujou Sara",
          userName: "crow.girl.sara",
          pfpPath: 'images/sara.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Shenhe",
          userName: "frozen_momy",
          pfpPath: 'images/shenhe.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Skirk", userName: "skir7x", pfpPath: 'images/skirk.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Venti",
          userName: "alkahol.iz.nat.fo.kidz",
          pfpPath: 'images/venti.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Wanderer",
          userName: "eons_adrift",
          pfpPath: 'images/wanderer.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Xiao",
          userName: "conqurer_of_demons",
          pfpPath: 'images/xiao.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Yae Miko",
          userName: "sussy_fox_lady",
          pfpPath: 'images/yaemiko.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Yelan",
          userName: "got.those.arms",
          pfpPath: 'images/yelan.png'),
      followers: [],
      following: [],
      posts: []),
  Account(
      person: Person(
          name: "Zhongli",
          userName: "ceo_of_geo",
          pfpPath: 'images/zhongli.png'),
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
      pathToMedia: 'images/post/4.png',
      type: StoryType.image,
      uploadTime: '23 min'),
  Story(
      duration: const Duration(seconds: 7),
      pathToMedia: 'images/post/52.png',
      type: StoryType.image,
      uploadTime: '23 min'),
  Story(
      duration: const Duration(seconds: 7),
      pathToMedia: 'images/post/51.png',
      type: StoryType.image,
      uploadTime: '23 min'),
  Story(
      duration: const Duration(seconds: 7),
      pathToMedia: 'images/post/2.png',
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
  ChatText(text: "Okayy than, see ya tomrrow", time: "8:25", textid: 11),
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
