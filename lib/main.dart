import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Home.dart'; // Import the Home page
import 'Konto.dart'; // Import the Konto page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeData _currentTheme = ThemeData.light();

  void _toggleTheme() {
    setState(() {
      _currentTheme = _currentTheme == ThemeData.light()
          ? ThemeData.dark()
          : ThemeData.light();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: _currentTheme,
      home: ChatWidget(
        toggleTheme: _toggleTheme,
      ),
      routes: {
        '/home': (context) => const Home(), // Add route for Home page
        '/konto': (context) => const Konto(), // Add route for Konto page
      },
    );
  }
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key, required this.toggleTheme}) : super(key: key);

  final Function toggleTheme;

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  final List<Map<String, String>> messages = [];
  final String openAiKey =
      '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';
  final TextEditingController _messageController = TextEditingController();

  Future<String> chatGPTAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAiKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": prompt},
          ],
        }),
      );

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }

  void _sendMessage() async {
    final message = _messageController.text;
    if (message.isEmpty) return;

    final response = await chatGPTAPI(message);

    if (response.isNotEmpty) {
      setState(() {
        // Add the user message and the assistant's response together
        messages.add({'role': 'user', 'content': message});
        messages.add({'role': 'Assistant', 'content': response});
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonny', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: () {
              // Call the toggleTheme function in MyApp
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final role = messages[index]['role'];
                final content = messages[index]['content'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: role == 'user'
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: role == 'user' ? Colors.grey[300] : Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        content!,
                        style: TextStyle(
                          color: role == 'user' ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
