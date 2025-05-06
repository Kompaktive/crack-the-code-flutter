import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  Counter({
    this.counter = 0,
    this.textColor = Colors.black,
    this.disabled,
    required this.numFn,
    super.key,
  });

  int counter;
  Color textColor;
  final bool? disabled;
  final Function(int value) numFn;

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
          onPressed:
              widget.disabled == true
                  ? null
                  : () {
                    setState(() {
                      widget.counter = (widget.counter + 1) % 10;
                      widget.textColor = Colors.black;
                    });
                    widget.numFn(widget.counter);
                  },
          child: Icon(Icons.arrow_drop_up, size: 48),
        ),
        Text(
          widget.counter.toString(),
          style: TextStyle(fontSize: 48, color: widget.textColor),
        ),
        TextButton(
          onPressed:
              widget.disabled == true
                  ? null
                  : () {
                    setState(() {
                      widget.counter = (widget.counter - 1) % 10;
                      widget.textColor = Colors.black;
                    });
                    widget.numFn(widget.counter);
                  },
          child: Icon(Icons.arrow_drop_down, size: 48),
        ),
      ],
    );
  }
}
