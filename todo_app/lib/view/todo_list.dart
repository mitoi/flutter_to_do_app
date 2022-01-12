import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/service/todo_services.dart';
import 'package:todo_app/view/add_todo.dart';
import 'package:todo_app/view/todo_item_tile.dart';
import 'package:todo_app/widgets/tile_slide_left_background.dart';
import 'package:todo_app/widgets/tile_slide_right_background.dart';

import '../model/todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  StreamController _streamController;
  Stream stream;

  @override
  void initState() {
    _streamController = StreamController();
    stream = _streamController.stream;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TodoServices().getAllTodos().then((value) {
      if (value != null) {
        _streamController.add(value);
      }
      setState(() {});
    });
    void showAddModal() {
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
        builder: (context) => Container(height: 350, child: AddTodoForm()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: StreamBuilder(
              stream: stream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<Todo> todos = snapshot.data;
                return Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          "tasks",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(color: Colors.white38),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: todos.length,
                          itemBuilder: (context, i) {
                            final item = todos[i];

                            return Dismissible(
                                key: Key(item.id),
                                // Show a red background as the item is swiped away.
                                background: slideRightBackground(),
                                secondaryBackground: slideLeftBackground(),
                                confirmDismiss: (direction) async {
                                  if (direction ==
                                      DismissDirection.endToStart) {
                                    final bool res = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            content: Text(
                                                "Are you sure you want to delete ${item.title}?"),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              TextButton(
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                onPressed: () async {
                                                  setState(() {
                                                    todos.removeAt(i);
                                                  });

                                                  await TodoServices()
                                                      .deleteTodos(item.id);
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          );
                                        });
                                    return res;
                                  } else {
                                    await TodoServices().completTodo(item.id);

                                    HapticFeedback.heavyImpact();
                                    SystemSound.play(SystemSoundType.click);
                                    return false;
                                  }
                                },
                                child: TodoItemCard(
                                    key: Key(item.id), todo: item));
                          },
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () => showAddModal(),
        child: Icon(
          Icons.add,
          size: 55,
        ),
      ),
    );
  }
}
