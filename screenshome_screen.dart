import 'package:flutter/material.dart';
import 'package:citizenpower/screens/report_screen.dart';
import 'package:citizenpower/widgets/category_selector.dart';
import 'package:citizenpower/widgets/emergency_toggle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CitizenPower'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DashboardScreen()),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Report Type?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const EmergencyToggle(),
            const SizedBox(height: 30),
            const Text(
              'Select Category:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const CategorySelector(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportScreen()),
              ),
              child: const Text('Next: Location/Details'),
            ),
          ],
        ),
      ),
    );
  }
}