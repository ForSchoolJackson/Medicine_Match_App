import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// lib
import '../theme.dart';
import '../providers/provider_game.dart';

//tab for settings screen
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

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
                  'Settings',
                  style: GameTextStyles.title,
                ),
                const SizedBox(height: 20),

                //music slider
                const Text(
                  'Music Volume',
                  style: GameTextStyles.body,
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.music_note, color: Colors.white),
                    ),
                    //slider
                    Expanded(
                      child: Slider(
                        value: gameProvider.musicVolume,
                        min: 0,
                        max: 1.0,
                        divisions: 5,
                        label: gameProvider.musicVolume.toStringAsFixed(1),
                        //music volume change
                        onChanged: (value) {
                          gameProvider.musicVolume = value;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                //SFX slider
                const Text(
                  'Sound Effects Volume',
                  style: GameTextStyles.body,
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.volume_up, color: Colors.white),
                    ),
                    //slider
                    Expanded(
                      child: Slider(
                        value: gameProvider.sfxVolume,
                        min: 0,
                        max: 1.0,
                        divisions: 5,
                        label: gameProvider.sfxVolume.toStringAsFixed(1),
                        //sfx volume change
                        onChanged: (value) {
                          gameProvider.sfxVolume = value;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
