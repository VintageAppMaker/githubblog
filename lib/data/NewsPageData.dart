class RssGoogle {
  late String title;
  late String link;
  late List<RssGoogleItem> items;

  RssGoogle({required this.title, required this.link, required this.items});
}

class RssGoogleItem {
  late String title;
  late String link;

  RssGoogleItem({required this.title, required  this.link});
}

