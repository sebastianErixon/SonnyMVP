import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sonny_app/HomePages/bibliotek.dart';
import 'package:sonny_app/HomePages/dina_mal.dart';
import 'package:sonny_app/HomePages/paminelser.dart';
import 'package:sonny_app/HomePages/dagbok.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SharedPreferences? _prefs;
  TextEditingController goalsController = TextEditingController();
  TextEditingController dagbokController = TextEditingController();
  TextEditingController remindersController = TextEditingController();
  TextEditingController libraryController = TextEditingController();

  void initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void navigateToPage(Widget destination) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    loadUserInput(); // Load saved user input when the widget initializes
  }

  Future<void> saveUserInput() async {
    _prefs?.setString('userGoals', goalsController.text);
    _prefs?.setString('userDagbok', dagbokController.text);
    _prefs?.setString('userReminders', remindersController.text);
    _prefs?.setString('userLibrary', libraryController.text);
  }

  Future<void> loadUserInput() async {
    goalsController.text = _prefs?.getString('userGoals') ?? '';
    dagbokController.text = _prefs?.getString('userDagbok') ?? '';
    remindersController.text = _prefs?.getString('userReminders') ?? '';
    libraryController.text = _prefs?.getString('userLibrary') ?? '';
  }

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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: goalsController,
                  onTap: () {
                    navigateToPage(const DinaMal());
                  },
                  onChanged: (text) {
                    saveUserInput(); // Save user input as it changes
                  },
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: TextFormField(
                  controller: dagbokController,
                  onTap: () {
                    navigateToPage(const Dagbok());
                  },
                  onChanged: (text) {
                    saveUserInput(); // Save user input as it changes
                  },
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: TextFormField(
                  controller: remindersController,
                  onTap: () {
                    navigateToPage(const Paminelser());
                  },
                  onChanged: (text) {
                    saveUserInput(); // Save user input as it changes
                  },
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: TextFormField(
                  controller: libraryController,
                  onTap: () {
                    navigateToPage(const Bibliotek());
                  },
                  onChanged: (text) {
                    saveUserInput(); // Save user input as it changes
                  },
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
