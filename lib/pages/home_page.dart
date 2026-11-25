import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/logo.png', width: 120, height: 120),
                const SizedBox(height: 24),
                const Text(
                  'Hilltop Guest House Staff Attendance',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                if (auth.isLoggedIn) ...[
                  Text(
                    'Welcome, ${auth.userName}!',
                    style: const TextStyle(fontSize: 18),
                  ),

                                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 48),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/checkin'),
                    child: const Text('Staff Check-in'),
                  ),

                                    const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 48),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/report'),
                    child: const Text('Attendance Report'),
                  ),

                  const SizedBox(height: 24),
                  OutlinedButton(
  onPressed: () {
    context.read<AuthProvider>().logout();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  },
  child: const Text('Logout'),
),
                ] else ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(200, 48),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    child: const Text('Login'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}