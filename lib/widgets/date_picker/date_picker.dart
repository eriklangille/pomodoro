import 'package:flutter/material.dart';

class DatePicker {

  Future<DateTime> selectDate({
    @required BuildContext context,
  }) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 5)
    );
    if (picked != null){
      return picked;
    } else {
      return DateTime.now();
    }
  }




}

