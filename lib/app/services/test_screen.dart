import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_tracker/app/services/index.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({
    Key key,
    @required TestBloc testBloc,
  })  : _testBloc = testBloc,
        super(key: key);

  final TestBloc _testBloc;

  @override
  TestScreenState createState() {
    return TestScreenState();
  }
}

class TestScreenState extends State<TestScreen> {
  TestScreenState();

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestBloc, TestState>(
        bloc: widget._testBloc,
        builder: (
          BuildContext context,
          TestState currentState,
        ) {
          if (currentState is UnTestState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorTestState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage ?? 'Error'),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ));
          }
           if (currentState is InTestState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(currentState.hello),
                  Text('Flutter files: done'),
                  Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text('throw error'),
                      onPressed: () => this._load(true),
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
              child: CircularProgressIndicator(),
          );
          
        });
  }

  void _load([bool isError = false]) {
    widget._testBloc.add(LoadTestEvent(isError));
  }
}
