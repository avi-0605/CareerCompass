import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:career_compass/app/app.dart';

class TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = TestHttpOverrides();
  });

  testWidgets('CareerCompassApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CareerCompassApp());
    // Drain pending timers from mock async delays
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(CareerCompassApp), findsOneWidget);
  });
}
