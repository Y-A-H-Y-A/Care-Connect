import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/todos_model.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();

    todo.id = docTodo.id as int?;
    await docTodo.set(todo.toJson());

    return docTodo.id;
  }
}
