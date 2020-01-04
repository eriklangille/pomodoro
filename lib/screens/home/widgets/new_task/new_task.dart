import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/tag_text/index.dart';

class NewTask extends StatelessWidget {
  final Function(String text) onSave;

  NewTask({this.onSave});

  TextStyle _tasktyle = const TextStyle(
    fontSize: 20.0,
//    fontWeight: FontWeight.bold,
    color: Colors.black54,
    fontFamily: 'Roboto',
  );
  TextStyle _donetyle = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
    color: Colors.blue,
    fontFamily: 'Roboto',
  );

  String _text = "";


  @override
  Widget build (BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 0),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
//            color: Colors.red,
            margin: EdgeInsets.all(5),
            alignment: Alignment(0,0),
            child: TextField(
              onChanged: (String value) async {
                _text = value;
              },
              autofocus: true,
              style: _tasktyle, decoration: InputDecoration(
              hintText: 'New task',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            TagText(icon: Icons.event, text: "Tomorrow",),
            GestureDetector(
              onTap: () => onSave(_text),
              child: Text("Save", style: _donetyle,),
            )
          ],)
          ],
        ),
    );
  }
}