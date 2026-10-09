import 'package:flutter_test/flutter_test.dart';
import 'package:dzdelivery_customer/main.dart';

void main() {
  testWidgets('app shows its sign-in screen', (tester) async {
    await tester.pumpWidget(const App());
    expect(find.text('DzDelivery'), findsWidgets);
  });
}
