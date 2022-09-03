import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// 아바타
Widget buildAvatar(String url){
  return Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: NetworkImage(
                url),
            fit: BoxFit.scaleDown)),
  );
}

// 아바타 횡스크롤 리스트
Widget buildHorizontalAvatarList(List <Widget> avaList){
  return Container(
    margin: EdgeInsets.all(10.0),
    height: 80.0,
    child: ListView.separated(
      itemCount: avaList.length,
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 10,
        );
      },
      itemBuilder: (_, i) => avaList[i],
      scrollDirection: Axis.horizontal,
    ),
  );
}

// 흑백처리
Widget buildBWWidget({required Widget child, int spec = 0}) {
  const ColorFilter sepia = ColorFilter.matrix(<double>[
    0.393,
    0.769,
    0.189,
    0,
    0,
    0.349,
    0.686,
    0.168,
    0,
    0,
    0.272,
    0.534,
    0.131,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);

  const ColorFilter bw = ColorFilter.mode(Colors.grey, BlendMode.saturation);
  return ColorFiltered(
    colorFilter: (spec == 0) ? bw : sepia,
    child: child,
  );
}
