import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/screens/main/main_screen.dart';
import 'package:pause/screens/sign/social_login_result_screen.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../widgets/custom_action_button.dart';
import '../../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;

  void kakaoSignIn() async {
    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      User user = await UserApi.instance.me();
      String? userEmail = user.kakaoAccount?.email;
      if (userEmail == null) throw Exception('이메일이 존재하지 않습니다');
      if (!mounted) return;
      print(userEmail);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SocialLoginResultScreen(social: 'kakao', email: userEmail)));
    } catch (e) {
      log('kakaoSignIn Error : $e');
      return;
    }
  }

  void naverSignIn() async {
    try {
      NaverLoginResult result = await FlutterNaverLogin.logIn();
      if (result.status != NaverLoginStatus.loggedIn) {
        throw Exception('로그인을 실패했습니다');
      }
      if (!mounted) return;
      print("네이버 로그인 이메일 : ${result.account.email}");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SocialLoginResultScreen(
                  social: 'naver', email: result.account.email)));
    } catch (e) {
      log('naverSignIn Error : $e');
      return;
    }
  }

  void appleSignIn() async {
    try {
      AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
        scopes: [AppleIDAuthorizationScopes.email],
      );
      if (credential.identityToken == null) {
        throw Exception('로그인을 실패했습니다');
      }
      List<String> jwt = credential.identityToken?.split('.') ?? [];
      //jwt는 header, payload, verify 로 나뉘어져있고, payload 에 데이터가 저장되어있음
      //jwt을 복호화해서 필요한 정보를 가져오는 과정
      String payload = jwt[1];
      payload = base64.normalize(payload);

      final List<int> jsonData = base64.decode(payload);
      final userInfo = jsonDecode(utf8.decode(jsonData));
      String email = userInfo['email'];
      if (!mounted) return;
      print(email);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SocialLoginResultScreen(social: 'apple', email: email)));
    } catch (e) {
      log('appleSignIn Error : $e');
      return;
    }
  }

  void googleSignIn() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) throw Exception('로그인을 실패했습니다');
      if (!mounted) return;
      print(account.email);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SocialLoginResultScreen(
                  social: 'google', email: account.email)));
    } catch (e) {
      log('googleSignIn Error : $e');
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Column(
        children: [
          const Spacer(flex: 4),
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
                '회원이 아니신가요?',
                style: TextStyle(
                  fontSize: 12,
                  height: 14 / 12,
                  color: kBlack300,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '회원가입하기',
                style: TextStyle(
                  fontSize: 12,
                  height: 14 / 12,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          CustomTextField(
            controller: _emailController,
            hintText: '이메일 주소',
            textChanged: (text) => setState(() {}),
            inputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: _passwordController,
            hintText: '비밀번호',
            textChanged: (text) => setState(() {}),
            obscureText: !_showPassword,
            showClicked: () => setState(() => _showPassword = !_showPassword),
          ),
          const SizedBox(height: 27),
          CustomActionButton(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MainScreen()));
            },
            text: '로그인 하기',
          ),
          const SizedBox(height: 27),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SNS 간편 로그인',
                style: TextStyle(
                  fontSize: 12,
                  height: 14 / 12,
                  color: kBlack300,
                ),
              ),
              const SizedBox(width: 10),
              kCustomSocialSignIn(
                onTap: () => kakaoSignIn(),
                image: 'assets/logo/social/kakao.png',
              ),
              const SizedBox(width: 10),
              kCustomSocialSignIn(
                onTap: () => naverSignIn(),
                image: 'assets/logo/social/naver.png',
              ),
              const SizedBox(width: 10),
              if (Platform.isIOS)
                kCustomSocialSignIn(
                  onTap: () => appleSignIn(),
                  image: 'assets/logo/social/apple.png',
                )
              else
                kCustomSocialSignIn(
                  onTap: () => googleSignIn(),
                  image: 'assets/logo/social/google.jpg',
                ),
            ],
          ),
          const Spacer(flex: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '비밀번호를 잃어버리셨나요?',
                style: TextStyle(
                  fontSize: 12,
                  height: 14 / 12,
                  color: kBlack300,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '비밀번호찾기',
                style: TextStyle(
                  fontSize: 12,
                  height: 14 / 12,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 87),
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
