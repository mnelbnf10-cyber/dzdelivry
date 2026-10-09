
import 'package:flutter_test/flutter_test.dart';
import 'package:admin/main.dart';

void main() {
  testWidgets('DzDelivery Admin app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const DzDeliveryAdmin());

    expect(find.text('DzDelivery'), findsOneWidget);
    expect(find.text('لوحة الإدارة'), findsOneWidget);
  });
}
