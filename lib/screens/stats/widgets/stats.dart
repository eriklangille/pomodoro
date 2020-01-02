import 'package:flutter/material.dart';

class StatsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stats", style: TextStyle(fontFamily: 'Poppins', color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}