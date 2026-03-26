import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'services/storage_service.dart';
import '../models/note.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool hasPin = await StorageService.hasPin();
  runApp(MyApp(hasPin: hasPin));
}

class MyApp extends StatelessWidget {
  final bool hasPin;

  const MyApp({super.key, required this.hasPin});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secure Notes',
      theme: ThemeData.dark(),
      home: LoginScreen(isFirstTime: !hasPin),
    );
  }
}