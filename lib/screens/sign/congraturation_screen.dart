import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';
import 'package:pause/screens/sign/login_screen.dart';
import 'package:pause/widgets/custom_action_button.dart';

class CongraturationScreen extends StatefulWidget {
  const CongraturationScreen({super.key});

  @override
  State<CongraturationScreen> createState() => _CongraturationScreenState();
}

class _CongraturationScreenState extends State<CongraturationScreen> {
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
              Text(
                '야옹님,\n가입을 축하합니다 🎉',
                style: TextStyle(
                  color: Color(0xFF404040),
                  fontSize: 28,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Text(
                '퍼즈에 오신 것을 환영합니다!\n저희와 함께 알찬 시간을 만들어 보세요.',
                style: TextStyle(
                  color: Color(0xFF696868),
                  fontSize: 15,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 328,
                height: 249,
                child: Stack(
                  children: [
                    Positioned(child: Image.asset('assets/logo/puzy.png')),
                    Positioned(
                        left: 190,
                        top: 132,
                        child: Image.asset('assets/logo/baram.png')),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              CustomActionButton(
                text: '확인',
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
              const Spacer(flex: 3),
            ],
          ),
        ],
      ),
    );
  }
}
