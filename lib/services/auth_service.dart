import 'dart:async';

import 'package:meta/meta.dart';
import 'package:the_apple_sign_in/scope.dart';

@immutable
class MyAppUser {
  const MyAppUser({
    required this.uid,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  final String uid;
  final String? email;
  final String? photoUrl;
  final String? displayName;
}

abstract class AuthService {
  Future<MyAppUser?> currentUser();
  Future<MyAppUser> signInAnonymously();
  Future<MyAppUser> signInWithEmailAndPassword(String email, String password);
  Future<MyAppUser> createUserWithEmailAndPassword(
      String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<MyAppUser> signInWithEmailAndLink(
      {required String email, required String link});
  bool isSignInWithEmailLink(String link);
  Future<void> sendSignInWithEmailLink({
    required String email,
    required String url,
    required bool handleCodeInApp,
    required String iOSBundleId,
    required String androidPackageName,
    required bool androidInstallApp,
    required String androidMinimumVersion,
  });
  Future<MyAppUser> signInWithGoogle();
  Future<MyAppUser> signInWithFacebook();
  Future<MyAppUser> signInWithApple({List<Scope> scopes = const []});
  Future<void> signOut();
  Stream<MyAppUser> get onAuthStateChanged;
  void dispose();
}
