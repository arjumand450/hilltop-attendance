import 'package:flutter/material.dart';
import 'populate.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/staff.dart';
import 'models/attendance_record.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/attendance_provider.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/check_in_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(StaffAdapter());
  Hive.registerAdapter(AttendanceRecordAdapter());
  final staffBox = await Hive.openBox<Staff>('staff');
  await Hive.openBox<AttendanceRecord>('attendance');
  await populateStaff(staffBox);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(
          create: (_) => AttendanceProvider(
            Hive.box<Staff>('staff'),
            Hive.box<AttendanceRecord>('attendance'),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Hilltop Attendance',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        initialRoute: '/login',
                routes: {
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
          '/checkin': (_) => const CheckInPage(),
        },
      ),
    );
  }
}