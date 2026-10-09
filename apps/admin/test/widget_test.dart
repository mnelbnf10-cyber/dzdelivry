import 'package:flutter_test/flutter_test.dart';
import 'package:dzdelivery_admin/main.dart';

void main() {
  testWidgets('app shows its sign-in screen', (tester) async {
    await tester.pumpWidget(const AdminApp());
    expect(find.text('DzDelivery Admin'), findsWidgets);
  });
}
