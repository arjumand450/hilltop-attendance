import 'package:flutter_test/flutter_test.dart';
import 'package:hilltop_attendance/providers/auth_provider.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('login succeeds with correct credentials', () async {
    final auth = AuthProvider();
    final ok = await auth.login('ayesha@hilltop.com', 'ayesha123');
    expect(ok, true);
    expect(auth.isLoggedIn, true);
    expect(auth.userName, 'Ayesha Khan');
  });

  test('login fails with wrong password', () async {
    final auth = AuthProvider();
    final ok = await auth.login('ayesha@hilltop.com', 'wrong');
    expect(ok, false);
    expect(auth.isLoggedIn, false);
    expect(auth.error, 'Wrong email or password');
  });
}