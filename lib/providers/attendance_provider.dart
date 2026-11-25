import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/staff.dart';
import '../models/attendance_record.dart';

class AttendanceProvider extends ChangeNotifier {
  final Box<Staff> _staffBox;
  final Box<AttendanceRecord> _attendanceBox;

  AttendanceProvider(this._staffBox, this._attendanceBox);

  
  List<Staff> get staff => _staffBox.values.toList();

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  
  AttendanceRecord? todayRecordFor(String staffId) {
    final now = DateTime.now();
    for (final r in _attendanceBox.values) {
      if (r.staffId == staffId && _isSameDay(r.date, now)) return r;
    }
    return null;
  }

  bool hasCheckedInToday(String staffId) => todayRecordFor(staffId) != null;

  
  int get presentToday {
    final now = DateTime.now();
    return _attendanceBox.values
        .where((r) => _isSameDay(r.date, now))
        .map((r) => r.staffId)
        .toSet()
        .length;
  }

  Future<void> checkIn(Staff s) async {
    if (hasCheckedInToday(s.id)) return; 
    final now = DateTime.now();
    await _attendanceBox.add(
      AttendanceRecord(
        staffId: s.id,
        date: DateTime(now.year, now.month, now.day),
        checkInTime: now,
      ),
    );
    notifyListeners(); 
  }
}