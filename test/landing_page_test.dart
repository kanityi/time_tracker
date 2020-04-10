import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/app/landing_page.dart';
import 'package:time_tracker/app/services/auth.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;
  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpLandingPage(WidgetTester tester) async {
    await tester.pumpWidget(Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: LandingPage(),
      ),
    ));
  }
}
