import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/screens/sign/password_setting.dart';
import 'package:pause/widgets/custom_action_button.dart';
import 'package:pause/widgets/custom_text_field.dart';

class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({Key? key}) : super(key: key);

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  bool _showCode = false;
  String _errorMessage = '';
  late String _generatedCode; // 생성된 코드를 저장하기 위한 변수

  bool _isEmailValid(String email) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }

  bool _checkExistingEmail(String email) {
    // 여기에 데이터베이스 확인 로직을 추가하세요.
    // 예제로 무조건 존재한다고 가정합니다.
    return true;
  }

  String _generateCode() {
    const int codeLength = 6;
    const String chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    Random random = Random();
    String code = '';
    for (int i = 0; i < codeLength; i++) {
      code += chars[random.nextInt(chars.length)];
    }
    return code;
  }

  void _sendEmailWithCode(String email, String code) {
    // 이메일 전송 등의 로직 수행
    // 이 부분에 원하는 동작을 추가하세요.
    // 여기에서는 성공 메시지를 띄웁니다.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('전송 완료'),
          backgroundColor: Colors.white,
          content: Text('이메일 전송이 완료되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '확인',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void _validateAndSendCode() {
    String email = _emailController.text;

    if (!_isEmailValid(email)) {
      setState(() {
        _errorMessage = '올바른 이메일 형식이 아닙니다.';
      });
      return;
    }

    if (!_checkExistingEmail(email)) {
      setState(() {
        _errorMessage = '존재하지 않는 이메일 주소입니다.';
      });
      return;
    }

    setState(() {
      _errorMessage = '';
      _generatedCode = _generateCode();
      print('코드: $_generatedCode'); // 생성된 코드 저장
    });

    _sendEmailWithCode(email, _generatedCode);
  }

  void _checkEnteredCode() {
    String enteredCode = _codeController.text;

    if (enteredCode.length != 6) {
      setState(() {
        _errorMessage = '코드는 6자여야 합니다.';
      });
      return;
    }

    if (!CodeUtil.verifyCode(_generatedCode, enteredCode)) {
      setState(() {
        _errorMessage = '코드가 일치하지 않습니다.';
      });
      return;
    }

    setState(() {
      _errorMessage = '';
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SetPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(flex: 4),
          SizedBox(
            width: 300,
            child: Text(
              '비밀번호를\n잊어버리셨나요?',
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
              '이메일로 발송된 코드를 입력해 주세요.',
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                width: 221,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: kTextFieldBorderColor),
                ),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    counterText: '',
                    hintText: '이메일',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: kTextFieldHintColor,
                      height: 20 / 16,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    height: 20 / 16,
                  ),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Container(
                width: 75,
                height: 50,
                child: ElevatedButton(
                  onPressed: _validateAndSendCode,
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFA078),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.40),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '인증',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.08,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          CustomTextField(
            controller: _codeController,
            hintText: '코드 입력',
            obscureText: !_showCode,
            textChanged: () => setState(() => _showCode = !_showCode),
            showClicked: () {},
          ),
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          SizedBox(
            height: 36,
          ),
          CustomActionButton(
            text: '다음',
            onTap: _checkEnteredCode,
          ),
          const Spacer(flex: 4),
        ],
      ),
    );
  }
}

class CodeUtil {
  static bool verifyCode(String generatedCode, String enteredCode) {
    return generatedCode == enteredCode;
  }
}
