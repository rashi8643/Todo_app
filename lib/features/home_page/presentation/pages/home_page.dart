import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samsidh_task/core/constants/app_constants.dart';
import 'package:samsidh_task/core/theme/app_theme.dart';
import 'package:samsidh_task/features/authentication/presentation/provider/auth_provider.dart';
import 'package:samsidh_task/features/home_page/presentation/widgets/bottomsheet_widget.dart';
import 'package:samsidh_task/features/home_page/presentation/widgets/listview_widget.dart';

class HomePage extends ConsumerWidget {
  static const routePath = '/homePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppTheme.of(context).colors;
    final space = AppTheme.of(context).spaces;
    final data = ref.watch(appConstantsProvider);
    return Scaffold(
      backgroundColor: colors.secondary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: space.space_700 * 1.8,
              color: colors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.bar_chart)),
                  Text(
                    'Todo List',
                    style: TextStyle(
                      fontSize: space.space_250,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref
                          .read(authenticationProvider(context).notifier)
                          .logout();
                    },
                    icon: const Icon(
                      Icons.logout,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: space.space_250,
                top: space.space_200,
                right: space.space_250,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tasks",
                    style: TextStyle(
                      fontSize: space.space_300,
                      color: colors.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.secondary,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: colors.text,
                          width: .5,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                    ),
                    child: Text(
                      data.txtAddDonation,
                      style: TextStyle(
                        fontSize: space.space_200,
                        color: colors.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const ListViewWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.primary,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const BottomsheetWidget(),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
