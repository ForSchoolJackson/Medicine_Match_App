import 'package:flutter/material.dart';

import '../theme.dart';

class HighscoreTab extends StatelessWidget {
  const HighscoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1E1E2C), Color(0xFF2E2B5F), Color(0xFF6A62C2)],
          ),
        ),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 3, 49),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'High Scores will appear here',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}