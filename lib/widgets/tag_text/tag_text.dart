import 'package:flutter/material.dart';

class TagText extends StatelessWidget {
  final IconData icon;
  final String text;

  TagText({
    this.icon,
    this.text
  });

  @override
  Widget build(BuildContext context) => new Container(
    width: 95,
    child: Row(
      children: [
        Icon(icon, color: Colors.black54, size: 11,),
        Text(text)
      ],
    ),
  );
}