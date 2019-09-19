import 'package:counter_sample/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(CounterSample());

class CounterSample extends StatelessWidget {
  const CounterSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body: Container(
          child: Center(
            child: ChangeNotifierProvider<CounterBloc>(
              builder: (context) => CounterBloc(),
              child: Selector<CounterBloc, int>(
                selector: (context, bloc) => bloc.countDown,
                builder: (context, countDown, child) {
                  CounterBloc bloc = Provider.of<CounterBloc>(context, listen: false);
                  return GestureDetector(
                    child: Container(
                      width: 100,
                      height: 40,
                      child: Center(
                        child: Text(
                          countDown == 0 ? '发送验证码' : countDown.toString(),
                        ),
                      ),
                    ),
                    onTap: countDown == 0
                        ? () {
                            bloc.sendVerifyCode(context);
                          }
                        : null,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
