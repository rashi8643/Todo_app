import 'package:samsidh_task/core/Excepations/base_excepation.dart';
import 'package:samsidh_task/features/home_page/domain/entity/todo_entity.dart';
import 'package:samsidh_task/features/home_page/domain/repository/todo_repository.dart';

final class GetTodoUsecase {
  final TodoRepository repository;
  GetTodoUsecase({required this.repository});

  Stream<List<TodoEntity>> call() async* {
    try {
      final todoStream = repository.getTodo();
      await for (final todos in todoStream) {
        for (final todo in todos) {
          if (todo.title.trim().isEmpty) {
            throw BaseException('Title should not be empty. Try again');
          }
        }
        yield todos;
      }
    } catch (e) {
      throw BaseException('Cannot Get Todo');
    }
  }
}
