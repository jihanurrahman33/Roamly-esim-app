import 'package:flutter_test/flutter_test.dart';
import 'package:esim_app/main.dart';

void main() {
  testWidgets('Roamly app basic smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const RoamlyApp());
    await tester.pumpAndSettle();
    expect(find.byType(RoamlyApp), findsOneWidget);
  });
}
