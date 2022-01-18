// @dart=2.9
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/service/todo_services.dart';
import 'package:todo_app/utils/authentication.dart';
import 'package:todo_app/view/add_todo.dart';
import 'package:todo_app/view/sign_in_screen.dart';
import 'package:todo_app/view/todo_item_tile.dart';
import 'package:todo_app/widgets/tile_slide_left_background.dart';
import 'package:todo_app/widgets/tile_slide_right_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/todo.dart';

class TodoList extends StatefulWidget {
  final User user;

  const TodoList({Key key, this.user}) : super(key: key);
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  StreamController _streamController;
  Stream stream;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignInScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _streamController = StreamController();
    stream = _streamController.stream;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TodoServices().getAllTodos(this.widget.user.uid).then((value) {
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
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        builder: (context) => Container(
            height: 450,
            child: AddTodoForm(
              userId: widget.user.uid,
            )),
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
                List<Todo> todos = snapshot.data as List<Todo>;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.black),
                            SizedBox(width: 10),
                            Text(
                              "today",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: Icon(Icons.logout),
                          onTap: () async {
                            setState(() {
                              _isSigningOut = true;
                            });
                            await Authentication.signOut(context: context);
                            setState(() {
                              _isSigningOut = false;
                            });
                            Navigator.of(context)
                                .pushReplacement(_routeToSignInScreen());
                          },
                        )
                      ],
                    ),
                    Divider(color: Colors.white38),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: todos?.length,
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
                                  key: Key(item.id),
                                  todo: item,
                                  userId: widget.user.uid,
                                ));
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
