import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/screens/sign/congraturation.dart';
import 'package:pause/screens/sign/login_screen.dart';
import 'package:pause/widgets/custom_action_button.dart';
import 'package:pause/widgets/custom_text_field.dart';
import 'package:pause/widgets/custrom_agreement_checkbox.dart';

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({Key? key}) : super(key: key);

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkpasswordController =
      TextEditingController();

  bool _showPassword = false;
  String _errorMessage = '';

  bool validatePassword() {
    String password = _passwordController.text;
    String confirmPassword = _checkpasswordController.text;

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = '비밀번호가 일치하지 않습니다.';
      });
      return false;
    }

    if (password.length < 9 ||
        !password.contains(RegExp(r'[a-zA-Z]')) ||
        !password.contains(RegExp(r'[0-9]'))) {
      setState(() {
        _errorMessage = '비밀번호는 9자 이상이어야 하며,\n 영문과 숫자를 모두 포함해야 합니다.';
      });
      return false;
    }

    setState(() {
      _errorMessage = '';
    });

    return true;
  }

  void onEmailChanged(String email) {
    setState(() {
      _errorMessage = '';
      String emailPattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
      RegExp regex = RegExp(emailPattern);
      if (!regex.hasMatch(email)) {
        _errorMessage = '올바른 이메일 형식이 아닙니다.';
      }
    });
  }

  bool checkDuplicateEmail(String email) {
    // Replace this line with your actual logic to check for duplicate emails
    bool isDuplicate = email == 'existing@example.com';

    if (isDuplicate) {
      setState(() {
        _errorMessage = '이미 존재하는 이메일 주소입니다.';
      });
    }

    return !isDuplicate;
  }

  void signUp() async {
    String email = _emailController.text;

    if (!checkDuplicateEmail(email)) {
      return;
    }

    if (validatePassword()) {
      // Save user data to the database
      //await DatabaseService().saveUserDataToDatabase(email, _passwordController.text);

      // Continue with navigation or other actions
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CongraturationScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          const Spacer(flex: 2),
          SizedBox(
            width: 236,
            height: 85,
            child: Image.asset(
              'assets/logo/pause_logo.png',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '이미 회원이신가요?',
                style: TextStyle(
                  fontSize: 12,
                  height: 14 / 12,
                  color: kBlack300,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  '로그인하기',
                  style: TextStyle(
                    fontSize: 12,
                    height: 14 / 12,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          CustomTextField(
            controller: _emailController,
            hintText: '이메일 주소',
            textChanged: onEmailChanged,
            inputType: TextInputType.emailAddress,
            showClicked: () {},
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            hintText: '비밀번호',
            textChanged: (text) => setState(() {}),
            obscureText: !_showPassword,
            showClicked: () => setState(() => _showPassword = !_showPassword),
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _checkpasswordController,
            hintText: '비밀번호 확인',
            textChanged: (text) => setState(() {}),
            obscureText: !_showPassword,
            showClicked: () => setState(() => _showPassword = !_showPassword),
          ),
          if (_errorMessage.isNotEmpty)
            Text(
              _errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          const SizedBox(height: 27),
          AgreementCheckbox(),
          const SizedBox(height: 27),
          CustomActionButton(
            onTap: signUp,
            text: '회원가입',
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget kCustomSocialSignIn({required Function onTap, required String image}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: SizedBox(
        width: 26,
        height: 26,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Image.asset(
            image,
            width: 26,
            height: 26,
          ),
        ),
      ),
    );
  }
}
