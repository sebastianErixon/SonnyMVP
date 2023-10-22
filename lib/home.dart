import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController goalsController = TextEditingController();
  TextEditingController dagbokController = TextEditingController();
  TextEditingController remindersController = TextEditingController();
  TextEditingController libraryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Remove the app bar
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dina Mål',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: TextFormField(
                  controller: goalsController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Enter your goals',
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Dagbok',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: TextFormField(
                  controller: dagbokController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Enter your diary',
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Påminelser',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: TextFormField(
                  controller: remindersController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Enter your reminders',
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Bibliotek',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: TextFormField(
                  controller: libraryController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Enter your library items',
                    border: InputBorder.none,
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
