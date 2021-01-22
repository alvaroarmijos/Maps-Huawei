import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextInput extends StatelessWidget {
  static const bool _IS_DENSE = true;
  static const EdgeInsetsGeometry _CONTENT_PADDING = EdgeInsets.all(5);

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final EdgeInsets padding;

  CustomTextInput({
    this.labelText = "",
    this.hintText = "",
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.padding = const EdgeInsets.only(top: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: TextField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        controller: controller,
        decoration: InputDecoration(
            isDense: _IS_DENSE,
            contentPadding: _CONTENT_PADDING,
            labelText: labelText,
            hintText: hintText,
            fillColor: Color(0xfff3f3f4),
            filled: true),
      ),
    );
  }
}
