import 'package:flutter_test/flutter_test.dart';

import 'package:slotbase/main.dart';

void main() {
  testWidgets('App loads login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('UG Facility Booking'), findsOneWidget);
  });
}
