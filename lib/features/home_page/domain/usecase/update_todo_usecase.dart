import 'package:samsidh_task/core/Excepations/base_excepation.dart';
import 'package:samsidh_task/features/home_page/domain/entity/todo_entity.dart';
import 'package:samsidh_task/features/home_page/domain/repository/todo_repository.dart';

final class UpdateTodoUsecase {
  final TodoRepository repository;

  UpdateTodoUsecase({required this.repository});

  Future<void> call({
    required String title,
    required bool isChecked,
    required String id,
  }) async {
    try {
      if (title.trim().isEmpty) {
        throw BaseException("Title should not be empty. Try again");
      }

      final todo = TodoEntity(
        id: id,
        title: title,
        isChecked: isChecked,
      );
      await repository.updateTodo(todo);
    } catch (e) {
      throw BaseException('Cannot Update Todo');
    }
  }
}
