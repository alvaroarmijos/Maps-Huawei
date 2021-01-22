import 'package:flutter/material.dart';

Widget authButton(String text, Function function) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
    child: RaisedButton(
      color: Colors.blueAccent,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      child: Text(text.toUpperCase()),
      onPressed: function,
    ),
  );
}
