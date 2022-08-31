import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

// 단순 함수,변수 공유용으로 사용
class GlobalState with ChangeNotifier {
  bool isBottomNavigate = true;
  int nClick = 0;

  // page 이동
  void goPage(int n) {
    isBottomNavigate = false;
    nClick++;
    fnPageMove(n);
  }

  // Function 변수들
  late Function fnPageMove;
  late Function fnPage2_setMesageInfo = (String s) {};
}
