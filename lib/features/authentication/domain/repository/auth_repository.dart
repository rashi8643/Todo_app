import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signUp(
    final String email,
    final String password,
  );
  Future<UserCredential> signIn(
    final String email,
    final String password,
  );
  Future<void> signOut();
  Future<void> googleSignIn();
}
