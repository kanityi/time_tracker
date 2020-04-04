import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker/app/models/email_sign_in_model.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/enums/email_sign_type.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  void updateWith({
    String email,
    String password,
    EmailSigninFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    //update  model
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    //add updated model to model controller
    _modelController.add(_model);
  }

  void togleFormType() {
    final formType = _model.formType == EmailSigninFormType.signIn
        ? EmailSigninFormType.register
        : EmailSigninFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      submitted: false,
      isLoading: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      //await Future.delayed(Duration(seconds: 3));
      if (_model.formType == EmailSigninFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}
