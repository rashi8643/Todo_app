import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samsidh_task/core/Excepations/base_excepation.dart';
import 'package:samsidh_task/features/home_page/data/repository/todo_repository_impl.dart';
import 'package:samsidh_task/features/home_page/domain/entity/todo_entity.dart';
import 'package:samsidh_task/features/home_page/domain/repository/todo_repository.dart';
import 'package:samsidh_task/features/home_page/domain/usecase/add_todo_usecase.dart';
import 'package:samsidh_task/features/home_page/domain/usecase/delete_todo_usecase.dart';
import 'package:samsidh_task/features/home_page/domain/usecase/get_todo_usecase.dart';
import 'package:samsidh_task/features/home_page/domain/usecase/update_todo_usecase.dart';

part 'todo_provider.g.dart';

@riverpod
class TodoState extends _$TodoState {
  late final TextEditingController titleController;
  late TodoRepository repository;

  @override
  void build() {
    titleController = TextEditingController();
    repository = ref.watch(todoRepositoryProvider);
  }

  /// Update todo
  Future<String?> updateTodo({
    required String id,
    required bool isChecked,
  }) async {
    try {
      final newTitle = titleController.text;
      await UpdateTodoUsecase(repository: repository)(
        id: id,
        isChecked: isChecked,
        title: newTitle,
      );
    } on BaseException catch (e) {
      return e.message;
    } catch (e) {
      throw BaseException('Unknown error occured');
    }

    return null;
  }

  /// Check todo
  Future<String?> checkTodo(String todoId, bool isChecked, String title) async {
    try {
      await UpdateTodoUsecase(repository: repository)(
        id: todoId,
        isChecked: isChecked,
        title: title,
      );
    } on BaseException catch (e) {
      return e.message;
    } catch (e) {
      throw BaseException('Unknown error occured');
    }

    return null;
  }

  /// Add todo
  Future<String?> addTodo() async {
    try {
      final title = titleController.text;
      await AddTodoUsecase(repository: repository)(
          title: title, isChecked: false);
    } on BaseException catch (e) {
      return e.message;
    } catch (e) {
      throw BaseException('Unknown error occured');
    }

    return null;
  }

  /// Delete todo
  Future<String?> deleteTodo(String id) async {
    try {
      await DeleteTodoUsecase(repository: repository)(id: id);
    } on BaseException catch (e) {
      return e.message;
    } catch (e) {
      throw BaseException('Unknown error occured');
    }

    return null;
  }
}

///get todo
@riverpod
Stream<List<TodoEntity>> todo(TodoRef ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetTodoUsecase(repository: repository)();
}
