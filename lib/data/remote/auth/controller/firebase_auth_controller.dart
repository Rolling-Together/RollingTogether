import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rolling_together/data/remote/user/models/user.dart';

class AuthController extends GetxController {
  static const tag = 'AuthController';

  static AuthController get to => Get.find<AuthController>();
  final Rxn<User> firebaseUser = Rxn();
  final Rxn<UserDto> myUserDto = Rxn();

  User? get user => firebaseUser.value;

  final TextEditingController idTextController = TextEditingController();
  final TextEditingController pwTextController = TextEditingController();

  @override
  void onInit() {
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value = result.user;
    } catch (e) {
      Get.snackbar("로그인 실패", e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      firebaseUser.value = null;
      Get.snackbar("로그 아웃 성공", "");
    } catch (e) {
      Get.snackbar("로그 아웃 실패", e.toString());
    }
  }

  bool get isLoggedIn => user != null;
}
