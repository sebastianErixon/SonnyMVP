import 'package:flutter/material.dart';
import 'chat.dart'; // Import the Chat page
import 'home.dart'; // Import the Home page
import 'konto.dart'; // Import the Konto page

class NavBar extends StatefulWidget {
  final void Function() toggleTheme;

  const NavBar({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const Chat(), // Your Chat page
    Home(), // Your Home page
    const Konto(), // Your Konto page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sonny'), // Change the title here
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: () {
              // Call the toggleTheme function passed from MyApp
              widget.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.extension_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Konto',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
