import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  int counter;
  final Function(int value) numFn;

  Counter(this.counter, this.numFn, {super.key});

  @override
  State<Counter> createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              widget.counter = (widget.counter + 1) % 10;
            });
            widget.numFn(widget.counter);
          },
          child: Icon(Icons.arrow_drop_up, size: 48),
        ),
        Text(widget.counter.toString(), style: TextStyle(fontSize: 48)),
        TextButton(
          onPressed: () {
            setState(() {
              widget.counter = (widget.counter - 1) % 10;
            });
            widget.numFn(widget.counter);
          },
          child: Icon(Icons.arrow_drop_down, size: 48),
        ),
      ],
    );
  }
}
