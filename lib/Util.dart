import 'package:html/parser.dart' show parse;
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Util {
  static String extractUrl(String s) {
    var doc = parse(s);
    String sResult = "";
    if (doc.getElementsByTagName("img").length < 1) return sResult;
    sResult = doc.getElementsByTagName("img")[0].attributes["src"].toString();

    return sResult;
  }

  static void extractLi(String s, Function onAdd) {
    var doc = parse(s);
    if (doc.getElementsByTagName("a").length < 1) return;
    doc.getElementsByTagName("a")!.forEach((element) {
      onAdd(element.text, element.attributes["href"].toString());
    });
  }

  // youtube 썸네일
  static String? getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }
    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

  // 공유하기
  static void shareUrl(String sUrl) async {
    final Uri _url = Uri.parse(sUrl);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  static String getSizeWithString(int n) {
    if (n < 1000) return "${n}k";
    if (n > 1000 && n < 1000 * 1000) return "${n / 1000}m";

    return "${n / 1000 * 1000}g";
  }

  // web일 경우, sReplace 주소로 치환
  static String getWebAppImageUrl(String sOrg, String sReplace) {
    String sResult = sOrg;
    if (kIsWeb) {
      sResult = sReplace;
    }
    return sResult;
  }
}
