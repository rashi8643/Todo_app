import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:samsidh_task/features/home_page/data/model/todo_model.dart';

abstract class TodoFirestoreDataSource {
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo, String id);
  Future<void> deleteTodo(String id);
  Stream<QuerySnapshot<TodoModel>> getTodo();
}
