import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samsidh_task/core/Excepations/base_excepation.dart';
import 'package:samsidh_task/core/utils/snakbar_utils.dart';
import 'package:samsidh_task/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:samsidh_task/features/authentication/domain/repository/auth_repository.dart';
import 'package:samsidh_task/features/authentication/domain/use_case/google_signin_usecase.dart';
import 'package:samsidh_task/features/authentication/domain/use_case/signin_usecase.dart';
import 'package:samsidh_task/features/authentication/domain/use_case/signuot_usecase.dart';
import 'package:samsidh_task/features/authentication/domain/use_case/signup_usecase.dart';
import 'package:samsidh_task/features/authentication/presentation/pages/login_page.dart';
import 'package:samsidh_task/features/home_page/presentation/pages/home_page.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
class Authentication extends _$Authentication {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final AuthRepository repository;
  @override
  void build(BuildContext context) {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repository = ref.read(authRepositoryProvider);
  }

  Future<void> signup(String email, String password) async {
    try {
      await SignupUsecase(repository: repository)(email, password);
      Future.sync(() => context.go(HomePage.routePath));
    } on BaseException catch (e) {
      Future.sync(() => SnackbarUtils.showMessage(context, e.message));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await LoginUsecase(repository: repository)(email, password);
      Future.sync(() => context.go(HomePage.routePath));
    } on BaseException catch (e) {
      Future.sync(() => SnackbarUtils.showMessage(context, e.message));
    }
  }

  Future<void> googleSignIn() async {
    try {
      await GoogleSignInUseCase(repository: repository)();
      Future.sync(() => context.go(HomePage.routePath));
    } on BaseException catch (e) {
      Future.sync(() => SnackbarUtils.showMessage(context, e.message));
    }
  }

  Future<void> logout() async {
    try {
      await LogoutUsecase(repository: repository)();
      Future.sync(() => context.go(LoginPage.routePath));
    } on BaseException catch (e) {
      Future.sync(() => SnackbarUtils.showMessage(context, e.message));
    }
  }
}
