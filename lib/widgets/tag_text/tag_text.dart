import 'package:flutter/material.dart';

class TagText extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  TagText({
    @required this.icon,
    @required this.text,
    this.onTap
  });

  @override
  Widget build(BuildContext context) => new GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 95,
//        color: Colors.green,
        padding: EdgeInsets.fromLTRB(0, 5, 5, 0),
        constraints: BoxConstraints(
        minWidth: 60,
        maxWidth: 150,
        ),
        child:  Row(
          children: [
            Container(
              child: Icon(icon, color: Colors.black54, size: 11,),
              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
            ),
            Text(text,
              style: TextStyle(
                color: Colors.black87
              ),
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ],
      ),
    )
  );
}