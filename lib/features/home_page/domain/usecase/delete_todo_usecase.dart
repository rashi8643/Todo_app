import 'package:samsidh_task/core/Excepations/base_excepation.dart';
import 'package:samsidh_task/features/home_page/domain/repository/todo_repository.dart';

final class DeleteTodoUsecase {
  final TodoRepository repository;

  DeleteTodoUsecase({required this.repository});

  Future<void> call({required String id}) async {
    try {
      if (id.trim().isEmpty) {
        throw BaseException("Title should not be empty. Try again");
      }

      await repository.deleteTodo(id);
    } catch (e) {
      throw BaseException('Cannot Delete Todo');
    }
  }
}
