import 'package:html/parser.dart' show parse;

class Util {


  static String extractUrl(String s){
      var doc = parse(s);
      String sResult = "";
      if (doc.getElementsByTagName("img").length < 1) return sResult;
      sResult = doc.getElementsByTagName("img")[0].attributes["src"].toString();

      return sResult;
  }

  // youtube 썸네일
  static String? getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return null;
    }
    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }

}
