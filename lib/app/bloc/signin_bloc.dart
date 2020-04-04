import 'dart:async';
import 'package:flutter/foundation.dart';

import '../services/auth.dart';

class SignInBloc {
  SignInBloc({@required this.auth});
  final AuthBase auth;
  StreamController<bool> _isLoadingStreamController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingStreamController.stream;
  void _setIsLoading(bool isLoading) =>
      _isLoadingStreamController.add(isLoading);

  void dispose() {
    _isLoadingStreamController.close();
  }

  Future<User> _signIn(Future<User> Function() signinMethod) async {
    try {
      _setIsLoading(true);
      return await signinMethod();
    } catch (e) {
      _setIsLoading(false);
      rethrow;
    }
  }
  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);
  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
  Future<User> signInWithFacsebook() async =>
      await _signIn(auth.signInWithFacsebook);
}
