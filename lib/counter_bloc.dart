import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CounterBloc extends ChangeNotifier {
  StreamSubscription _counter;//用于保存listener

  //用于保存当前倒计时
  int _countDown = 0;
  int get countDown => _countDown;//对外只读,避免外部更改
  _setCountDown(int countDown) {
    if (_countDown == countDown) {
      return;
    }
    _countDown = countDown;
    notifyListeners();
  }

  //发送验证码
  Future<void> sendVerifyCode(BuildContext context) async {
    print('开始倒计时');
    _countDown = 6;//初始化倒计时
    _counter?.cancel();//先将上一个计时器(如果有)取消掉
    _counter = Observable.periodic(Duration(seconds: 1))//生成一个1秒间隔的定时器
    .startWith(_countDown)//以初始化的时间开始
    .take(_countDown)//取前n次的时间
    .listen((onData) {
      _setCountDown(countDown - 1);
    });
  }

  @override
  void dispose() {
    _counter?.cancel();//页面移除后,也要移除计时器
    super.dispose();
  }
}
