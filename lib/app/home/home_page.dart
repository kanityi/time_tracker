import 'package:flutter/material.dart';
import '../common_widgets/platform_alert_dialog.dart';
import '../services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  HomePage({@required this.auth});
  Future<void> _signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final isUserLoggingOut = await PlatformAlertDialog(
      tittle: 'Logout',
      content: 'Are you sure you want to log out?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Yes',
    ).show(context);
    if (isUserLoggingOut) {
      _signOut();
      print('User is loggingout');
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
            onPressed: () => _confirmSignOut(context),
          ),
        ],
      ),
    );
  }
}
