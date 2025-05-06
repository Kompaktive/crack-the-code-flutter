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

  Color setTextColor(int counter, int code) {
    if (guesses == 0) return Colors.black;
    if (counter == code) return Colors.green;
    if ((counter - code).abs() < 3) return Colors.amber;
    return Colors.red;
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
                      textColor: setTextColor(guessedCode[0], codes[0]),
                      disabled:
                          guessedCode.join().toString() ==
                          codes.join().toString(),
                      numFn: (value) {
                        guessedCode[0] = value;
                      },
                    ),
                    Counter(
                      counter: guessedCode[1],
                      textColor: setTextColor(guessedCode[1], codes[1]),
                      disabled:
                          guessedCode.join().toString() ==
                          codes.join().toString(),
                      numFn: (value) {
                        guessedCode[1] = value;
                      },
                    ),
                    Counter(
                      counter: guessedCode[2],
                      textColor: setTextColor(guessedCode[2], codes[2]),
                      disabled:
                          guessedCode.join().toString() ==
                          codes.join().toString(),
                      numFn: (value) {
                        guessedCode[2] = value;
                      },
                    ),
                    Counter(
                      counter: guessedCode[3],
                      textColor: setTextColor(guessedCode[3], codes[3]),
                      disabled:
                          guessedCode.join().toString() ==
                          codes.join().toString(),
                      numFn: (value) {
                        guessedCode[3] = value;
                      },
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed:
                    (guessedCode.join().toString() == codes.join().toString())
                        ? null
                        : () {
                          setState(() {
                            guesses++;
                          });

                          if (guessedCode.join().toString() ==
                              codes.join().toString()) {
                            _showMyDialog();
                            setState(() {
                              if (fewestGuesses <= guesses) fewestGuesses++;
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
            ],
          ),
        ),
      ),
    );
  }
}
