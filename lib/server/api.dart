import 'dart:io';
import 'package:dio/dio.dart';
import 'package:webfeed/webfeed.dart';

class API{
  static Future<RssFeed> getTistory() async {
    var dio = Dio();
    final sData = await dio.get('https://vintageappmaker.tistory.com/rss');
    return RssFeed.parse(sData.data);
  }

  static Future<RssFeed> getTumblr() async {
    var dio = Dio();
    final sData = await dio.get('https://vintageappmaker.tumblr.com/rss');
    return RssFeed.parse(sData.data);
  }

  static Future<AtomFeed> getYoutube() async {
    var dio = Dio();
    final sData = await dio.get('https://www.youtube.com/feeds/videos.xml?channel_id=UCQAo_pP9qcD2pZqd9EhnNLw');
    return AtomFeed.parse(sData.data);
  }
}