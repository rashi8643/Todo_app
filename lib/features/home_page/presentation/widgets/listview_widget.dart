import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samsidh_task/core/constants/app_constants.dart';
import 'package:samsidh_task/core/theme/app_theme.dart';
import 'package:samsidh_task/core/utils/error_snackbar_utils.dart';
import 'package:samsidh_task/features/home_page/domain/entity/todo_entity.dart';
import 'package:samsidh_task/features/home_page/presentation/provider/todo_provider.dart';
import 'package:samsidh_task/features/home_page/presentation/widgets/bottomsheet_widget.dart';
import 'package:samsidh_task/features/home_page/presentation/widgets/detele_widget.dart';

class ListViewWidget extends ConsumerWidget {
  const ListViewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apptheme = AppTheme.of(context);
    final constants = ref.watch(appConstantsProvider);
    return switch (ref.watch(todoProvider)) {
      // ignore: unnecessary_null_comparison
      AsyncData(:final value) => value == null
          ? Center(
              child: Text(
                constants.txtNoTodos,
                style: TextStyle(
                  color: apptheme.colors.primary,
                  fontSize: 30,
                ),
              ),
            )
          : SizedBox(
              height: apptheme.spaces.space_500 * 12.7,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: value.length,
                itemBuilder: (context, index) {
                  List<TodoEntity> data = [
                    for (final values in value)
                      TodoEntity(
                        id: values.id,
                        title: values.title,
                        isChecked: values.isChecked,
                      ),
                  ];
                  data.sort(
                    (a, b) => a.title.compareTo(b.title),
                  );

                  return Padding(
                    padding: EdgeInsets.all(apptheme.spaces.space_100),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: apptheme.spaces.space_150,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: apptheme.spaces.space_400 * 2.1,
                        decoration: BoxDecoration(
                          color: apptheme.colors.primary,
                          borderRadius: BorderRadius.circular(
                            apptheme.spaces.space_100,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: apptheme.spaces.space_100),
                          child: Row(
                            children: [
                              Checkbox(
                                value: data[index].isChecked,
                                onChanged: (values) => ref
                                    .read(todoStateProvider.notifier)
                                    .checkTodo(data[index].id, values ?? false,
                                        data[index].title)
                                    .then(
                                      (error) => ErrorSnackbarUtil.showError(
                                          context, error),
                                    ),
                              ),
                              SizedBox(
                                width: apptheme.spaces.space_150,
                              ),
                              Expanded(
                                child: Text(
                                  data[index].title,
                                  style: apptheme.typography.h600!.copyWith(
                                    color: apptheme.colors.secondary,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => BottomsheetWidget(
                                            todo: data[index],
                                          ));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: apptheme.colors.text,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: ((context) => DeleteWidget(
                                            todo: data[index],
                                          )));
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: apptheme.colors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
      AsyncError() => Center(
          child: Text(
            constants.txtError,
            style: TextStyle(
              color: apptheme.colors.text,
            ),
          ),
        ),
      _ => const Center(
          child: CircularProgressIndicator(),
        ),
    };
  }
}
