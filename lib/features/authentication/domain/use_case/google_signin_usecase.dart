import 'package:samsidh_task/core/Excepations/Authentication/authentication_faild_excepation.dart';
import 'package:samsidh_task/features/authentication/domain/repository/auth_repository.dart';

final class GoogleSignInUseCase {
  final AuthRepository repository;
  GoogleSignInUseCase({required this.repository});
  Future<void> call() async {
    try {
      await repository.googleSignIn();
    } on Exception {
      throw AuthenticationFailedException(
        "Google SignIn failed please retry",
      );
    }
  }
}
