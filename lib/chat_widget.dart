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

  void _showOptionsModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Option 1'),
                onTap: () {
                  Navigator.pop(context); // Close the modal sheet
                  // Implement action for Option 1
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Option 2'),
                onTap: () {
                  Navigator.pop(context); // Close the modal sheet
                  // Implement action for Option 2
                },
              ),
              // Add more options as needed
            ],
          ),
        );
      },
    );
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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _showOptionsModal(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Grey color
                      //shape: BoxShape.rectangle, // Make the button a rectangle
                    ),
                    child: const Icon(
                      Icons.grid_view_sharp,
                      color: Colors.blueGrey,
                      size: 24.0,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    _showOptionsModal(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[300], // Grey color
                      shape: BoxShape.circle, // Make the button circular
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.blueGrey,
                      size: 24.0,
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20.0,
                        ),
                        suffixIcon: InkWell(
                          onTap: _sendMessage,
                          child: Container(
                            width:
                                36.0, // Adjust the size of the button as needed
                            height: 36.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue, // Button background color
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_upward,
                                color: Colors.white, // Icon color
                                size: 25.0, // Icon size
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
