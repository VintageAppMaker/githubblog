import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:githubblogapp/custom_icon_icons.dart';
import 'package:githubblogapp/states/providers.dart';
import 'package:githubblogapp/wigets/UtilWidget.dart';
import "package:provider/provider.dart";
import 'package:url_launcher/url_launcher.dart';
import 'package:githubblogapp/Util.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final _pageController = PageController(viewportFraction: 1);
  int _index = 0;
  List<RssTiStory> lstTiStory = [];

  Widget _buildPageView() {
    return Container(
      color: Colors.black,
      height: 100,
      child: PageView.builder(
          itemCount: 10,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: (index % 2 == 0)
                    ? Color.fromARGB(255, 196, 15, 15)
                    : Color.fromARGB(255, 73, 73, 72),
                child: SizedBox(
                    width: 100, child: Center(child: Text("${_index}"))),
              ),
            );
          },
          onPageChanged: (int index) => setState(() => _index = index)),
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
          future: getData(),
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
                    onTap: (){
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
                                              child: Image.network(
                                                url,
                                                fit: BoxFit.fitWidth,
                                              ))),
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

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(18),
        color: Colors.black,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.app_registration,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text("10",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ))
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.note,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text("10",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.green,
                      ))
                ],
              ),
            )
          ],
        )));
  }

  Widget _buildGithubButton() {
    return ActionChip(
        elevation: 4.0,
        padding: EdgeInsets.all(4.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(
            CustomIcon.github_icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        label: Text(
          'github',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          var url = Uri.parse("https://github.com/VintageAppMaker/");
          launchUrl(url);
        },
        backgroundColor: Colors.green,
        shape: StadiumBorder(
            side: BorderSide(
          width: 1,
          color: Colors.green,
        )));
  }

  Widget _buildCard() {
    String sMessage =
        " S/W Development \n Consulting\n Education\n Tech Writer";
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
              )
            ],
          )),
    );
  }

  late List<Widget> widgetList1;

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

  Future<List<RssTiStory>> getData() async {
    // 통신
    var data = await Util.getTistory();
    var lst = <RssTiStory>[];
    data.items?.forEach((element) {
      lst.add(RssTiStory(
          title: element.title ?? "",
          thumbnail: Util.extractUrl(element.description.toString()),
          link: element.link ?? ""
      ));
    });

    return lst;
  }

  Container _buildHomePage(BuildContext context) {
    // initState()에는 되도록 초기화 하지말자
    widgetList1 = [
      _buildGridView(),
      _buildPageView(),
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
            "https://cdn.pixabay.com/photo/2018/01/11/21/27/desk-3076954_960_720.jpg"),
      ),
    );
  }
}

// ----------------------------------------
class RssTiStory {
  late String title;
  late String thumbnail;
  late String link;

  RssTiStory({required this.title, required this.thumbnail, this.link = ""});
}
