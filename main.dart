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
        apiKey: "AIzaSyA7ULBfHKEW93SXyr8CHeA63WFPHqyspvw",
        authDomain: "citizenpower-6b647.firebaseapp.com",
        projectId: "citizenpower-6b647",
        storageBucket: "citizenpower-6b647.firebasestorage.app",
        messagingSenderId: "50474846301",
        appId: "1:50474846301:web:4942dde8c9a32ddc77e5b4",
        measurementId: "G-4ZFYKY7291",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  
  // Hive initialization (skip for web)
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
