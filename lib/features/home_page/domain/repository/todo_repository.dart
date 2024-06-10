import 'package:samsidh_task/features/home_page/domain/entity/todo_entity.dart';

abstract class TodoRepository {
  Future<void> addTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(String id);
  Stream<List<TodoEntity>> getTodo();
}
