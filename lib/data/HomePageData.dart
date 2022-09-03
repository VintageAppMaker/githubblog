class RssTiStory {
  late String title;
  late String thumbnail;
  late String link;

  RssTiStory({required this.title, required this.thumbnail, this.link = ""});
}

class RssTumblr {
  late String thumbnail;
  late String link;

  RssTumblr({required this.thumbnail, this.link = ""});
}

class AtomYoutube {
  late String title;
  late String thumbnail;
  late String link;

  AtomYoutube({required this.title, required this.thumbnail, this.link = ""});
}
