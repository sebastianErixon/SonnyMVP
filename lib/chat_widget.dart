import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatWidget extends StatefulWidget {
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

    if (response != null && response.isNotEmpty) {
      setState(() {
        // Add the user message and the assistant's response together
        messages.add({'role': 'user', 'content': message});
        messages.add({'role': 'Sonny', 'content': response});
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final role = messages[index]['role'];
                final content = messages[index]['content'];

                return ListTile(
                  title: Text(
                    '$role: $content',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
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

void main() {
  runApp(MaterialApp(
    home: ChatWidget(),
  ));
}
