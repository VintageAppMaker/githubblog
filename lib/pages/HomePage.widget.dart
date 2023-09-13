part of "HomePage.dart";

// 기타 위젯들(해더, 버튼, 카드)
extension HeaderWidgets on HomePageState {
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
              builder: (c, value, child) {
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
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "- tistory",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ))
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
              builder: (c, value, child) {
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
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "- youtube",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ))
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
              builder: (c, value, child) {
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
            Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "- tumblr",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ))
          ],
        ));
  }
}

// Etc위젯들
extension EtcWidgets on HomePageState {
  // 아바타 리스트 보여주기
  Widget _buildAppAvatarList() {
    var lstAvatar = <Widget>[
      buildAvatar(
          "https://play-lh.googleusercontent.com/XrizX1_DQvPyXwWkyJEgZwC7f8P8vRzq3l8c6yd32VZVcpQ423Wb-y0s0pCe8q3F1eP8=w240-h480-rw"),
      buildAvatar(
          "https://play-lh.googleusercontent.com/1WxLS_Mgb6IUMrfkbJ1gBVhiL4_CG2sSCl0UecUSXsolyPQz6jEV51BuLKnKdlPx9rI=w240-h480-rw"),
      buildAvatar(
          "https://play-lh.googleusercontent.com/QoNk1z5drgx2aFmZr_rUO12d4e1JoxDtZ3ox12eJxo65FCAViSEmuH8IVuDUg7NYcENM=w240-h480-rw"),
      buildAvatar(
          "https://play-lh.googleusercontent.com/_KQmCFqljdTLe51CzWaE4d64jBLapkdF7hsthymCFYMlt3UtIR1HX3tGXj-QYg_eOw=w240-h480-rw"),
      buildAvatar(
          "https://play-lh.googleusercontent.com/6WW-nmZQ_MTkALEVT9HAFg-jRHitSdWIcxWHeS2Lak_TWL0VibRlnZjM2MLJ71fqlO8=w240-h480-rw"),
      buildAvatar(
          "https://play-lh.googleusercontent.com/bk7RMkKMcPuv4OU_gc1iTW4fuOK4tBfW970xHdMArLInAxgvBtri_bvCljb1a5eEfA=w240-h480-rw"),
      buildAvatar(
          "https://play-lh.googleusercontent.com/vS48CuRkPP92bF-CmaAwovmj7PTgKMjWG0b4sC4_PIcEgvopyIoaGI8GePv7TAiHaw=s64-rw")
    ];

    var lstAvatarDesc = <String>[
      "통화노트",
      "crazy 모닝콜",
      "battery history",
      "shorcut launcher",
      "kotlin 배우기 - github",
      "외주개발이야기",
      "누구나 쉬운 산수 +-"
    ];

    var children = <TimelineItem>[];
    var indx = 0;
    lstAvatar.forEach((element) {
      children.add(TimelineItem(
          child: Text(
            lstAvatarDesc[indx],
            style: TextStyle(color: Colors.white),
          ),
          indicator: element));
      indx++;
    });

    return Container(
      margin: EdgeInsets.all(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
            padding: EdgeInsets.all(5),
            color: Color(0x1AFFFFF0),
            child: Timeline(
              children: children,
              lineColor: Colors.white,
            )),
      ),
    );
  }

  // github 버튼 위젯
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
          Util.shareUrl("https://github.com/VintageAppMaker/");
        },
        backgroundColor: Colors.white,
        shape: StadiumBorder(
            side: BorderSide(
          width: 0,
          color: Colors.grey,
        )));
  }

  // 카드배경 위젯
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
              SizedBox(
                height: 10,
              ),
              _buildAppAvatarList(),
              SizedBox(
                height: 10,
              ),
              if (kIsWeb)
                Text(
                  "Web의 경우 CORS로 인해 \n다른 사이트의 이미지 로딩이 되지 않음",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                )
            ],
          )),
    );
  }
}

// scroll되는 메인영역의 위젯들
extension InScrollWidgets on HomePageState {
  Widget _buildPageView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
          color: Colors.black,
          child: FutureBuilder(
            future: _getYoutubeData(),
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
              lstYoutube.clear();
              lstYoutube.addAll(snapshot.data);

              return PageView.builder(
                  itemCount: lstYoutube.length,
                  controller: _pageController,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Util.shareUrl(lstYoutube[index].link);
                        },
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Center(
                                          child: Text(
                                        "${lstYoutube[index].title}",
                                        overflow: TextOverflow.fade,
                                        maxLines: 1,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.grey),
                                      ))))
                            ],
                          ),
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
                      Util.shareUrl(getLink(index));
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
                      Util.shareUrl(getLink(index));
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
}
