import 'package:care_connect/api/firebase_api.dart';
import 'package:care_connect/model/todos_model.dart';
import 'package:flutter/material.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo(
      createdTime: DateTime.now(),
      title: 'Take the headache medicine',
    ),
//     Todo(
//         createdTime: DateTime.now(),
//         title: 'Finish the Todo app',
//         description: '''-finish the todo app -merge it to the mainproject
// -add more description'''),
    // Todo(
    //   createdTime: DateTime.now(),
    //   title: 'Walk the Dog 🐕',
    // ),
    // Todo(
    //   createdTime: DateTime.now(),
    //   title: 'Plan Jacobs birthday party 🎉🥳',
    // ),
  ];

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  // void addTodo(Todo todo) => FirebaseApi.createTodo(todo);
  void addTodo(Todo todo) {
    _todos.add(todo);

    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);

    notifyListeners();
  }

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.title = title;
    todo.description = description;

    notifyListeners();
  }
}
