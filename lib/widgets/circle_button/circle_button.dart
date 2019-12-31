import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final bool border;
  final Color color;
  final VoidCallback onPressed;

  CircleButton({
    this.border,
    this.color,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) => new GestureDetector(
    onTap: onPressed,
    child: Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: border ? Color(0) : color,
        border: border ? Border.all(
          color: color,
          width: 1,
        ) : null,
      ),
    )
  );
}