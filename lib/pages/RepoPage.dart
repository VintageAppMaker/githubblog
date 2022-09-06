import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:flutter/widgets.dart";
import 'package:githubblogapp/server/RestClient.dart';
import 'package:githubblogapp/server/githubdata.dart';
import 'package:githubblogapp/wigets/CustomWidgets.dart';
import 'package:githubblogapp/wigets/UtilWidget.dart';
import '../Util.dart';

class RepoPage extends StatefulWidget {
  @override
  RepoPageState createState() {
    return RepoPageState();
  }
}

class RepoPageState extends State<RepoPage>{
  // 통신처리
  bool bLoading = false;
  // 리스트처리
  List<dynamic> display_lst =  List.empty(growable: true);
  int lstCount = 0;
  static int FIRST_PAGE = 1;
  int pagecount = FIRST_PAGE;

  // scroll
  final ScrollController _scrollController = ScrollController();

  // Rainbow?
  final dio = Dio();

  // 계정입력
  String sAccount = "vintageappmaker";

  // 생성
  @override
  void initState() {
    super.initState();

    // scroll bottom처리
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        print("more");
        pagecount++;
        _getNextPage(sAccount, pagecount);
      }
    });

    _getUserInfo(sAccount);
  }

  // 종료
  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  // 개인프로필
  Future<User?> getUserProf(String sUser) async {
    final client = RestClient(dio);

    User? u = null;
    try {
      u = await client.getUser(sUser);
    } catch (e) {}

    return u;
  }

  // 처음 repo list 가져오기
  Future<List<Repo>> getRepoListFirst(String sUser) async {
    final client = RestClient(dio);
    List<Repo> lst = await client.listRepos(sUser);

    pagecount = FIRST_PAGE;

    return lst;
  }

  Future<List<Repo>> getRepoNext(String sUser, int page) async {
    final client = RestClient(dio);
    List<Repo> lst = await client.listReposWithPage(sUser, page);
    return lst;
  }

  void _getUserInfo(String sUser) async {
    setState(() {
      bLoading = true;
    });

    User? u = await getUserProf(sUser);
    // 통신에러
    if (u == null) {
      setState(() {
        bLoading = false;
      });

      return;
    }

    List<Repo> lst = await getRepoListFirst(sUser);

    setState(() {
      bLoading = false;

      display_lst.clear();

      // data 추가
      display_lst.add(u);
      display_lst.addAll(lst);

      // 화면갱신
      lstCount = lst.length;
    });
  }

  void _getNextPage(String sUser, int page) async {
    setState(() {
      bLoading = true;
    });

    List<Repo> lst = await getRepoNext(sUser, page);
    setState(() {
      bLoading = false;

      // data 추가
      display_lst.addAll(lst);

      // 화면갱신
      lstCount = display_lst.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: BlankAppBar(),
      body: mainContent(),
    );
  }

  String makeStar(int n) {
    int MAX_SHOW = 10;
    if (n == 0) return "";
    if (n > MAX_SHOW) return "\uD83E\uDD29 X ${n}";
    String s = "";
    for (int i = 0; i < n; i++) {
      s = s + "⭐";
    }
    return s;
  }

  // main 화면
  Widget mainContent() {
    return Center(
        child: Stack(
          children: [
            //if (sAccount.length > 0) makeAccountInfo() else makeNotice(),
            makeAccountInfo(),
            if (bLoading) showProgress()
          ],
        ),
    );
  }

  Column makeAccountInfo() {
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
                return makeItemCard(index);
              },
              itemCount: lstCount,
              shrinkWrap: true,
              padding: EdgeInsets.all(5),
              scrollDirection: Axis.vertical,
            ))
      ],
    );
  }

  // Repo 카드
  Widget makeItemCard(int index) {
    if (display_lst == null)
      return Text(
        '자료없음',
        style: Theme.of(context).textTheme.headline4,
      );

    if (display_lst[index] is Repo) {
      var repo = display_lst[index] as Repo;
      String sTitle = "${repo.name}";
      String sDesc = "${repo.description ?? ""}";
      String sSize = "${Util.getSizeWithString(repo.size)}";

      return InkWell(
        child: Card(
          color: Color(0x33ffffff),
          child: ListTile(
            leading: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text("$index", style: TextStyle(fontSize: 20, color: Colors.grey))],
            ),
            title: Row(
              children: [
                Text(sTitle, style: TextStyle(fontSize: 18, color: Colors.grey)),
                SizedBox(width: 10),
                Text(sSize, style: TextStyle(fontSize: 12, color: Colors.red)),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.0),
                Text(sDesc, style: TextStyle(fontSize: 15, color: Colors.grey)),
                SizedBox(height: 8.0),
                Text("${makeStar(repo.stargazers_count)}",style: TextStyle(fontSize: 15, color: Colors.yellow))
              ],
            ),
          ),
        ),
        onTap: () {
          Util.shareUrl(repo.clone_url ?? "");
        },
      );
    } else {
      // User Info
      User u = display_lst[index] as User;
      return showUserCard(u);
    }
  }

  // User Card
  Widget showUserCard(User u) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: Color(0x11FFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 18.0),
          Center(
              child: buildBWWidget(child: Image.network(u.avatar_url ?? "", fit: BoxFit.fitWidth))),
          Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(u.login ?? "",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                      maxLines: 1),
                  SizedBox(height: 8.0),
                  Text(u.bio ?? "", style: TextStyle(color: Colors.grey)),
                  Text("🤴 followers : ${u.followers}", style: TextStyle(color: Colors.grey)),
                  Text("👨‍🎓 following : ${u.following}", style: TextStyle(color: Colors.grey)),
                ],
              ))
        ],
      ),
    );
  }

}
