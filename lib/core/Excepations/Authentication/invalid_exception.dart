import 'package:samsidh_task/core/Excepations/base_excepation.dart';

final class InvalidCredentialsException extends BaseException {
  InvalidCredentialsException() : super('Invalid user input');
}
