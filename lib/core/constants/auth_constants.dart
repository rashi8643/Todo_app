import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_constants.g.dart';

final class AuthConstans {
  final String txtLogin = 'Login';
  final String txtWelcome = 'Welcome Back';
  final String txtCreate = 'Create New One';
  final String txtSignUp = 'Sign Up';
  final String txtEmail = 'Email';
  final String txtPass = 'Password';
  final String txtFogot = 'Forgot?';
  final String txtContinue = 'Or Continue With';
  final String txtDontHave = """Don't have account?""";
  final String txtGoogleImage = 'assets/images/login_google.png';
  final String txtGoogle = 'Google';
  final String txtAlready = 'You have Already Account?';
}

@riverpod
AuthConstans authConstans(AuthConstansRef ref) {
  return AuthConstans();
}
