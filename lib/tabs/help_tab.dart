import 'package:flutter/material.dart';

//lib
import '../theme.dart';

//tab for help screen
class HelpTab extends StatelessWidget {
  const HelpTab({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'Help',
                  style: GameTextStyles.title,
                ),
                const SizedBox(height: 20),
                //body
                const Text(
                  'Here you can find information and help about the game.',
                  style: GameTextStyles.body,
                ),
                const SizedBox(height: 20),

                //scrollable if needed
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //help text
                        Text(
                          'How to play?',
                          style: GameTextStyles.body2,
                        ),
                        Text(
                          '''
- First, memorize the cards before they flip over
- Match pairs of cards to earn points
- If correct match, earn points
- If an incorrect match, lose points
- Use the button in the top corner to pause the game
- Customize sound settings in the settings tab
- Track your scores with the highscores tab
                          ''',
                          style: GameTextStyles.body,
                        ),
                        Text(
                          "Catch them quickly!",
                          style: GameTextStyles.body2,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                //documentation button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 44, 12, 96),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    //button
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
    );
  }
}

//tab for documentation info
class DocumentationTab extends StatelessWidget {
  const DocumentationTab({super.key});

  //style
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Documentation', style: GameTextStyles.bar),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Concept', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'Medicine Match a memory card game with a magical twist. The player has to match cards to catch the potion ingredients!',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('Genre', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'Casual, Puzzle, Card Matching. App Store genres like Puzzle and Card.',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('Platform', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'Mobile, Android & iOS.',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('Story', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'An accident in the lab has caused all potion ingredients to come alive and run around. The player must catch them by matching cards correctly.',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('Aesthetics', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'Cute, simple hand-drawn art that I drew myself. There is also groovy background music with sound effects for flipping cards, success, and error.',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('Gameplay', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'Players are given a few seconds to memorize card positions before they flip over. Then, players flip cards two at a time to find matches. The game ends when all cards are matched.',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('Controls', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'Simple tap to flip a card. Made for touch interaction.',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('Screenshots', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/toadstool.png',
                      width: 100,
                      height: 100,
                    ),
                    const SizedBox(width: 16),
                    Image.asset(
                      'assets/images/sunflower.png',
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text('Problems', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'The sound is a bit buggy and sometimes plays with a lag. Also there is a problem with opening and closing the app.',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('Resources', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'used info from these sites:\n'
                  'https://flame-engine.org\n'
                  'https://pub.dev\n'
                  '\n'
                  'used ChatGPT to help with coding:\n'
                  'https://chatgpt.com\n'
                  '\n'
                  'background music:\n'
                  'https://pixabay.com/music/funk-groovy-ambient-funk-201745',
                  style: GameTextStyles.docBody,
                ),
                const SizedBox(height: 20),
                const Text('About the Developer', style: GameTextStyles.docTitle),
                const SizedBox(height: 8),
                const Text(
                  'Jackson Heim – Developer and designer. Created app with Flutter, Flame, Clip Studio Paint, and UI/UX design.',
                  style: GameTextStyles.docBody,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
