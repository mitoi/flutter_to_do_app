// @dart=2.9
import 'package:flutter/material.dart';

class PriorityDropdown extends StatelessWidget {
  final updatePriority;

  const PriorityDropdown({Key key, this.updatePriority}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: DropdownButtonFormField<String>(
        //value: _chosenValue,
        style: TextStyle(color: Colors.black, fontSize: 16),
        itemHeight: null,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        ),
        items: <String>[
          'Low',
          'Medium',
          'High',
        ].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text(
          "Priority",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        onChanged: (value) {
          updatePriority(value);
        },
      ),
    );
  }
}
