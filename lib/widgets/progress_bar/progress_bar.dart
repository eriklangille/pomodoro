import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  ProgressBar({
    this.progress
  });

  @override
  Widget build(BuildContext context) => Container(
    height: 4,
    width: double.infinity,
    decoration: BoxDecoration(
        color: Colors.black26
    ),
    child: FractionallySizedBox(
        widthFactor: progress,
        alignment: AlignmentDirectional.topStart,
        child: Container(
          color: Colors.white,
        )
    ),
  );
}