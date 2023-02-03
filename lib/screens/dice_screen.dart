import 'dart:math';

import 'package:flutter/material.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({Key? key}) : super(key: key);

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {

  bool isGameStarted = false;

  List<Image> dice =[];

  String? playingFirstDice;
  String? playingSecondDice;

  int score = 0;

  final Map<String, int> allDices = {
    "dice/dice1.png": 1,
    "dice/dice2.png": 2,
    "dice/dice3.png": 3,
    "dice/dice4.png": 4,
    "dice/dice5.png": 5,
    "dice/dice6.png": 6,
  };

  Map<String, int> playingDice = {};

  @override
  void initState() {
    super.initState();
    playingDice.addAll(allDices);
  }

  // String get diceKey => ;

  void changeDice() {

    setState(() {
      isGameStarted = true;
    });
    playingDice = {};
    playingDice.addAll(allDices);

    dice = [];

    Random random = Random();

    String diceOneKey = playingDice.keys.elementAt(random.nextInt(playingDice.length));
    String diceTwoKey = playingDice.keys.elementAt(random.nextInt(playingDice.length));

    playingFirstDice = diceOneKey;
    playingSecondDice = diceTwoKey;

    dice.add(Image.asset(playingFirstDice!));
    dice.add(Image.asset(playingSecondDice!));

    score = allDices[playingFirstDice]! + allDices[playingSecondDice]!;

    // Random random = Random();
    // if (allDices.length > 0) {
    //   String diceKey = allDices.keys.elementAt(random.nextInt(allDices.length));
    //   allDices.removeWhere((key, value) => key == diceKey);
    //
    //   setState(() {
    //     dice.add(
    //       Image.asset(diceKey),
    //     );
    //   });
    //
    //   score = score + allDices[diceKey]!;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.pink[400],
        body: isGameStarted == true
            ? SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                    Column(
                      children: [
                        Text("Your score $score", style:TextStyle(color: Colors.blue,),),
                        SizedBox(height: 20),
                        Container(
                          height: 200,
                          child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                              itemCount: dice.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index){
                                return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: dice[index],
                                );
                              }
                          ),
                        )
                      ],
                    ),
                     IntrinsicWidth(
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.stretch,
                         children: [
                         MaterialButton(
                           onPressed: () => changeDice(),
                           color: Colors.blue[600],
                           child: Text("Roll"),
                         ),
                         ],
                       ),
                     )

            ],
          ),
        ),
        )
            : Center(
              child: MaterialButton(
                onPressed: () => changeDice(),
                color: Colors.blue,
                child: Text("Start game"),
          ),
        )
    );
  }
}
