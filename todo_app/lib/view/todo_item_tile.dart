import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_services.dart';

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
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      builder: (context) =>
          Container(height: 350, child: AddTodoForm(parentId: id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> subitems = [];
    if (widget.todo.children.length > 0) {
      for (var i = 0; i < widget.todo.children.length; i++) {
        var item = widget.todo.children[i];
        subitems.add(Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: ListTile(
            leading: GestureDetector(
              onTap: () =>
                  TodoServices().toggleToDo(item["_id"], item["isComplet"]),
              child: Container(
                alignment: Alignment.center,
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.blue, width: 1)),
                child: item["isComplet"]
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
              "${item['title']}",
              style: TextStyle(
                decoration: item["isComplet"]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 14,
              ),
            ),
            subtitle: Text(
              "${item['description']}",
              style: TextStyle(
                decoration: item["isComplet"]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                fontSize: 12,
              ),
            ),
            trailing: InkWell(
              onTap: () => TodoServices().deleteTodos(item["_id"]),
              child: Icon(
                Icons.close,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ));
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

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: ExpansionTile(
        leading: GestureDetector(
          onTap: () =>
              TodoServices().toggleToDo(widget.todo.id, widget.todo.isComplet),
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
          ),
        ),
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

        // ListTile(
        //   leading: GestureDetector(
        //     onTap: () => TodoServices()
        //         .toggleToDo(widget.todo.id, widget.todo.isComplet),
        //     child: Container(
        //       alignment: Alignment.center,
        //       height: 25,
        //       width: 25,
        //       decoration: BoxDecoration(
        //           shape: BoxShape.circle,
        //           color: Colors.white,
        //           border: Border.all(color: Colors.pink, width: 1)),
        //       child: widget.todo.isComplet
        //           ? Container(
        //               decoration: BoxDecoration(
        //                 color: Colors.pink,
        //                 shape: BoxShape.circle,
        //               ),
        //             )
        //           : null,
        //     ),
        //   ),
        //   title: Text(
        //     "${widget.todo.title}",
        //     style: TextStyle(
        //       decoration: widget.todo.isComplet
        //           ? TextDecoration.lineThrough
        //           : TextDecoration.none,
        //       fontSize: 16,
        //     ),
        //   ),
        //   subtitle: Text(
        //     "${widget.todo.description}",
        //     style: TextStyle(
        //       decoration: widget.todo.isComplet
        //           ? TextDecoration.lineThrough
        //           : TextDecoration.none,
        //       fontSize: 12,
        //     ),
        //   ),
        //   trailing: InkWell(
        //     onTap: () => TodoServices().deleteTodos(widget.todo.id),
        //     child: Icon(
        //       Icons.close,
        //       color: Colors.black,
        //       size: 25,
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
