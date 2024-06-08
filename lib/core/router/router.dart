import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samsidh_task/features/authentication/presentation/pages/login_page.dart';

part 'router.g.dart';

final _router = GoRouter(initialLocation: LoginPage.routePath, routes: [
  GoRoute(
    path: LoginPage.routePath,
    builder: (context, state) => LoginPage(),
    name: 'login',
  ),
]);
@riverpod
GoRouter router(RouterRef ref) {
  return _router;
}
