import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  static const tag = 'AuthController';
  static AuthController get to => Get.find<AuthController>();
  final Rxn<User> firebaseUser = Rxn<User>();

  User? get user => firebaseUser.value;

  @override
  void onInit() {
    firebaseUser.bindStream(FirebaseAuth.instance.authStateChanges());
    login('jesp0305@gmail.com', 'rtrt2023');
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
    } catch (e) {
      Get.snackbar("로그 아웃 실패", e.toString());
    }
  }

  bool get isLoggedIn => user != null;
}
