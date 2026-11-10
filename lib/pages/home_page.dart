import 'package:flutter/material.dart';
import 'package:hilltop_attendance/models/staff.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Center(
        child: Padding(padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/logo.png",width: 120, height: 120,),
            SizedBox(height: 24,),
            Text("Hilltop Guest House Staff Attendance",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 48),
              ),
              onPressed: () => Navigator.pushNamed(context, '/login'), 
              child: Text("Login")),

              SizedBox(height: 16),
SizedBox(
  height: 200,
  child: ValueListenableBuilder<Box<Staff>>(
    valueListenable: Hive.box<Staff>('staff').listenable(),
    builder: (context, box, _) => ListView(
      children: box.values
          .map((s) => ListTile(title: Text(s.name), subtitle: Text(s.role)))
          .toList(),
    ),
  ),
),
          ],
        ),
        ),
        
      )),
    );
  }
}