import 'package:flutter/material.dart';

class MyBtn extends StatelessWidget {
  final String title;
  final Function _onPress;

  MyBtn(this.title, this._onPress, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 3, 3, 3),
        color: Colors.white,
        child: RaisedButton(
            color: Colors.grey,
            child: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            onPressed: () async {
              _onPress(context);
            }));
  }
}
