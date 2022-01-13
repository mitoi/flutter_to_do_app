// @dart=2.9

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/enums/priority.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_services.dart';

class TodoTile extends StatefulWidget {
  final Todo todo;
  final double size;
  final double primaryFontSize;
  final double secondaryFontSize;
  const TodoTile(
      {Key key,
      this.todo,
      this.size,
      this.primaryFontSize,
      this.secondaryFontSize})
      : super(key: key);
  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    Priority priority = Priority.values.firstWhere(
        (element) => describeEnum(element) == widget.todo.priority,
        orElse: () => Priority.Empty);

    Color cardColor =
        priority != Priority.Empty ? priority.value : Colors.white;

    return ListTile(
      leading: GestureDetector(
        onTap: () {
          TodoServices().toggleToDo(widget.todo.id, widget.todo.isComplet);

          HapticFeedback.selectionClick();
        },
        child: Container(
          alignment: Alignment.center,
          height: this.widget.size,
          width: this.widget.size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: cardColor.withOpacity(0.1),
              border: Border.all(
                  color: (cardColor == Colors.white) ? Colors.blue : cardColor,
                  width: 1)),
          child: this.widget.todo.isComplet
              ? Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                )
              : null,
        ),
      ),
      title: Text(
        "${this.widget.todo.title}",
        style: TextStyle(
          decoration: this.widget.todo.isComplet
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          fontSize: this.widget.primaryFontSize,
        ),
      ),
      subtitle: Text(
        "${this.widget.todo.description}",
        style: TextStyle(
          decoration: this.widget.todo.isComplet
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          fontSize: this.widget.secondaryFontSize,
        ),
      ),
      trailing: InkWell(
        onTap: () => TodoServices().deleteTodos(this.widget.todo.id),
        child: Icon(
          Icons.close,
          color: Colors.black,
          size: this.widget.size,
        ),
      ),
    );
  }
}
