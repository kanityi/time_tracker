import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:time_tracker/app/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker/app/models/email_sign_in_model.dart';
import 'package:time_tracker/app/services/auth.dart';
import '../sign_in/enums/email_sign_type.dart';
import '../common_widgets/form_submit_button.dart';
import 'validation/validators.dart';

class EmailSignInFormStateful extends StatefulWidget
    with EmailAndpasswordValidators {
  EmailSignInFormStateful({Key key, this.onSignedIn}) : super(key: key);
  final VoidCallback onSignedIn;

  @override
  _EmailSignInFormStatefulState createState() =>
      _EmailSignInFormStatefulState();
}

class _EmailSignInFormStatefulState extends State<EmailSignInFormStateful> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  String get _email => _emailController.text;
  String get _password => _passwordController.text;
  EmailSigninFormType _formType = EmailSigninFormType.signIn;
  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      //await Future.delayed(Duration(seconds: 3));
      final auth = Provider.of<AuthBase>(context, listen: false);
      if (_formType == EmailSigninFormType.signIn) {
        await auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await auth.createUserWithEmailAndPassword(_email, _password);
      }
      if (widget.onSignedIn != null) {
        widget.onSignedIn();
      }
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleFOrmType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSigninFormType.signIn
          ? EmailSigninFormType.register
          : EmailSigninFormType.signIn;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSigninFormType.signIn
        ? 'Sign in'
        : 'Create an Account';
    final secondaryText = _formType == EmailSigninFormType.signIn
        ? 'Do not have an account? Register'
        : 'Alredy have an account? Sign in';
    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        _isLoading == false;

    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      SizedBox(height: 8.0),
      FlatButton(
        child: Text(secondaryText),
        onPressed: !_isLoading ? _toggleFOrmType : null,
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      key: Key('password'),
      decoration: InputDecoration(
        labelText: 'Password',
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
        enabled: _isLoading == false,
      ),
      obscureText: true,
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      focusNode: _passwordFocusNode,
      onEditingComplete: _submit,
      onChanged: (password) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      key: Key('email'),
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'name@gmail.com',
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
        enabled: _isLoading == false,
      ),
      controller: _emailController,
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      focusNode: _emailFocusNode,
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: null,
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: _buildChildren(),
            ),
          );
        });
  }

  _updateState() {
    setState(() {});
  }
}
