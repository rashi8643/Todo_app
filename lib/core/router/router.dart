import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samsidh_task/features/authentication/presentation/pages/login_page.dart';
import 'package:samsidh_task/features/authentication/presentation/pages/signup_page.dart';
import 'package:samsidh_task/features/home_page/presentation/pages/home_page.dart';

part 'router.g.dart';

final _router = GoRouter(initialLocation: LoginPage.routePath, routes: [
  GoRoute(
    path: LoginPage.routePath,
    builder: (context, state) => const LoginPage(),
    name: 'login',
  ),
  GoRoute(
    path: SingUpPage.routePath,
    builder: (context, state) => const SingUpPage(),
    name: 'signup',
  ),
  GoRoute(
    path: HomePage.routePath,
    builder: (context, state) => const HomePage(),
    name: 'home',
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser!.email;
      if (user == null) {
        return LoginPage.routePath;
      }
      return null;
    },
  ),
]);
@riverpod
GoRouter router(RouterRef ref) {
  return _router;
}
