import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rolling_together/data/remote/user/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rolling_together/data/remote/grade/service/user_grade_service.dart';

import '../../../../ui/screens/init_map_screen.dart';
import '../../user/service/report_list_service.dart';

class AuthController extends GetxController {
  static const tag = 'AuthController';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static AuthController get to => Get.find<AuthController>();
  final Rxn<UserDto> myUserDto = Rxn();

  late User? myUser;

  final TextEditingController idTextController = TextEditingController();
  final TextEditingController pwTextController = TextEditingController();

  final ReportListService reportListService = ReportListService();
  final UserGradeService userGradeService = UserGradeService();

  @override
  void onInit() {
    _auth.authStateChanges().listen((User? user) {
      myUser = user;

      // 로그아웃 된 상태
      if (user == null) {
        clearMyUserData();
        myUserDto.value = null;
      } else {
        // 로그인 된 상태
        getMyUserData().then((value) {
          myUserDto.value = value;
          loadMyGrade();
        }, onError: (obj) {
          // 로그인 되었지만 로컬DB에 내 정보가 저장되지 않음
          loadMyUserData();
        });
      }
    });
    super.onInit();
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar("로그인 실패", e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.snackbar("로그 아웃 성공", "");
    } catch (e) {
      Get.snackbar("로그 아웃 실패", e.toString());
    }
  }

  /// 내 로그인 정보 저장
  Future<void> saveMyUserData(String email, String name, String id) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('name', name);
    prefs.setString('id', id);
  }

  /// 내 로그인 정보 가져오기
  Future<UserDto?> getMyUserData() async {
    final prefs = await SharedPreferences.getInstance();

    final email = prefs.getString("email");
    final name = prefs.getString("name");
    final id = prefs.getString("id");

    if (email == null || name == null || id == null) {
      return Future.error('');
    } else {
      return Future.value(UserDto(email: email, name: name, id: id));
    }
  }

  Future<bool> clearMyUserData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("email");
    prefs.remove("name");
    prefs.remove("id");

    return true;
  }

  loadMyUserData() {
    reportListService.loadMyUserData(myUser!.uid).then((myUserData) {
      myUserDto.value = myUserData!;
      saveMyUserData(myUserData.email, myUserData.name, myUserData.id!);
      loadMyGrade();
    }, onError: (error) {
      Get.snackbar("내 정보 로드 실패", error.toString());
    });
  }

  loadMyGrade() {
    userGradeService.getUserGrade(myUser!.uid).then((grade) {
      final myUser = myUserDto.value!;
      myUser.userGradeDto = grade;
      myUserDto.value = myUser;

      Get.to(const InitMapScreen());
    }, onError: (obj) {});
  }
}
