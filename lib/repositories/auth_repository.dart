import 'package:cubit_login/models/failure_model.dart';
import 'package:cubit_login/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/services.dart';

class AuthRepository {
  final auth.FirebaseAuth _firebaseAuth;

  AuthRepository({auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? auth.FirebaseAuth.instance;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((fireUser) {
      final user = fireUser == null ? User.empty : fireUser.toUser;
      return user;
    });
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
      ]);
    } catch (err) {
      throw err.toString();
    }
  }

  Future<User> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // ignore: non_constant_identifier_names
      final UserCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserCredential.user!;
      return user.toUser;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message ?? '');
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message ?? '');
    }
  }

  Future<User> signUpWithEmailAndPassword({
    required String userName,
    required String email,
    required String password,
  }) async {
    try {
      // ignore: non_constant_identifier_names
      final UserCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final fireUser = UserCredential.user!;

      final user = User.empty.copyWith(
        id: fireUser.uid,
        name: userName,
        email: email,
      );
      // await _firebaseFirestore
      //     .collection('users')
      //     .doc(fireUser.uid)
      //     .set(user.toDocument());

      return user;
    } on auth.FirebaseAuthException catch (err) {
      throw Failure(code: err.code, message: err.message ?? '');
    } on PlatformException catch (err) {
      throw Failure(code: err.code, message: err.message ?? '');
    }
  }
}

extension on auth.User {
  User get toUser {
    return User(
      id: uid,
      name: displayName ?? '',
      email: email ?? '',
      photo: photoURL ?? '',
    );
  }
}
