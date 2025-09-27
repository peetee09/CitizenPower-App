import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:citizenpower/screens/home_screen.dart';
import 'package:citizenpower/services/auth_service.dart';
import 'package:citizenpower/services/report_service.dart';
import 'package:citizenpower/services/location_service.dart';
import 'package:citizenpower/services/offline_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configure Firebase for web vs mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "YOUR_API_KEY",
        authDomain: "YOUR_PROJECT.firebaseapp.com",
        projectId: "YOUR_PROJECT_ID",
        storageBucket: "YOUR_PROJECT.appspot.com",
        messagingSenderId: "YOUR_SENDER_ID",
        appId: "YOUR_APP_ID",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  
  // Hive initialization (skip for web or use alternative)
  if (!kIsWeb) {
    await Hive.initFlutter();
    await Hive.openBox('offlineReports');
  }
  
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
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
