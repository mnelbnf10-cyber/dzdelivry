
import 'package:flutter_test/flutter_test.dart';
import 'package:customer/main.dart';

void main() {
  testWidgets('DzDelivery customer app loads', (WidgetTester tester) async {
    await tester.pumpWidget(const DzDeliveryApp());

    expect(find.text('DzDelivery'), findsWidgets);
  });
}
