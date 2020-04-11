import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/bloc/sign_in_manager.dart';
import 'package:time_tracker/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker/app/services/auth.dart';
import '../sign_in/email_sign_in_page.dart';
import '../sign_in/sign_in_button.dart';
import '../sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({@required this.manager, @required this.isLoading});
  final SignInManager manager;
  final bool isLoading;

  static const Key emailPasswordKey = Key('email-password');
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (context, isLoading, _) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (context, manager, _) => SignInPage(
              isLoading: isLoading.value,
              manager: manager,
            ),
          ),
        ),
      ),
    );
  }

  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in failed',
      exception: exception,
    ).show(context);
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacsebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSigninPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 60.0),
            SizedBox(
              height: 50.0,
              child: _buildHeader(),
            ),
            SizedBox(height: 48.0),
            SocialSignInButton(
              assetName: 'images/google-logo.png',
              text: 'Sign in with Google',
              textColor: Colors.black87,
              color: Colors.white,
              onPressed: () => isLoading ? null : _signInWithGoogle(context),
            ),
            SizedBox(height: 8.0),
            SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: 'Sign in with Facebook',
              textColor: Colors.white,
              color: Color(0xFF334D92),
              onPressed: () => isLoading ? null : _signInWithFacebook(context),
            ),
            SizedBox(height: 8.0),
            SignInButton(
              key: emailPasswordKey,
              text: 'Sign in with Email',
              textColor: Colors.white,
              color: Colors.teal[700],
              onPressed: () => isLoading ? null : _signInWithEmail(context),
            ),
            SizedBox(height: 8.0),
            Text(
              'Or',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.0),
            SignInButton(
              text: 'Go anonynous',
              textColor: Colors.black,
              color: Colors.lime[300],
              onPressed: () => isLoading ? null : _signInAnonymously(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
