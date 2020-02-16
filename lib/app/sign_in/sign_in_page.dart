import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  Widget buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          RaisedButton(
            child: Text(
              'Sign in with google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.0
              ),
            ),
            onPressed: () {
              print('button pressed');
            },
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signInWithGoogle() {
    //TODO: Auth for google
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }
}
