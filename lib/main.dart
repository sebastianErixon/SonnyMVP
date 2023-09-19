import 'package:flutter/material.dart';
import 'chat_widget.dart'; // Import the ChatWidget from your new file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatWidget(), // Use ChatWidget as the default widget
    );
  }
}
