import 'dart:io';
import 'package:hive/hive.dart';
import 'package:hilltop_attendance/models/staff.dart';
import 'package:hilltop_attendance/populate.dart';

Future<void> main() async {
  Hive.init(Directory('hive_data').absolute.path);
  Hive.registerAdapter(StaffAdapter());
  final box = await Hive.openBox<Staff>('staff');
  await populateStaff(box);
  print('Staff in box: ${box.length}');
  await Hive.close();
}