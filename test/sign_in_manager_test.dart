import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:time_tracker/app/bloc/sign_in_manager.dart';
import 'package:time_tracker/app/services/auth.dart';

import 'singin_form_test.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);

  List<T> values = [];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

void main() {
  MockAuth mockAuth;
  MockValueNotifier<bool> isLoading;
  SignInManager signInManager;

  setUp(() {
    mockAuth = MockAuth();
    isLoading = MockValueNotifier(false);
    signInManager = SignInManager(auth: mockAuth, isLoading: isLoading);
  });

  test('sign-in - success', () async {
    when(mockAuth.signInAnonymously())
        .thenAnswer((_) => Future.value(User(uid: '123')));
    await signInManager.signInAnonymously();

    expect(isLoading.values, [true]);
  });

  test('sign-in - failure', () async {
    when(mockAuth.signInAnonymously())
        .thenThrow(PlatformException(code: 'ERROR', message: 'Sign in failed'));
    try {
      await signInManager.signInAnonymously();
    } catch (e) {
      expect(isLoading.values, [true, false]);
    }
  });
}
