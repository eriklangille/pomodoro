import 'package:flutter/material.dart';

class InstructionText extends StatelessWidget {
  final String text;
  final EdgeInsets margin;

  InstructionText({this.text, this.margin});

  final TextStyle _informStyle = const TextStyle(
    fontSize: 25.0,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontFamily: 'Poppins',
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(text, style: _informStyle, textAlign: TextAlign.center,),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      margin: margin,
      decoration: BoxDecoration(
      ),
    );
  }
}