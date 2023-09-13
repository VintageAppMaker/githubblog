import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:githubblogapp/custom_icon_icons.dart';
import 'package:githubblogapp/data/HomePageData.dart';
import 'package:githubblogapp/server/RSSApi.dart';
import 'package:githubblogapp/wigets/CustomWidgets.dart';
import 'package:githubblogapp/wigets/UtilWidget.dart';
import 'package:githubblogapp/wigets/timeline.dart';
import 'package:githubblogapp/Util.dart';

part 'HomePage.widget.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
  int _index = 0;

  List<RssTiStory> lstTiStory = [];
  List<RssTumblr> lstTumblr = [];
  List<AtomYoutube> lstYoutube = [];

  late List<Widget> widgetList1;
  late List<Widget> widgetList2;
  late List<Widget> widgetList3;

  final ValueNotifier<int> tistoryCount = ValueNotifier<int>(0);
  final ValueNotifier<int> youtubeCount = ValueNotifier<int>(0);
  final ValueNotifier<int> tumblrCount = ValueNotifier<int>(0);

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BlankAppBar(),
        body: LayoutBuilder(builder: ((context, constraints) {
          return _buildHomePage(context);
        })));
  }

  Future<List<RssTiStory>> _getTistoryData() async {
    // 통신
    var data = await RSSApi.getTistory();
    var lst = <RssTiStory>[];
    data.items?.forEach((element) {
      lst.add(RssTiStory(
          title: element.title ?? "",
          thumbnail: Util.extractUrl(element.description.toString()),
          link: element.link ?? ""));
    });

    tistoryCount.value = lst.length;
    return lst;
  }

  Future<List<RssTumblr>> _getTumblrData() async {
    // 통신
    var data = await RSSApi.getTumblr();
    var lst = <RssTumblr>[];

    data.items?.forEach((element) {
      lst.add(RssTumblr(
          thumbnail: Util.extractUrl(element.description.toString()),
          link: element.link ?? ""));
    });

    tumblrCount.value = lst.length;
    return lst;
  }

  Future<List<AtomYoutube>> _getYoutubeData() async {
    var atomes = await RSSApi.getYoutube();
    var lst = <AtomYoutube>[];

    atomes.items?.forEach((element) {
      lst.add(AtomYoutube(
          title: element.title ?? "",
          thumbnail:
              Util.getYoutubeThumbnail(element.links?[0].href ?? "") ?? "",
          link: element.links?[0].href ?? ""));
    });

    youtubeCount.value = lst.length;
    return lst;
  }

  Container _buildHomePage(BuildContext context) {
    widgetList1 = [_buildGridView()];

    widgetList2 = [
      _buildPageView(),
    ];

    widgetList3 = [
      _buildGridView2(),
    ];

    return Container(
      color: Colors.black,
      child: CustomScrollView(
        slivers: <Widget>[
          // 첫번째 Header
          _buildSliverAppbar(context),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    _buildCard(),
                  ],
                ),
              );
            }, childCount: 1),
          ),

          // 두번째 해더
          SliverAppBar(
            pinned: true,
            flexibleSpace: _buildHeader(),
            backgroundColor: Colors.black,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => widgetList1[index],
                childCount: widgetList1.length),
          ),

          // 두번째 해더
          SliverAppBar(
            pinned: true,
            flexibleSpace: _buildHeader2(),
            backgroundColor: Colors.black,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => widgetList2[index],
                childCount: widgetList2.length),
          ),

          // 세번째 해더
          SliverAppBar(
            pinned: true,
            flexibleSpace: _buildHeader3(),
            backgroundColor: Colors.black,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => widgetList3[index],
                childCount: widgetList3.length),
          )
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppbar(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 3;
    var w = MediaQuery.of(context).size.width / 3;
    h = (w > h) ? h * 2 : h;
    return SliverAppBar(
      elevation: 3.0,
      pinned: false,
      expandedHeight: h,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('', style: TextStyle(fontSize: 18)),
        background: Image.network(
            fit: BoxFit.cover,
            "https://cdn.pixabay.com/photo/2020/09/27/13/15/data-5606639_960_720.jpg"),
      ),
    );
  }
}
