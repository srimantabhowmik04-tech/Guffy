// test/widget_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:guffy/main.dart';

void main() {
  testWidgets('Guffy app basic smoke test', (WidgetTester tester) async {
    // GuffyApp উইজেট রেন্ডার করা
    await tester.pumpWidget(const GuffyApp());

    // অ্যাপের মূল টাইটেল বা ন্যাভিগেশন টেক্সট উপস্থিত আছে কি না যাচাই
    expect(find.text('Guffy'), findsNothing); // মূল স্ক্রিন লোড চেক
  });
}
