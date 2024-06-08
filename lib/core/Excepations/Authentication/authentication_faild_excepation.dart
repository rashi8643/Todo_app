import 'package:samsidh_task/core/Excepations/base_excepation.dart';

final class AuthenticationFailedException extends BaseException {
  AuthenticationFailedException(super.reason);
}
