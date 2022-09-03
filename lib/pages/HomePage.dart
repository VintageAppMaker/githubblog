import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:githubblogapp/custom_icon_icons.dart';
import 'package:githubblogapp/data/HomePageData.dart';
import 'package:githubblogapp/server/api.dart';
import 'package:githubblogapp/wigets/CustomWidgets.dart';
import 'package:githubblogapp/wigets/UtilWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:githubblogapp/Util.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
  int _index = 0;

  List<RssTiStory>  lstTiStory  = [];
  List<RssTumblr>   lstTumblr   = [];
  List<AtomYoutube> lstYoutube  = [];

  late List<Widget> widgetList1;
  late List<Widget> widgetList2;
  late List<Widget> widgetList3;

  final ValueNotifier<int> tistoryCount  = ValueNotifier<int>(0);
  final ValueNotifier<int> youtubeCount  = ValueNotifier<int>(0);
  final ValueNotifier<int> tumblrCount   = ValueNotifier<int>(0);

  Widget _buildAppAvatarList(){
    var lst = <Widget>[
      buildAvatar("https://play-lh.googleusercontent.com/XrizX1_DQvPyXwWkyJEgZwC7f8P8vRzq3l8c6yd32VZVcpQ423Wb-y0s0pCe8q3F1eP8=w240-h480-rw"),
      buildAvatar("https://play-lh.googleusercontent.com/1WxLS_Mgb6IUMrfkbJ1gBVhiL4_CG2sSCl0UecUSXsolyPQz6jEV51BuLKnKdlPx9rI=w240-h480-rw"),
      buildAvatar("https://play-lh.googleusercontent.com/QoNk1z5drgx2aFmZr_rUO12d4e1JoxDtZ3ox12eJxo65FCAViSEmuH8IVuDUg7NYcENM=w240-h480-rw"),
      buildAvatar("https://play-lh.googleusercontent.com/_KQmCFqljdTLe51CzWaE4d64jBLapkdF7hsthymCFYMlt3UtIR1HX3tGXj-QYg_eOw=w240-h480-rw"),
      buildAvatar("https://play-lh.googleusercontent.com/6WW-nmZQ_MTkALEVT9HAFg-jRHitSdWIcxWHeS2Lak_TWL0VibRlnZjM2MLJ71fqlO8=w240-h480-rw"),
      buildAvatar("https://play-lh.googleusercontent.com/bk7RMkKMcPuv4OU_gc1iTW4fuOK4tBfW970xHdMArLInAxgvBtri_bvCljb1a5eEfA=w240-h480-rw"),
      buildAvatar("https://play-lh.googleusercontent.com/vS48CuRkPP92bF-CmaAwovmj7PTgKMjWG0b4sC4_PIcEgvopyIoaGI8GePv7TAiHaw=s64-rw")
    ];
    return Container(width: double.infinity, child: Center(child: buildHorizontalAvatarList(lst)));
  }

  Widget _buildPageView() {

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: _getYoutubeData(),
          builder: (BuildContext context, AsyncSnapshot snapshot){

            if (snapshot.hasData == false)
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            if (snapshot.hasData == false)
              return Container(
                  child: Center(
                      child: Text(
                        "🚀loading Error",
                        style: TextStyle(fontSize: 40, color: Colors.amber),
                      )));

            // 초기화 및 데이터저장
            lstYoutube.clear();
            lstYoutube.addAll(snapshot.data);

            return PageView.builder(
                itemCount: lstYoutube.length,
                controller: _pageController,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        var url = Uri.parse(lstYoutube[index].link);
                        launchUrl(url);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Expanded(
                              flex: 7,
                              child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(8),
                                  width: double.infinity,
                                  child: Image.network(
                                    "${lstYoutube[index].thumbnail}",
                                    fit: BoxFit.fitWidth,
                                  ))),
                          Expanded(
                              flex: 1,
                              child: Container(
                                color: Colors.white,
                                  padding: EdgeInsets.only(
                                      left: 8, right: 8),
                                  child: Center(
                                      child: Text(
                                        "${lstYoutube[index].title}",
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(fontSize: 14, color: Colors.grey),
                                      ))))
                        ],),
                      ),
                    ),
                  );
                },
                onPageChanged: (int index) => setState(() => _index = index));

          },
      )),
    );
  }

  Container _buildGridView() {
    String getUrl(int n) {
      return lstTiStory[n % lstTiStory.length].thumbnail;
    }

    String getTitle(int n) {
      return lstTiStory[n % lstTiStory.length].title;
    }

    String getLink(int n) {
      return lstTiStory[n % lstTiStory.length].link;
    }

    return Container(
      child: FutureBuilder(
          future: _getTistoryData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false)
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            if (snapshot.hasData == false)
              return Container(
                  child: Center(
                      child: Text(
                "🚀loading Error",
                style: TextStyle(fontSize: 40, color: Colors.amber),
              )));

            // 초기화 및 데이터저장
            lstTiStory.clear();
            lstTiStory.addAll(snapshot.data);

            return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: lstTiStory.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var url = getUrl(index);
                  return GestureDetector(
                    onTap: () {
                      var url = Uri.parse(getLink(index));
                      launchUrl(url);
                    },
                    child: Card(
                        child: Container(
                            child: (url.trim() == "")
                                ? Container(
                                    padding: EdgeInsets.all(16),
                                    child: Center(
                                      child: Text("${getTitle(index)}"),
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          flex: 7,
                                          child: Container(
                                              width: double.infinity,
                                              child: buildBWWidget(
                                                  child: Image.network(
                                                    url,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                  spec: index % 2))),
                                      Expanded(
                                          flex: 1,
                                          child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 8, right: 8),
                                              child: Center(
                                                  child: Text(
                                                "${getTitle(index)}",
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                                style: TextStyle(fontSize: 14),
                                              ))))
                                    ],
                                  ))),
                  );
                });
          }),
    );
  }

  Container _buildGridView2() {
    String getUrl(int n) {
      return lstTumblr[n % lstTiStory.length].thumbnail;
    }

    String getLink(int n) {
      return lstTumblr[n % lstTiStory.length].link;
    }

    return Container(
      child: FutureBuilder(
          future: _getTumblrData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData == false)
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            if (snapshot.hasData == false)
              return Container(
                  child: Center(
                      child: Text(
                        "🚀loading Error",
                        style: TextStyle(fontSize: 40, color: Colors.amber),
                      )));

            // 초기화 및 데이터저장
            lstTumblr.clear();
            lstTumblr.addAll(snapshot.data);

            return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: lstTumblr.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var url = getUrl(index);
                  return GestureDetector(
                    onTap: () {
                      var url = Uri.parse(getLink(index));
                      launchUrl(url);
                    },
                    child: Card(
                        child: Container(
                            child: (url.trim() == "")
                                ? Container(
                              padding: EdgeInsets.all(16),
                              child: Center(
                                child: Text(""),
                              ),
                            )
                                : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: double.infinity,
                                    child: Image.network(
                                      url,
                                      fit: BoxFit.fitWidth,
                                    ))
                              ],
                            ))),
                  );
                });
          }),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(18),
        color: Colors.black,
        child: Row(
          children: [
            Icon(
              Icons.app_registration,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),
            ValueListenableBuilder(
              valueListenable: tistoryCount,
              builder: (c, value, child){
                return Text("${value}",
                style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                ));
              },

            ),
            SizedBox(
              width: 4,
            ),
            Align(alignment: Alignment.bottomCenter, child: Text("- tistory", style: TextStyle(fontSize: 11, color: Colors.grey),))
          ],
        ));
  }

  Widget _buildHeader2() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(18),
        color: Colors.black,
        child: Row(
          children: [
            Icon(
              Icons.video_label,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),

            ValueListenableBuilder(
              valueListenable: youtubeCount,
              builder: (c, value, child){
                return Text("${value}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ));
              },

            ),

            SizedBox(
              width: 4,
            ),
            Align(alignment: Alignment.bottomCenter, child: Text("- youtube", style: TextStyle(fontSize: 11, color: Colors.grey),))

          ],
        ));
  }

  Widget _buildHeader3() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(18),
        color: Colors.black,
        child: Row(
          children: [
            Icon(
              Icons.format_paint,
              color: Colors.white,
            ),
            SizedBox(
              width: 4,
            ),

            ValueListenableBuilder(
              valueListenable: tumblrCount,
              builder: (c, value, child){
                return Text("${value}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ));
              },

            ),

            SizedBox(
              width: 4,
            ),
            Align(alignment: Alignment.bottomCenter, child: Text("- tumblr", style: TextStyle(fontSize: 11, color: Colors.grey),))

          ],
        ));
  }

  Widget _buildGithubButton() {
    return ActionChip(
        elevation: 4.0,
        padding: EdgeInsets.all(4.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(
            CustomIcon.github_icon,
            color: Colors.black,
            size: 20,
          ),
        ),
        label: Container(
          alignment: Alignment.center,
          width: 50,
          child: Center(
            child: Text(
              'github',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        onPressed: () {
          var url = Uri.parse("https://github.com/VintageAppMaker/");
          launchUrl(url);
        },
        backgroundColor: Colors.white,
        shape: StadiumBorder(
            side: BorderSide(
          width: 0,
          color: Colors.grey,
        )));
  }

  Widget _buildCard() {
    String sMessage =
        " S/W Development \n Consulting\n Education\n Tech Writing";
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          color: Colors.transparent,
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://avatars.githubusercontent.com/u/31234716?v=4"),
                          fit: BoxFit.scaleDown)),
                ),
                title: Text('Vintage appMaker',
                    style: TextStyle(color: Colors.white, fontSize: 30)),
                subtitle: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(sMessage, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                child: _buildGithubButton(),
              ),

              _buildAppAvatarList()
            ],
          )),
    );
  }


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
    var data = await API.getTistory();
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
    var data = await API.getTumblr();
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
    var atomes = await API.getYoutube();
    var lst = <AtomYoutube>[];

    atomes.items?.forEach((element) {
      lst.add(AtomYoutube(
          title: element.title ?? "",
          thumbnail: Util.getYoutubeThumbnail(element.links?[0].href ?? "") ?? "",
          link: element.links?[0].href ?? ""));
    });

    youtubeCount.value = lst.length;
    return lst;
  }

  Container _buildHomePage(BuildContext context) {
    widgetList1 = [
      _buildGridView()
    ];

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
