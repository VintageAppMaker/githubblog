import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:githubblogapp/states/providers.dart';
import "package:provider/provider.dart";

class RepoPage extends StatefulWidget {
  @override
  RepoPageState createState() {
    return RepoPageState();
  }
}

class RepoPageState extends State<RepoPage> with AutomaticKeepAliveClientMixin {
  // Setting to true will force the tab to never be disposed. This could be dangerous.
  @override
  bool get wantKeepAlive => true;
  ValueNotifier<String> _data = ValueNotifier<String>("");
  late GlobalState c;

  @override
  void initState() {
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // build에서 초기화해야 한다.
    c = context.watch<GlobalState>();
    c.fnPage2_setMesageInfo = setMessageInfo;
    setDefaultInfo();

    return ValueListenableBuilder(
        valueListenable: _data,
        builder: (ctx, String s, child) {
          return GestureDetector(
              onTap: () {},
              child: Text(
                "${s}",
                style: TextStyle(color: Colors.blue, fontSize: 30),
              ));
        });
  }

  void setMessageInfo(String s) {
    _data.value = s;
  }

  void setDefaultInfo() {
    if (c.isBottomNavigate == false) {
      setMessageInfo("위젯 클릭으로 이동. ${c.nClick}");
      c.isBottomNavigate = true;
    } else {
      setMessageInfo("하단메뉴로 이동.");
      c.isBottomNavigate = true;
    }
  }
}
