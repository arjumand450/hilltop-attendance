import 'package:hive/hive.dart';

part 'attendance_record.g.dart';

@HiveType(typeId: 1)
class AttendanceRecord extends HiveObject {
  @HiveField(0)
  final String staffId;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final DateTime checkInTime;

  AttendanceRecord({
    required this.staffId,
    required this.date,
    required this.checkInTime,
  });
}