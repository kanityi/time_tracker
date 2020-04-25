import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/home/home_page.dart';
import 'package:time_tracker/app/landing_page.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/sign_in_page.dart';
import 'mocks.dart';

void main() {
  MockAuth mockAuth;
  StreamController<User> onAuthChangedController;

  setUp(() {
    mockAuth = MockAuth();
    onAuthChangedController = StreamController<User>();
  });

  tearDown(() {
    onAuthChangedController.close();
  });

  Future<void> pumpLandingPage(WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: LandingPage(),
      ),
    ));

    await tester.pump();
  }

  void stubOnAuthStateChangedYields(Iterable<User> onAuthStateChanged) {
    onAuthChangedController
        .addStream(Stream<User>.fromIterable(onAuthStateChanged));
    when(mockAuth.onAuthStateChanged).thenAnswer((_) {
      return onAuthChangedController
          .stream; //fromIterable converts iterable to stream
    });
  }

  testWidgets('stream waiting', (WidgetTester tester) async {
    stubOnAuthStateChangedYields([]);

    await pumpLandingPage(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('null user', (WidgetTester tester) async {
    stubOnAuthStateChangedYields([null]);

    await pumpLandingPage(tester);
    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('non-null user', (WidgetTester tester) async {
    stubOnAuthStateChangedYields([User(uid: '123')]);

    await pumpLandingPage(tester);
    expect(find.byType(HomePage), findsOneWidget);
  });
}