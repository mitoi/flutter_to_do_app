import 'package:flutter/material.dart';

Widget slideRightBackground() {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [Colors.white, Colors.green],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        )),
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
