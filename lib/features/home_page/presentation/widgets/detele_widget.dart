import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samsidh_task/core/constants/app_constants.dart';
import 'package:samsidh_task/features/home_page/domain/entity/todo_entity.dart';
import 'package:samsidh_task/features/home_page/presentation/provider/todo_provider.dart';

class DeleteWidget extends ConsumerWidget {
  final TodoEntity todo;
  const DeleteWidget({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final constants = ref.watch(appConstantsProvider);
    return AlertDialog(
      title: Text(constants.txtSure),
      content: Text(constants.txtMassege),
      actions: [
        TextButton(
            onPressed: (() {
              Navigator.of(context).pop();
            }),
            child: Text(
              constants.txtCancel,
            )),
        TextButton(
          onPressed: () {
            ref.read(todoStateProvider.notifier).deleteTodo(todo.id);
            Navigator.of(context).pop();
          },
          child: Text(
            constants.txtDelete,
          ),
        )
      ],
    );
  }
}
