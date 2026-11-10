import 'package:hive/hive.dart';
import 'models/staff.dart';

final _sampleStaff = [
  Staff(id: 'S001', name: 'Ayesha Khan', role: 'Front Desk Manager'),
  Staff(id: 'S002', name: 'Bilal Ahmed', role: 'Head Chef'),
  Staff(id: 'S003', name: 'Sana Malik', role: 'Housekeeping Supervisor'),
  Staff(id: 'S004', name: 'Usman Tariq', role: 'Security Guard'),
  Staff(id: 'S005', name: 'Hina Raza', role: 'Receptionist'),
];

/// Adds sample staff only if the box is empty, so restarts never duplicate.
Future<void> populateStaff(Box<Staff> box) async {
  if (box.isNotEmpty) return;
  for (final s in _sampleStaff) {
    await box.put(s.id, s);
  }
}