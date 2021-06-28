import 'dart:async';

import 'package:poggit_ci/services/auth_service.dart';
import 'package:flutter/foundation.dart';

class SignInManager {
  SignInManager({required this.auth, required this.isLoading});
  final AuthService auth;
  final ValueNotifier<bool> isLoading;

  Future<MyAppUser> _signIn(Future<MyAppUser> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<MyAppUser> signInAnonymously() async {
    return await _signIn(auth.signInAnonymously);
  }

  Future<MyAppUser> signInWithGoogle() async {
    return await _signIn(auth.signInWithGoogle);
  }

  Future<MyAppUser> signInWithFacebook() async {
    return await _signIn(auth.signInWithFacebook);
  }

  Future<MyAppUser> signInWithApple() async {
    return await _signIn(auth.signInWithApple);
  }
}
