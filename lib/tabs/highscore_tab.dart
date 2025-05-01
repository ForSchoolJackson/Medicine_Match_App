import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../providers/provider_game.dart';
import '../theme.dart';

class HighscoreTab extends StatefulWidget {
  const HighscoreTab({super.key});

  @override
  HighscoreTabState createState() => HighscoreTabState();
}

class HighscoreTabState extends State<HighscoreTab> {
  List<int> highScores = [];

  @override
  void initState() {
    super.initState();
    loadHighScores();
  }

  // Load high scores from SharedPreferences
  Future<void> loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedScores = prefs.getStringList('highScores');
    setState(() {
      highScores = savedScores?.map((score) => int.parse(score)).toList() ?? [];
    });
  }

  void refreshScores() {
    loadHighScores();
  }

  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

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
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 21, 3, 49),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'High Scores',
                  style: GameTextStyles.title,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Here is a list of the top ten high scores.',
                  style: GameTextStyles.body,
                ),
                const SizedBox(height: 10),

                // Display the high scores in a scrollable list
                Expanded(
                  child: ListView.builder(
                    itemCount: gameProvider.topHighScores.length,
                    itemBuilder: (context, index) {
                      final score = gameProvider.topHighScores[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 44, 12, 96),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          '$score',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
