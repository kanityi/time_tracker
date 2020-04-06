import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/common_widgets/platform_alert_dialog.dart';
import 'package:time_tracker/app/services/auth.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final isUserLoggingOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure you want to log out?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Yes',
    ).show(context);
    if (isUserLoggingOut) {
      _signOut(context);
      print('User is loggingout');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Account'),
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
