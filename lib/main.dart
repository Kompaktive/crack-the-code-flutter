import 'dart:math';

import 'package:flutter/material.dart';
import 'package:crack_the_code/widgets/counter.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int guesses = 0;
  int fewestGuesses = 0;
  List<int> codes = [
    Random().nextInt(10),
    Random().nextInt(10),
    Random().nextInt(10),
    Random().nextInt(10),
  ];
  List<int> guessedCode = [0, 0, 0, 0];
  List<bool> shouldValidateCodes = [false, false, false, false];
  bool isGameOver = false;

  // history
  List<Widget> _widgetList = [];

  Color setTextColor(int counter, int code, bool shouldValidate) {
    if (guesses == 0 || !shouldValidate) return Colors.black;
    if (counter == code) return Colors.green;
    if ((counter - code).abs() <= 1) return Colors.amber;
    return Colors.red;
  }

  void increment(int index) {
    setState(() {
      guessedCode[index] = (guessedCode[index] + 1) % 10;
      shouldValidateCodes[index] = false;
    });
  }

  void decrement(int index) {
    setState(() {
      guessedCode[index] = (guessedCode[index] - 1) % 10;
      shouldValidateCodes[index] = false;
    });
  }

  void restart() {
    setState(() {
      codes = [
        Random().nextInt(10),
        Random().nextInt(10),
        Random().nextInt(10),
        Random().nextInt(10),
      ];
      guesses = 0;
      guessedCode = [0, 0, 0, 0];
      shouldValidateCodes = [false, false, false, false];
      isGameOver = false;
      _widgetList = [];
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Align(
            alignment: Alignment.center,
            child: Text("You won!"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Restart'),
              onPressed: () {
                restart();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Crack The Code",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Guess(es): $guesses"),
                    Text("Fewest Guesses: $fewestGuesses"),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Counter(
                      counter: guessedCode[0],
                      textColor: setTextColor(
                        guessedCode[0],
                        codes[0],
                        shouldValidateCodes[0],
                      ),
                      disabled: isGameOver,
                      incrementFn: () {
                        increment(0);
                      },
                      decrementFn: () {
                        decrement(0);
                      },
                    ),
                    Counter(
                      counter: guessedCode[1],
                      textColor: setTextColor(
                        guessedCode[1],
                        codes[1],
                        shouldValidateCodes[1],
                      ),
                      disabled: isGameOver,
                      incrementFn: () {
                        increment(1);
                      },
                      decrementFn: () {
                        decrement(1);
                      },
                    ),
                    Counter(
                      counter: guessedCode[2],
                      textColor: setTextColor(
                        guessedCode[2],
                        codes[2],
                        shouldValidateCodes[2],
                      ),
                      disabled: isGameOver,
                      incrementFn: () {
                        increment(2);
                      },
                      decrementFn: () {
                        decrement(2);
                      },
                    ),
                    Counter(
                      counter: guessedCode[3],
                      textColor: setTextColor(
                        guessedCode[3],
                        codes[3],
                        shouldValidateCodes[3],
                      ),
                      disabled: isGameOver,
                      incrementFn: () {
                        increment(3);
                      },
                      decrementFn: () {
                        decrement(3);
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed:
                    (isGameOver)
                        ? null
                        : () {
                          setState(() {
                            guesses++;
                            shouldValidateCodes = [true, true, true, true];
                            // _widgetList.add(Text("$guesses. asdf"));
                            _widgetList.add(
                              Text.rich(
                                TextSpan(
                                  text: "$guesses. ",
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: guessedCode[0].toString(),
                                      style: TextStyle(
                                        color: setTextColor(
                                          guessedCode[0],
                                          codes[0],
                                          shouldValidateCodes[0],
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: guessedCode[1].toString(),
                                      style: TextStyle(
                                        color: setTextColor(
                                          guessedCode[1],
                                          codes[1],
                                          shouldValidateCodes[1],
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: guessedCode[2].toString(),
                                      style: TextStyle(
                                        color: setTextColor(
                                          guessedCode[2],
                                          codes[2],
                                          shouldValidateCodes[2],
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: guessedCode[3].toString(),
                                      style: TextStyle(
                                        color: setTextColor(
                                          guessedCode[3],
                                          codes[3],
                                          shouldValidateCodes[3],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                            if (guessedCode.join().toString() ==
                                codes.join().toString()) {
                              isGameOver = true;
                            }
                          });

                          if (isGameOver) {
                            _showMyDialog();
                            setState(() {
                              if (fewestGuesses == 0 ||
                                  guesses <= fewestGuesses) {
                                fewestGuesses = guesses;
                              }
                            });
                          }
                        },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  restart();
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text(
                  "Restart",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: const Text("History:"),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ListView(key: UniqueKey(), children: _widgetList),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
