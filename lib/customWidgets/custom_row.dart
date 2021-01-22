import 'package:flutter/material.dart';

class CRow extends StatelessWidget {
  final List<Widget> children;

  CRow({this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    );
  }
}
