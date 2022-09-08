import 'package:dio/dio.dart';
import 'package:webfeed/webfeed.dart';

class MDApi{
  static void getGithubMD(Function onComplete) async {
    var dio = Dio();
    final sData = await dio.get('https://raw.githubusercontent.com/VintageAppMaker/VintageAppMaker/master/README.md');
    onComplete(sData.data);
  }
}