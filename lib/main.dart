import 'package:flutter/material.dart';
import 'populate.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/staff.dart';
import 'models/attendance_record.dart';

import 'pages/home_page.dart';
import 'pages/login_page.dart';

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
    // Task 3: MultiProvider goes here (login state)
    return MaterialApp(
      title: 'Hilltop Attendance',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/login': (_) => const LoginPage(),
      },
    );
  }
}