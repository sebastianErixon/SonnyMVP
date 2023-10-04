import 'package:flutter/material.dart';

class Konto extends StatelessWidget {
  const Konto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konto Page'),
      ),
      body: const Center(
        child: Text('This is the Konto Page'),
      ),
    );
  }
}
