import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:githubblogapp/Util.dart';
import 'package:githubblogapp/data/NewsPageData.dart';
import 'package:githubblogapp/server/RSSApi.dart';
import 'package:githubblogapp/states/providers.dart';
import "package:provider/provider.dart";

class NewsPage extends StatefulWidget {
  @override
  NewsPageState createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage>{
  late GestureDetector gestureDetector;
  List<RssGoogle> lst =[];

  // scroll
  final ScrollController _scrollController = ScrollController();

  Widget buildRssInfo() {
    Column buildColumn() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // user 정보

          SizedBox(height: 8.0),

          // repo 리스트 : Expanded로 감싸야 한다.
          Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (BuildContext, index) {
                  return buildItemCard(index);
                },
                itemCount: lst.length,
                shrinkWrap: true,
                padding: EdgeInsets.all(5),
                scrollDirection: Axis.vertical,
              ))
        ],
      );
    }

    return Stack(children: [Container(color: Colors.black, width: double.infinity, height: double.infinity, child: SizedBox(),), Container(color: Colors.transparent, child: buildColumn())]);
  }



  // Repo 카드
  Widget buildItemCard(int index) {
    var sTitle = lst[index].title;
    Widget buildLinkWidget(int indx, String sUrl){
      return GestureDetector(
        onTap: (){ Util.shareUrl(sUrl);},
        child: Column(children: [SizedBox(height: 8.0), Text("📻 ${lst[index].items[indx].title}", overflow: TextOverflow.ellipsis,
          maxLines: 1,
          softWrap: true,
          style: TextStyle(color: Colors.black54),) ],),
      );
    }

    return Card(
      child: ListTile(

        title: Row(
          children: [
            Flexible(
              child: Text(sTitle, overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(color: Colors.black)),
            ),
            SizedBox(width: 10),
            // Text(sSize, style: TextStyle(fontSize: 12, color: Colors.red)),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.0),
            for ( var i = 0 ; i < lst[index].items.length; i++) buildLinkWidget(i, lst[index].items[i].link),
            SizedBox(height: 8.0),

          ],
        ),
      ),
    );
    }



  @override
  void initState() {
    super.initState();
    getNewsInfo();
  }

  void getNewsInfo() async{
    var b = await RSSApi.getGoogle();
    lst.clear();
    b.items!.forEach((element) {
      var items = <RssGoogleItem>[];
      Util.extractLi( element.description!, (String title, String href){
        items.add(RssGoogleItem(title: title, link: href));
      } );

      lst.add(RssGoogle(title: element.title ?? "", link: "", items: items));

    });

    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildRssInfo();
  }
}
