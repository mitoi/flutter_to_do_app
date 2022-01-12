import 'package:flutter/material.dart';
import 'package:todo_app/model/todo.dart';
import 'package:todo_app/service/todo_services.dart';
import 'package:todo_app/widgets/priority_dropdown.dart';

class AddTodoForm extends StatefulWidget {
  final String parentId;

  const AddTodoForm({Key key, this.parentId}) : super(key: key);

  @override
  _AddTodoFormState createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  PriorityDropdown _priorityDropdown;

  String _priority;

  setPriority(value) {
    setState(() {
      _priority = value;
    });
  }

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _priorityDropdown = PriorityDropdown(updatePriority: setPriority);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextFormField(
              controller: _titleController,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                height: 1.5,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 17,
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'eg. Homework',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _descriptionController,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                height: 1.5,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 17,
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: 'Short description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: _priorityDropdown,
          ),
          Spacer(),
          GestureDetector(
            onTap: () async {
              Todo newTodo = Todo(
                parentId: widget.parentId,
                title: _titleController.text,
                description: _descriptionController.text,
                priority: _priority,
              );
              if (_titleController.text.isNotEmpty) {
                await TodoServices()
                    .createNewTodos(newTodo)
                    .whenComplete(() => Navigator.pop(context));
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 75,
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 40),
                    Text(
                      "ADD",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
