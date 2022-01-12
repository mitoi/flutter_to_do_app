import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_services.dart';
import 'package:todo_app/widgets/todo_tile.dart';

import 'add_todo.dart';

class TodoItemCard extends StatefulWidget {
  final Todo todo;

  const TodoItemCard({Key key, this.todo}) : super(key: key);
  @override
  _TodoItemCardState createState() => _TodoItemCardState();
}

class _TodoItemCardState extends State<TodoItemCard> {
  bool isHover = false;

  void showAddModal(String id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      builder: (context) =>
          Container(height: 450, child: AddTodoForm(parentId: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> subitems = [];
    if (widget.todo.children.length > 0) {
      for (var i = 0; i < widget.todo.children.length; i++) {
        var item = Todo.fromJson(widget.todo.children[i]);

        subitems.add(Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: TodoTile(
              todo: item,
              size: 20,
              primaryFontSize: 14,
              secondaryFontSize: 12,
            )));
      }
    }

    subitems.add(ListTile(
      title: InkWell(
        onTap: () => showAddModal(widget.todo.id),
        child: Icon(
          Icons.add,
          color: Colors.black,
          size: 25,
        ),
      ),
    ));

    Map priorityColorMap = {
      "High": Colors.red,
      "Medium": Colors.orange,
      "Low": Colors.lightGreen
    };

    Color cardColor = widget.todo.priority != null
        ? priorityColorMap[widget.todo.priority]
        : Colors.white;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: ExpansionTile(
        leading: GestureDetector(
            onTap: () {
              TodoServices().toggleToDo(widget.todo.id, widget.todo.isComplet);

              HapticFeedback.mediumImpact();
              SystemSound.play(SystemSoundType.click);
            },
            child: Container(
              alignment: Alignment.center,
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.green, width: 1)),
              child: widget.todo.isComplet
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            )),
        title: Text(
          "${widget.todo.title}",
          style: TextStyle(
            decoration: widget.todo.isComplet
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontSize: 16,
          ),
        ),
        subtitle: Text(
          "${widget.todo.description}",
          style: TextStyle(
            decoration: widget.todo.isComplet
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontSize: 12,
          ),
        ),
        children: subitems,
      ),
    );
  }
}
