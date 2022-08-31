import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:githubblogapp/custom_icon_icons.dart';
import "package:provider/provider.dart";

import 'pages/BlogPage.dart';
import 'pages/HomePage.dart';
import 'pages/NewsPage.dart';
import 'pages/RepoPage.dart';
import 'states/providers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalState()),
      ],
      child: MaterialApp(
        title: 'blog app',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  late List<Widget> _items;

  late GlobalState c;

  ValueNotifier<int> _param = ValueNotifier<int>(0);

  @override
  void initState() {
    _items = [HomePage(), RepoPage(), NewsPage(), BlogPage()];
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // build에서 초기화해야 한다.
    c = context.watch<GlobalState>();
    c.fnPageMove = _onTap;

    return Scaffold(
      appBar: BlankAppBar(),
      body: ValueListenableBuilder(
        valueListenable: _param,
        builder: (ctx, int n, child) {
          return Center(child: _items[n]);
        },
      ),
      bottomNavigationBar: _showBottomNav(),
    );
  }

  Widget _showBottomNav() {
    return ValueListenableBuilder(
      valueListenable: _param,
      builder: (ctx, n, child) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcon.github_icon),
              label: 'repository',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper_sharp),
              label: 'news',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_rounded),
              label: 'blog',
            )
          ],
          currentIndex: _param.value,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          onTap: _onTap,
        );
      },
    );
  }

  void _onTap(int index) {
    _param.value = index;

    if (_param.value == index && index == 1) {
      c.fnPage2_setMesageInfo("현재 선택된 상태에서 click함.");
    }
  }
}

class BlankAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}