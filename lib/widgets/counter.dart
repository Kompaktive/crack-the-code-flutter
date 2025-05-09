import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({
    this.counter = 0,
    this.textColor = Colors.black,
    this.disabled,
    required this.incrementFn,
    required this.decrementFn,
    super.key,
  });

  final int counter;
  final Color textColor;
  final bool? disabled;
  final Function() incrementFn;
  final Function() decrementFn;

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
          onPressed: widget.disabled == true ? null : widget.incrementFn,
          child: Icon(Icons.arrow_drop_up, size: 48),
        ),
        Text(
          widget.counter.toString(),
          style: TextStyle(fontSize: 48, color: widget.textColor),
        ),
        TextButton(
          onPressed: widget.disabled == true ? null : widget.decrementFn,
          child: Icon(Icons.arrow_drop_down, size: 48),
        ),
      ],
    );
  }
}
