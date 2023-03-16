import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rolling_together/data/remote/auth/controller/firebase_auth_controller.dart';
import 'package:rolling_together/ui/screens/init_map_screen.dart';

final AuthController authController = AuthController.to;

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      if (authController.user == null) {
        return loginBody(context);
      } else {
        return AlertDialog(
          title: Container(
            alignment: Alignment.center,
            child: Text('로그인 성공'),
          ),
          actions: [
            TextButton(
              child: Text('확인'),
              onPressed: () {
                Get.to(InitMapScreen());
              },
            ),
          ],
        );
      }
    }));
  }

  Widget loginBody(BuildContext context) {
    return ListView(
      children: [
        Container(
            color: Color(0xff2D3C72),
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.2,
                bottom: MediaQuery.of(context).size.height * 0.1),
            child: Text(
              'Rolling\nTogether',
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
              ),
              textAlign: TextAlign.center,
            ) /*Image.asset(
              'assets/images/logo_w.png',
              width: 90,
              height: 90,
            ),*/
            ),
        Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 50, bottom: 0),
          height: MediaQuery.of(context).size.height,
          child: _LoginForm(),
        ),
      ],
    );
  }
}

Widget _LoginForm() {
  return Form(
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 10),
          width: 300,
          child: CustomTextFormField(
            controller: authController.idTextController,
            hint: "ID", //// 텍스트 정렬 center
          ),
        ),
        Container(
          width: 300,
          child: CustomTextFormField(
            controller: authController.pwTextController,
            hint: "Password",
          ),
        ),
        Container(
          width: 300,
          height: 40,
          margin: EdgeInsets.only(top: 30),
          child: CustomElevatedButton(
            text: "login",
            funPageRoute: () {
              authController.login(authController.idTextController.text,
                  authController.pwTextController.text);
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}

//customtextformField
class CustomTextFormField extends StatelessWidget {
  static final TextInputFormatter digitsOnly =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  final String hint;
  final TextEditingController controller;

  const CustomTextFormField({required this.hint, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: _Form(),
    );
  }

  Widget _Form() {
    return TextFormField(
      controller: controller,
      textAlignVertical: TextAlignVertical.bottom,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Color(0xff006285),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

//customElevatedButton
class CustomElevatedButton extends StatelessWidget {
  final String text;
  final funPageRoute;

  const CustomElevatedButton({required this.text, required this.funPageRoute});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xff2D3C72),
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: funPageRoute,
      child: Text("$text"),
    );
  }
}
