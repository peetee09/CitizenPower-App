import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:citizenpower/screens/home_screen.dart';
import 'package:citizenpower/services/auth_service.dart';
import 'package:citizenpower/services/report_service.dart';
import 'package:citizenpower/services/location_service.dart';
import 'package:citizenpower/services/offline_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox('offlineReports');
  
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthService()),
        RepositoryProvider(create: (context) => ReportService()),
        RepositoryProvider(create: (context) => LocationService()),
        RepositoryProvider(create: (context) => OfflineService()),
      ],
      child: const CitizenPowerApp(),
    ),
  );
}

class CitizenPowerApp extends StatelessWidget {
  const CitizenPowerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CitizenPower',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accessibilityFeatures: const [AccessibilityFeatures.invertColors],
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}