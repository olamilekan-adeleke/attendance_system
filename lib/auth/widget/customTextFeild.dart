import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String textFieldTitle;
  final int textLength;
  final TextInputType keyboardType;
  final bool hideText;

  const CustomTextField({
    @required this.controller,
    @required this.textFieldTitle,
    this.textLength = 1,
    this.keyboardType = TextInputType.text,
    this.hideText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.trim().isEmpty) {
            return '$textFieldTitle Can\'t Be Empty';
          } else if (value.trim().length < textLength) {
            return '$textFieldTitle Can\'t Less Than $textLength Characters';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(labelText: "$textFieldTitle"),
        keyboardType: keyboardType,
        obscureText: hideText,
      ),
    );
  }
}
