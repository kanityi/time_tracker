import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/index.dart';

class AuthProviderPage extends StatefulWidget {
  static const String routeName = '/authProvider';

  @override
  _AuthProviderPageState createState() => _AuthProviderPageState();
}

class _AuthProviderPageState extends State<AuthProviderPage> {
  final _authProviderBloc = AuthProviderBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AuthProvider'),
      ),
      body: AuthProviderScreen(authProviderBloc: _authProviderBloc),
    );
  }
}
