import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//lib
import '../providers/provider_game.dart';
import '../theme.dart';

//tab for score screen (stateful)
class HighscoreTab extends StatefulWidget {
  const HighscoreTab({super.key});

  @override
  _HighscoreTabState createState() => _HighscoreTabState();
}

//state
class _HighscoreTabState extends State<HighscoreTab> {
  List<int> highScores = [];

  //initail
  @override
  void initState() {
    super.initState();
    loadHighScores();
  }

  //load from shared preferences
  Future<void> loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedScores = prefs.getStringList('highScores');
    setState(() {
      highScores = savedScores?.map((score) => int.parse(score)).toList() ?? [];
    });
  }

  //refresh
  void refreshScores() {
    loadHighScores();
  }

  //build
  @override
  Widget build(BuildContext context) {
    final gameProvider = Provider.of<GameProvider>(context);

    //style
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
                //title
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

                //list of scores
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
                          style: GameTextStyles.body,
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
