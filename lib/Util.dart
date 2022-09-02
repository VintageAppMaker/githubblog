import 'dart:io';

//import 'package:http/io_client.dart';
import 'package:dio/dio.dart';
import 'package:webfeed/webfeed.dart';
import 'package:html/parser.dart' show parse;

class Util {
  static Future<RssFeed> getTistory() async {
    var dio = Dio();
    final sData = await dio.get('https://vintageappmaker.tistory.com/rss');
    return RssFeed.parse(sData.data);
  }

  static String extractUrl(String s){
      var doc = parse(s);
      String sResult = "";
      if (doc.getElementsByTagName("img").length < 1) return sResult;
      sResult = doc.getElementsByTagName("img")[0].attributes["src"].toString();

      return sResult;
  }
}
