import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CounterBloc extends ChangeNotifier {
  StreamSubscription _counter;

  int _countDown = 0;
  int get countDown => _countDown;
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
    _countDown = 10;
    _counter?.cancel();
    _counter = Observable.periodic(Duration(seconds: 1)).startWith(_countDown).take(_countDown).listen((onData) {
      _setCountDown(countDown - 1);
    });
  }

  @override
  void dispose() {
    _counter?.cancel();
    super.dispose();
  }
}
