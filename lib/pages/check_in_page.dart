import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/attendance_provider.dart';

class CheckInPage extends StatelessWidget {
  const CheckInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final attendance = context.watch<AttendanceProvider>();
    final staff = attendance.staff;

    return Scaffold(
      appBar: AppBar(title: const Text('Check-in')),
      body: Column(
        children: [
          // Banner at the top
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.blue.shade50,
            child: Text(
              'Present today: ${attendance.presentToday}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Staff list
          Expanded(
            child: staff.isEmpty
                ? const Center(child: Text('No staff found'))
                : ListView.builder(
                    itemCount: staff.length,
                    itemBuilder: (context, index) {
                      final s = staff[index];
                      final record = attendance.todayRecordFor(s.id);
                      final checkedIn = record != null;

                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(s.name[0]),
                        ),
                        title: Text(s.name),
                        subtitle: Text(
                          checkedIn
                              ? '${s.role} • In at ${DateFormat('hh:mm a').format(record.checkInTime)}'
                              : s.role,
                        ),
                        trailing: ElevatedButton(
                          onPressed: checkedIn
                              ? null
                              : () => context
                                  .read<AttendanceProvider>()
                                  .checkIn(s),
                          child: Text(checkedIn ? 'Checked in' : 'Check-in'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}