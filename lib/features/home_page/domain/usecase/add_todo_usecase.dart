import 'package:samsidh_task/core/Excepations/base_excepation.dart';
import 'package:samsidh_task/features/home_page/domain/entity/todo_entity.dart';
import 'package:samsidh_task/features/home_page/domain/repository/todo_repository.dart';

final class AddTodoUsecase {
  final TodoRepository repository;

  AddTodoUsecase({required this.repository});

  Future<void> call({
    required String title,
    required bool isChecked,
  }) async {
    try {
      if (title.trim().isEmpty) {
        throw BaseException(' Title should not be empty. Try again');
      }

      final todo = TodoEntity(
        id: '',
        title: title,
        isChecked: isChecked,
      );
      await repository.addTodo(todo);
    } catch (e) {
      throw BaseException("Cannot add todo. Please try again");
    }
  }
}
