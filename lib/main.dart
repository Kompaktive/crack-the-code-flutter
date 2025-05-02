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
  final int code = Random().nextInt(10000);
  List<int> guessedCode = [0, 0, 0, 0];

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
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
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
                    Counter(guessedCode[0], (value) {
                      guessedCode[0] = value;
                    }),
                    Counter(guessedCode[1], (value) {
                      guessedCode[1] = value;
                    }),
                    Counter(guessedCode[2], (value) {
                      guessedCode[2] = value;
                    }),
                    Counter(guessedCode[3], (value) {
                      guessedCode[3] = value;
                    }),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    guesses++;
                  });

                  print(code);
                  print(guessedCode.join());

                  if (guessedCode.join().toString() == code.toString()) {
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
                  setState(() {
                    guesses = 0;
                    guessedCode = [0, 0, 0, 0];
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Text(
                  "Reset",
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
