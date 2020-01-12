import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final bool invert;
  final Function() onTap;

  ActionButton({@required this.text, @required this.color, this.invert, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _invert = invert ?? false;

    final TextStyle _informStyle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      color: _invert ? color : Colors.white,
      fontFamily: 'Poppins',
    );

    return new GestureDetector(
      onTap: () => onTap(),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: color,
              width: _invert ? 2 : 0,
            ),
            color: _invert ? Color(0) : color,
          ),
          margin: EdgeInsets.fromLTRB(20, 14, 20, 7),
          padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: Text(text, style: _informStyle, textAlign: TextAlign.center,)
      ),
    );
  }
}