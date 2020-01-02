import 'package:flutter/material.dart';

class ButtonControls extends StatelessWidget {
  final bool start;
  final Function() onPlayPause;

  ButtonControls({this.start, this.onPlayPause});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.red,
    ),
    padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
    alignment: Alignment(0,0),
    child:  Container(alignment: Alignment(0,0), width: 255, /*color: Colors.orange,*/ child: FractionallySizedBox (
        widthFactor: 1,
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
//              color: Colors.lightBlue,
              child: Icon(Icons.stop, size: 55, color: Colors.white,),
              padding: EdgeInsets.all(25),
           ),
        new GestureDetector(
            onTap: () => onPlayPause(),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: EdgeInsets.all(10),
              child: Icon(start ? Icons.play_arrow : Icons.pause, size: 45, color: Colors.red,),
          ))
        ],
      )
    ),
  ));
}