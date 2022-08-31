import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:githubblogapp/states/providers.dart';
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  late GestureDetector gestureDetector;

  // Setting to true will force the tab to never be disposed. This could be dangerous.
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var c = context.watch<GlobalState>();
    gestureDetector = GestureDetector(
        onTap: () {
          c.goPage(1);
        },
        child: Text(
          "Tab2로 이동",
          style: TextStyle(fontSize: 30),
        ));

    return gestureDetector;
  }
}
