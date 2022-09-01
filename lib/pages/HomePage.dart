import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:githubblogapp/states/providers.dart';
import 'package:githubblogapp/wigets/UtilWidget.dart';
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final _pageController = PageController(viewportFraction: 1);
  int _index = 0;

  Widget _buildPageView() {
    return Container(
      color: Colors.grey,
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
    return Container(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var url = (index % 2 == 0)
                ? "https://lh3.googleusercontent.com/GTmuiIZrppouc6hhdWiocybtRx1Tpbl52eYw4l-nAqHtHd4BpSMEqe-vGv7ZFiaHhG_l4v2m5Fdhapxw9aFLf28ErztHEv5WYIz5fA"
                : "https://oopy.lazyrockets.com/api/v2/notion/image?src=https%3A%2F%2Fs3-us-west-2.amazonaws.com%2Fsecure.notion-static.com%2F9e5d9e8e-4b0d-4f3f-9580-baf556faad5c%2Fios-logo.jpg&blockId=d983bdda-9a22-4eab-998b-9a0ff3f8ec73&width=2400";
            return Container(child: Image.network(url));
          }),
    );
  }

  Widget _buildHeader(String s, [Color c = Colors.white]) {
    return Container(
        width: double.infinity,
        height: 100,
        color: c,
        child: Center(
            child: Text(
          s,
          style: TextStyle(fontSize: 20, color: Colors.grey),
        )));
  }

  Widget _buildCard() {
    String sMessage =
        " S/W Development \n Consulting\n Education\n Tech Writer";
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Color.fromARGB(255, 117, 117, 116),
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
              subtitle: Text(sMessage, style: TextStyle(color: Colors.grey)),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(8),
              width: double.infinity,
              child: Text("http://vintageappmaker.com",
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            )
          ],
        ));
  }

  late List<Widget> widgetList1;

  @override
  void initState() {
    widgetList1 = [
      _buildHeader("+Grid뷰"),
      _buildGridView(),
      _buildHeader("+Page뷰"),
      for (var i = 0; i < 10; i++) _buildPageView(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BlankAppBar(),
        body: Container(
          color: Colors.grey,
          child: CustomScrollView(
            slivers: <Widget>[
              // 첫번째 Header
              SliverAppBar(
                pinned: false,
                expandedHeight: MediaQuery.of(context).size.height / 3,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('', style: TextStyle(fontSize: 18)),
                  background: Image.network(
                      fit: BoxFit.cover,
                      "https://cdn.pixabay.com/photo/2018/01/11/21/27/desk-3076954_960_720.jpg"),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
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
                title: ListTile(
                  leading: Text("🍕",
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  title: Text(
                    "고정된 SliverAppBar",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => widgetList1[index],
                    childCount: widgetList1.length),
              ),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
