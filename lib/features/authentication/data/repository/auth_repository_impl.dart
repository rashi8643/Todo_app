import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:samsidh_task/features/authentication/data/data_source/auth_firebase_data_source.dart';
import 'package:samsidh_task/features/authentication/data/data_source/auth_firebase_data_source_impl.dart';
import 'package:samsidh_task/features/authentication/domain/repository/auth_repository.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<UserCredential> signUp(String email, String password) async {
    return await dataSource.signUp(email, password);
  }

  @override
  Future<UserCredential> signIn(String email, String password) async {
    return await dataSource.signIn(email, password);
  }

  @override
  Future<void> googleSignIn() async {
    await dataSource.googleSignIn();
  }

  @override
  Future<void> signOut() async {
    await dataSource.signOut();
  }
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    dataSource: ref.watch(authFirebaseDataSourceProvider),
  );
}
