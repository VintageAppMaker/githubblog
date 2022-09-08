import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:githubblogapp/Util.dart';
import 'package:githubblogapp/server/getmarkdown.dart';
import 'package:githubblogapp/states/providers.dart';
import "package:provider/provider.dart";

class AboutPage extends StatefulWidget {
  @override
  AboutPageState createState() {
    return AboutPageState();
  }
}

class AboutPageState extends State<AboutPage> {
  String sData = "";
  @override
  void initState() {
    super.initState();
    MDApi.getGithubMD((s){
      setState(() {
        sData = s as String;
        print(sData);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10), color: Colors.black,
        child: Container(
            padding: EdgeInsets.all(10),
            color: Color(0xffF3F3F4),
            child: Markdown(
                data: sData,
                onTapLink: (text, url, title){
                  Util.shareUrl(url ?? "");
                },
            )
        )
    );
  }
}
