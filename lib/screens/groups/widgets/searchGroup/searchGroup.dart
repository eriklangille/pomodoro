import 'package:flutter/material.dart';

class SearchGroupApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Search Groups", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
    );
  }
}
