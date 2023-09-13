import 'package:dio/dio.dart';
import 'package:webfeed/webfeed.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/services.dart';

class RSSApi {
  static Future<RssFeed> getTistory() async {
    // cors access deny. 웹의 경우 API 사용에 제약이 있음
    if (kIsWeb) {
      String text = await rootBundle.loadString("assets/rssTistory.txt");
      return RssFeed.parse(text);
    } else {
      var dio = Dio();
      final sData = await dio.get('https://vintageappmaker.tistory.com/rss');
      return RssFeed.parse(sData.data);
    }
  }

  static Future<RssFeed> getTumblr() async {
    // cors access deny. 웹의 경우 API 사용에 제약이 있음
    if (kIsWeb) {
      String text = await rootBundle.loadString("assets/rssTumblr.txt");
      return RssFeed.parse(text);
    } else {
      var dio = Dio();
      final sData = await dio.get('https://vintageappmaker.tumblr.com/rss');
      return RssFeed.parse(sData.data);
    }
  }

  static Future<AtomFeed> getYoutube() async {
    // cors access deny. 웹의 경우 API 사용에 제약이 있음

    if (kIsWeb) {
      String text = await rootBundle.loadString("assets/rssYoutube.txt");
      return AtomFeed.parse(text);
    } else {
      var dio = Dio();
      final sData = await dio.get(
          'https://www.youtube.com/feeds/videos.xml?channel_id=UCQAo_pP9qcD2pZqd9EhnNLw');
      return AtomFeed.parse(sData.data);
    }
  }

  static Future<RssFeed> getGoogle() async {
    // cors access deny. 웹의 경우 API 사용에 제약이 있음
    if (kIsWeb) {
      String text = await rootBundle.loadString("assets/rssStatic.txt");
      return RssFeed.parse(text);
    } else {
      var dio = Dio();
      final sData =
          await dio.get('https://news.google.com/rss?hl=ko&gl=KR&ceid=KR:ko');
      return RssFeed.parse(sData.data);
    }
  }
}
