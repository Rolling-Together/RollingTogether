import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Color(0xff2D3C72),
            padding: EdgeInsets.only(top: 200, bottom: 50),
            child: Image.asset(
              'assets/images/logo_w.png',
              width: 90,
              height: 90,
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 50, bottom: 0),
            height: MediaQuery.of(context).size.height,
            child: _LoginForm(),
          ),
        ],
      ),
    );
  }

  Widget _LoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            width: 300,
            child: CustomTextFormField(
              hint: "Student Number", //텍스트 정렬 center
              funValidator: validateStudentNumber(),
            ),
          ),
          Container(
            width: 300,
            child: CustomTextFormField(
              hint: "Password",
              funValidator: validatePassWord(),
            ),
          ),
          Container(
            width: 300,
            height: 40,
            margin: EdgeInsets.only(top: 30),
            child: CustomElevatedButton(
              text: "LOGIN",
              funPageRoute: () {
                if (_formKey.currentState!.validate()) {
                  Get.to(HomePage());
                }
                ;
                setLogin();
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 250,
            height: 40,
            color: Colors.white,
            child: TextButton(
              onPressed: () {
                Get.to(JoinPage());
              },
              child:
              Text("SIGN UP", style: TextStyle(color: Color(0xff2D3C72))),
            ),
          ),
        ],
      ),
    );
  }
}

//customtextformField
class CustomTextFormField extends StatelessWidget {
  static final TextInputFormatter digitsOnly =
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));

  final String hint;
  final funValidator;

  const CustomTextFormField({required this.hint, required this.funValidator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: _Form(),
    );
  }

  Widget _Form() {
    return TextFormField(
      textAlignVertical: TextAlignVertical.bottom,
      obscureText: hint == "Password" ? true : false,
      validator: funValidator,
      keyboardType: hint == "Student Number"
          ? TextInputType.number
          : (hint == "Password"
          ? TextInputType.visiblePassword
          : (hint == "E-mail"
          ? TextInputType.emailAddress
          : TextInputType.phone)),
      inputFormatters: hint == "Student Number" || hint == "PhoneNumber"
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : <TextInputFormatter>[],
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        hintText: "$hint",
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

  const CustomElevatedButton({required this.text,required this.funPageRoute});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Color(0xff2D3C72),
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

//validator
import 'package:validators/validators.dart';

Function validateStudentNumber() {
  return (String? value) {
    if (value!.isEmpty)
      return "학생번호를 입력해주세요.";
    else if (value.length != 9)
      return "학생번호는 9자리 입니다.";
    else
      return null;
  };
}
Function validateName() {
  return (String? value) {
    if (value!.isEmpty)
      return "이름을 입력해주세요.";
    else if (value.length > 100 )
      return "이름을 정확히 입력해주세요.";
    else
      return null;
  };
}
Function validatePassWord() {
  return (String? value) {
    if (value!.isEmpty)
      return "비밀번호를 입력해주세요.";
    else if (value.length < 8)
      return "비밀번호는 8자리 이상으로 설정해주세요.";
    else if (value.length > 15)
      return "비밀번호는 15자리 이하로 설정해주세요.";
    else
      return null;
  };
}
Function validateEmail() {
  return (String? value) {
    if (value!.isEmpty)
      return "이메일을 입력해주세요.";
    else if(!isEmail(value))
      return "이메일 형식에 맞지 않습니다.";
    else
      return null;
  };
}
Function validatePhone() {
  return (String? value) {
    if (value!.isEmpty)
      return "전화번호를 입력해주세요.";
    else if(value.length != 11)
      return "전화번호를 올바르게 입력해주세요.";
    else
      return null;
  };
}
Function validateTitle() {
  return (String? value) {
    if (value!.isEmpty)
      return "제목을 작성해주세요.";
    else if(value.length < 5)
      return "5글자 이상 입력해주세요.";
    else if(value.length > 30)
      return "제목의 길이를 초과하였습니다.";
    else
      return null;
  };
}
Function validateContents() {
  return (String? value) {
    if (value!.isEmpty)
      return "내용을 작성해주세요.";
    else if(value.length < 5)
      return "5글자 이상 입력해주세요.";
    else if(value.length > 500)
      return "500글자를 초과할 수 없습니다.";
    else
      return null;
  };
}