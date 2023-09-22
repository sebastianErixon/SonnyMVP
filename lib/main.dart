import 'package:flutter/material.dart';
import 'chat_widget.dart'; // Import the ChatWidget from your new file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatWidget(), // Use ChatWidget as the default widget
    );
  }
}
