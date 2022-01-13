// @dart=2.9
import 'dart:convert' as cnv;
import 'dart:io';
import 'package:http/http.dart';
import 'package:todo_app/model/todo.dart';

class TodoServices {
  String _url = "http://localhost:3000/api";

  // to list all todos
  Future<List<Todo>> getAllTodos() async {
    try {
      Response response = await get(Uri.parse("$_url/todos"));
      if (response.statusCode == 200) {
        // debugPrint(response.body);
        return List<Todo>.from(
          cnv.json.decode(response.body).map((e) => Todo.fromJson(e)),
        );
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // to create new todos
  Future createNewTodos(Todo todo) async {
    try {
      final json = cnv.json.encode(todo.toJson());
      print(json);
      Response response = await post(
        Uri.parse("$_url/todos"),
        body: json,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      print(response.body);
      if (response.statusCode == 200) {}
    } catch (e) {
      print(e);
    }
  }

  // complet todo
  Future completTodo(String id) async {
    try {
      Response response = await put(
        Uri.parse("$_url/todos/$id"),
        body: cnv.json.encode({"isComplet": true}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  // toggle betwen states of todo
  Future toggleToDo(String id, bool complete) async {
    try {
      Response response = await put(
        Uri.parse("$_url/todos/$id"),
        body: cnv.json.encode({"isComplet": !complete}),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  // to delet specific todo
  Future deleteTodos(String id) async {
    try {
      Response response = await delete(
        Uri.parse("$_url/todos/$id"),
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      );
      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (e) {}
  }
}
