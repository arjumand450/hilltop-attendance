import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import '../models/attendance_record.dart';
import 'package:path_provider/path_provider.dart';

class DayTotal {
  final DateTime day;
  final int count;
  DayTotal(this.day, this.count);
}

class ReportProvider extends ChangeNotifier {
  final Box<AttendanceRecord> _box;
  ReportProvider(this._box);

  List<DayTotal> days = [];
  double loadSeconds = 0;
  bool isLoading = false;

  int get todayCount => days.isEmpty ? 0 : days.last.count;

  
  Future<void> load() async {
    isLoading = true;
    notifyListeners();

    final sw = Stopwatch()..start();

    final now = DateTime.now();
    final sets = <DateTime, Set<String>>{};
    for (int i = 6; i >= 0; i--) {
      sets[DateTime(now.year, now.month, now.day - i)] = <String>{};
    }
    for (final r in _box.values) {
      final key = DateTime(r.date.year, r.date.month, r.date.day);
      sets[key]?.add(r.staffId); 
    }
    days = sets.entries.map((e) => DayTotal(e.key, e.value.length)).toList();

    sw.stop();
    loadSeconds = sw.elapsedMilliseconds / 1000;

    await _writeLog();

    isLoading = false;
    notifyListeners();
  }

  Future<void> _writeLog() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/performance_log.txt');
      final line =
          '${DateTime.now().toIso8601String()} - Load time: ${loadSeconds.toStringAsFixed(3)} s\n';
      await file.writeAsString(line, mode: FileMode.append);
    } catch (e) {
      debugPrint('Could not write performance log: $e');
    }
  }
}