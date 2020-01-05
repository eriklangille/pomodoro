import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/date_picker/index.dart';
import 'package:pomodoro/widgets/tag_text/index.dart';
import 'package:pomodoro/util/parsedate.dart';

class NewTask extends StatelessWidget {
  final Function(String text, DateTime chosenDate) onSave;

  NewTask({this.onSave});

  TextStyle _taskStyle = const TextStyle(
    fontSize: 20.0,
//    fontWeight: FontWeight.bold,
    color: Colors.black54,
    fontFamily: 'Roboto',
  );
  TextStyle _doneStyle = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
    color: Colors.blue,
    fontFamily: 'Roboto',
  );

  String _text = "";
  DateTime chooseDate = DateTime.now();

  _chooseDate(context) {
    DatePicker _dp = new DatePicker();
    Future<DateTime> future = _dp.selectDate(context: context);
    future.then((value) => chooseDate = value)
    .catchError((err) => print("Well that's an error."));
  }


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
            margin: EdgeInsets.fromLTRB(0, 5, 5, 5),
            alignment: Alignment(0,0),
            child: TextField(
              onChanged: (String value) async {
                _text = value;
              },
              onSubmitted: (String value) async {
                _text = value;
                onSave(_text, chooseDate);
              } ,
              autofocus: true,
              style: _taskStyle, decoration: InputDecoration(
              hintText: 'New task',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
            TagText(icon: Icons.event, text: ParseDate.showDay(chooseDate), onTap: () => _chooseDate(context),),
            GestureDetector(
              onTap: () => onSave(_text, chooseDate),
              child: Text("Save", style: _doneStyle,),
            )
          ],)
          ],
        ),
    );
  }
}