import 'package:samsidh_task/core/Excepations/Authentication/authentication_faild_excepation.dart';
import 'package:samsidh_task/features/authentication/domain/repository/auth_repository.dart';

final class LogoutUsecase {
  final AuthRepository repository;
  LogoutUsecase({required this.repository});

  Future<void> call() async {
    try {
      await repository.signOut();
    } on Exception {
      throw AuthenticationFailedException(
          'Cannot logout. Please check your network');
    }
  }
}
