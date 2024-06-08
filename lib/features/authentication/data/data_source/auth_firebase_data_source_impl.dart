import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samsidh_task/core/Excepations/Authentication/authentication_faild_excepation.dart';
import 'package:samsidh_task/features/authentication/data/data_source/auth_firebase_data_source.dart';

part 'auth_firebase_data_source_impl.g.dart';

class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final FirebaseAuth auth;
  AuthFirebaseDataSourceImpl(this.auth);
  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthenticationFailedException(
            'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthenticationFailedException(
            'The account already exists for this email.');
      } else {
        throw AuthenticationFailedException('Cannot signup. Please try again');
      }
    }
  }

  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthenticationFailedException('Wrong email address');
      } else if (e.code == 'wrong-password') {
        throw AuthenticationFailedException('Wrong password');
      } else if (e.code == 'user-disabled') {
        throw AuthenticationFailedException('User is disabled. Cannot login');
      } else {
        throw AuthenticationFailedException('Cannot login. Please try again');
      }
    }
  }

  @override
  Future<void> googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}

@riverpod
AuthFirebaseDataSource authFirebaseDataSource(AuthFirebaseDataSourceRef ref) {
  return AuthFirebaseDataSourceImpl(FirebaseAuth.instance);
}
