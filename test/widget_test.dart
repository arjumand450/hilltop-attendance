import 'package:flutter_test/flutter_test.dart';
import 'package:hilltop_attendance/main.dart';

void main() {
  testWidgets('Welcome screen shows title and Login button', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Hilltop Guest House Staff Attendance'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}