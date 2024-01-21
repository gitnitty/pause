import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/screens/sign/login_screen.dart';
import 'package:pause/widgets/custom_action_button.dart';
import 'package:pause/widgets/custom_text_field.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _newpasswordcheckController =
      TextEditingController();

  bool _showPassword = false;

  String? _validatePassword() {
    String password = _newpasswordController.text;
    String confirmPassword = _newpasswordcheckController.text;

    if (password != confirmPassword) {
      return '비밀번호가 일치하지 않습니다.';
    }

    if (password.length < 9 ||
        !password.contains(RegExp(r'[a-zA-Z]')) ||
        !password.contains(RegExp(r'[0-9]'))) {
      return '비밀번호는 9자 이상이어야 하며, 영문과 숫자를 모두 포함해야 합니다.';
    }

    return null;
  }

  void _onConfirmPressed() {
    String? validationMessage = _validatePassword();

    if (validationMessage != null) {
      // 오류 메시지가 있는 경우 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationMessage),
          backgroundColor: Colors.red, // 오류 메시지는 빨간색 배경으로 표시
        ),
      );
      return;
    }

    // 성공 메시지 표시
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('비밀번호가 성공적으로 재설정되었습니다.'),
        backgroundColor: Colors.green, // 성공 메시지는 녹색 배경으로 표시
      ),
    );

    // 정상적인 경우에는 다음 페이지로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              const Spacer(flex: 4),
              SizedBox(
                width: 300,
                child: Text(
                  '비밀번호 재설정',
                  style: TextStyle(
                    color: Color(0xFF404040),
                    fontSize: 26,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 36,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  '새로운 비밀번호를 입력해주세요.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              CustomTextField(
                controller: _newpasswordController,
                hintText: '새 비밀번호 입력',
                textChanged: (text) => setState(() {}),
                obscureText: !_showPassword,
                showClicked: () =>
                    setState(() => _showPassword = !_showPassword),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _newpasswordcheckController,
                hintText: '새 비밀번호 확인',
                textChanged: (text) => setState(() {}),
                obscureText: !_showPassword,
                showClicked: () =>
                    setState(() => _showPassword = !_showPassword),
              ),
              SizedBox(
                height: 36,
              ),
              CustomActionButton(
                text: '확인',
                onTap: _onConfirmPressed,
              ),
              const Spacer(flex: 4),
            ],
          ),
        ],
      ),
    );
  }
}
