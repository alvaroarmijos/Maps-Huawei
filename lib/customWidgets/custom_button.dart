import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  final String _text;
  final VoidCallback _onPressed;

  Btn(this._text, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blueGrey,
      textColor: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10),
      splashColor: Colors.blueAccent,
      child: Text(_text, style: TextStyle(fontSize: 14)),
      onPressed: _onPressed,
    );
  }
}
