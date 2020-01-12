import 'package:flutter/material.dart';

class EntryField extends StatelessWidget {
  final String hintText;
  final String alertText;
  final TextInputType keyboardType;
  final bool isPassword;
  final EntryAlert entryAlert;
  final TextEditingController textEditingController;
  final FocusNode focus;

  EntryField({@required this.hintText, this.keyboardType, this.isPassword, this.textEditingController, this.entryAlert, this.focus, this.alertText});

  final TextStyle _entryStyle = const TextStyle(
    fontSize: 20.0,
//    fontWeight: FontWeight.bold,
    color: Colors.black54,
    fontFamily: 'Roboto',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
            ),
            margin: EdgeInsets.fromLTRB(20, 7, 20, 7),
            padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: <Widget>[
                Expanded( child: TextField(
                  onSubmitted: (text) => print(text),
                  controller: textEditingController,
                  focusNode: focus,
                  style: _entryStyle,
                  obscureText: isPassword ?? false,
                  keyboardType: keyboardType ?? TextInputType.text,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                )
                ),
                (entryAlert ?? EntryAlert.none) == EntryAlert.error ? Icon(Icons.cancel, color: Colors.red,) : ((entryAlert ?? EntryAlert.none) == EntryAlert.correct ? Icon(Icons.check, color: Colors.green,) : Container()) ,
              ],
            )
        ),
        (entryAlert ?? EntryAlert.none) == EntryAlert.none ? Container() : Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Text(alertText ?? "", style: TextStyle(color: Colors.red), maxLines: 1, softWrap: false, overflow: TextOverflow.fade,),
        )
    ],
    );
  }
}

enum EntryAlert {
  none, error, correct
}