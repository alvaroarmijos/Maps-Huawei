import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  ProgressBar({this.label, this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 4,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Flexible(
          flex: 6,
          child: LinearProgressIndicator(
            backgroundColor: Colors.black12,
            value: value / 100,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        )
      ],
    );
  }
}
