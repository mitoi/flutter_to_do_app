import 'package:flutter/material.dart';

Widget slideRightBackground() {
  return Container(
    color: Colors.green,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.check,
            color: Colors.white,
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
    ),
  );
}
