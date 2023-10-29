import 'package:flutter/material.dart';
import 'navbar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _currentTheme = ThemeData.light();
  bool _isDarkMode = false; // Add this variable

  void _toggleTheme() {
    setState(() {
      _currentTheme = _isDarkMode ? ThemeData.light() : ThemeData.dark();
      _isDarkMode = !_isDarkMode; // Toggle the dark mode state
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sonny',
      theme: _currentTheme,
      home: NavBar(
        toggleTheme: _toggleTheme,
      ),
    );
  }
}
