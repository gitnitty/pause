import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pause/screens/goalexecution/goal_execution_screen.dart';

import '../../constants/constants_color.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  Widget getScreen() {
    switch (_currentIndex) {
      case 0:
        return const Center(child: Text('page1'));
      case 1:
        return const Center(child: Text('page2'));
      case 2:
        return const Center(child: GoalExcutionScreen());
      case 3:
        return const Center(child: Text('page4'));
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: getScreen(),
      bottomNavigationBar: Container(
        color: kWhiteColor,
        child: SafeArea(
          child: Container(
            color: kWhiteColor,
            width: double.infinity,
            height: 68,
            child: Row(
              children: [
                kBottomNavigationBarItem(
                  activeImage: 'assets/icon/1_active.svg',
                  inactiveImage: 'assets/icon/1_inactive.svg',
                  index: 0,
                ),
                kBottomNavigationBarItem(
                  activeImage: 'assets/icon/2_active.svg',
                  inactiveImage: 'assets/icon/2_inactive.svg',
                  index: 1,
                ),
                kBottomNavigationBarItem(
                  activeImage: 'assets/icon/3_active.svg',
                  inactiveImage: 'assets/icon/3_inactive.svg',
                  index: 2,
                ),
                kBottomNavigationBarItem(
                  activeImage: 'assets/icon/4_active.svg',
                  inactiveImage: 'assets/icon/4_inactive.svg',
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget kBottomNavigationBarItem(
      {required String activeImage,
      required String inactiveImage,
      required int index}) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _currentIndex = index),
        child: Container(
          color: kWhiteColor,
          child: SvgPicture.asset(
            _currentIndex == index ? activeImage : inactiveImage,
          ),
        ),
      ),
    );
  }
}
