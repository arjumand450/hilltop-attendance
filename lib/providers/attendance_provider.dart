import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/staff.dart';
import '../models/attendance_record.dart';

class AttendanceProvider extends ChangeNotifier {
  final Box<Staff> _staffBox;
  final Box<AttendanceRecord> _attendanceBox;

  AttendanceProvider(this._staffBox, this._attendanceBox);

  /// All staff, read from the Hive staff box.
  List<Staff> get staff => _staffBox.values.toList();

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  /// Today's record for one staff member, or null if not checked in yet.
  AttendanceRecord? todayRecordFor(String staffId) {
    final now = DateTime.now();
    for (final r in _attendanceBox.values) {
      if (r.staffId == staffId && _isSameDay(r.date, now)) return r;
    }
    return null;
  }

  bool hasCheckedInToday(String staffId) => todayRecordFor(staffId) != null;

  /// Number of different staff members who checked in today.
  int get presentToday {
    final now = DateTime.now();
    return _attendanceBox.values
        .where((r) => _isSameDay(r.date, now))
        .map((r) => r.staffId)
        .toSet()
        .length;
  }

  Future<void> checkIn(Staff s) async {
    if (hasCheckedInToday(s.id)) return; // no double check-in
    final now = DateTime.now();
    await _attendanceBox.add(
      AttendanceRecord(
        staffId: s.id,
        date: DateTime(now.year, now.month, now.day),
        checkInTime: now,
      ),
    );
    notifyListeners(); // counter and buttons update instantly
  }
}