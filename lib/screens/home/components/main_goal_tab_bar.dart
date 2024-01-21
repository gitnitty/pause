import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';

class MainGoalTabBar extends StatelessWidget {
  final int currentIndex;
  final Function onTap;

  const MainGoalTabBar(
      {Key? key, required this.currentIndex, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Color(0xFFD9D9D9)),
      )),
      child: Row(
        children: [
          kMainGoalTabBarItem(0, "주간"),
          kMainGoalTabBarItem(1, "월간"),
        ],
      ),
    );
  }

  Widget kMainGoalTabBarItem(int index, String title) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onTap(index),
        child: Container(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            width: 58,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              border: index == currentIndex
                  ? Border(
                      bottom: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    )
                  : null,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: index == currentIndex ? kPrimaryColor : kBlack100,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 15 / 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
