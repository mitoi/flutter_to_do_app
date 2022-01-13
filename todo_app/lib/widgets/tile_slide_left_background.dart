// @dart=2.9
import 'package:flutter/material.dart';

Widget slideLeftBackground() {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.red],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
    //color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}
