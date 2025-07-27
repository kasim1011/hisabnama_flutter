// lib/main.dart
import 'package:flutter/material.dart';
import 'package:hisabnama_flutter/services/database_service.dart';
import 'package:hisabnama_flutter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database service
  final databaseService = DatabaseService();
  await databaseService.init();

  runApp(const HisabnamaApp());
}

class HisabnamaApp extends StatelessWidget {
  const HisabnamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hisabnama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
