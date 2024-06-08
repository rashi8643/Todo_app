import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:samsidh_task/core/theme/app_theme.dart';
import 'package:samsidh_task/features/authentication/presentation/provider/auth_provider.dart';

class HomePage extends ConsumerWidget {
  static const routePath = '/homePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppTheme.of(context).colors;
    final space = AppTheme.of(context).spaces;
    return Scaffold(
      backgroundColor: colors.secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: space.space_700 * 1.8,
              color: const Color(0xFF0ab6ab),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bar_chart),
                  ),
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF0ab6ab),
        onPressed: () {},
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
