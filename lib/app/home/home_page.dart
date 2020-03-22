import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  HomePage({@required this.onSignOut, @required this.auth});
    final VoidCallback onSignOut;
    Future<void> _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e.toString());
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
