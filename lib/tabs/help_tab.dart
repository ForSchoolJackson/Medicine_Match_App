import 'package:flutter/material.dart';

import '../theme.dart';

class HelpTab extends StatelessWidget {
  const HelpTab({super.key});

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
          //scroll
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 21, 3, 49),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Help',
                    style: GameTextStyles.title,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Here you can find information and help about the game.',
                    style: GameTextStyles.body,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '''
How to play?:

- Match pairs of cards to earn points.
- Use the button in the top corner to pause the game.
- Customize sound settings in the settings tab.
- Track your scores with the highscores tab.

Quickly catch them all!
                    ''',
                    style: GameTextStyles.body,
                  ),
                  const SizedBox(height: 40),
                  // Center the button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor:
                            const Color.fromARGB(255, 44, 12, 96), // Text color
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => const DocumentationTab()),
                        );
                      },
                      child: const Text('Open Documentation'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DocumentationTab extends StatelessWidget {
  const DocumentationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Documentation',
          style: GameTextStyles.bar,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(20),
          child: const SingleChildScrollView(
            child: Text(
              '''
Welcome to the documentation for Medicine Match!

- Match cards to earn points.
- Use the pause button to stop the game.
- Settings allow you to customize sound and difficulty.
- High Scores will track your best runs.

Built with Flutter + Flame.
          ''',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
