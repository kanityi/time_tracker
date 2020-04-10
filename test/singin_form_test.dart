import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_form_stateful.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;
  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester tester,
      {VoidCallback onSignedIn}) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: Scaffold(
          body: EmailSignInFormStateful(
            onSignedIn: onSignedIn,
          ),
        ),
      ),
    ));
  }

  void stubSignInWithEmailAndPasswordSuccess() {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenAnswer((_) => Future<User>.value(User(uid: '123')));
  }

  void stubSignInWithEmailAndPasswordThrows() {
    when(mockAuth.signInWithEmailAndPassword(any, any))
        .thenThrow(PlatformException(code: 'ERROR_WRONG_PASSWORD'));
  }

  group('sign in', () {
    testWidgets(
        'When user does not enter email and password, signInWithEmailAndPassword is not called and user is not signed in',
        (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);
      verifyNever(mockAuth.signInWithEmailAndPassword(any, any));
      expect(signedIn, false);
    });

    testWidgets(
        'When user enters email and password, signInWithEmailAndPassword is called and user is signed in',
        (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      stubSignInWithEmailAndPasswordSuccess();
      const email = 'email@gmail.com';
      const password = 'password';

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump(); //rebuild or update widgets
      //await tester.pumpAndSettle(); -For animations that are in progress

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, true);
    });

    testWidgets(
        'When user enters an invalid email and password, signInWithEmailAndPassword is called and user is not signed in',
        (WidgetTester tester) async {
      var signedIn = false;
      await pumpEmailSignInForm(tester, onSignedIn: () => signedIn = true);

      stubSignInWithEmailAndPasswordThrows();
      const email = 'email@gmail.com';
      const password = 'password';

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump(); //rebuild or update widgets
      //await tester.pumpAndSettle(); -For animations that are in progress

      final signInButton = find.text('Sign in');
      await tester.tap(signInButton);

      verify(mockAuth.signInWithEmailAndPassword(email, password)).called(1);
      expect(signedIn, false);
    });
  });
  group('Register', () {
    testWidgets('When user secondary button then form toggles to register mode',
        (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      final registerButton = find.text('Do not have an account? Register');
      await tester.tap(registerButton);

      await tester.pump();
      final createAccountButton = find.text('Create an Account');
      expect(createAccountButton, findsOneWidget);
    });

    testWidgets(
        'When user secondary button then form toggles to register mode and enters email and password to register, createUserWithEmail is called',
        (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      const email = 'email@gmail.com';
      const password = 'password';

      final registerButton = find.text('Do not have an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      final emailField = find.byKey(Key('email'));
      expect(emailField, findsOneWidget);
      await tester.enterText(emailField, email);

      final passwordField = find.byKey(Key('password'));
      expect(passwordField, findsOneWidget);
      await tester.enterText(passwordField, password);

      await tester.pump(); //rebuild or update widgets
      //await tester.pumpAndSettle(); -For animations that are in progress

      final createAccountButton = find.text('Create an Account');
      expect(createAccountButton, findsOneWidget);
      await tester.tap(createAccountButton);

      verify(mockAuth.createUserWithEmailAndPassword(email, password))
          .called(1);
    });
  });
}
