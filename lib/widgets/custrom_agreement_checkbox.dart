import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';

class AgreementCheckbox extends StatefulWidget {
  // 추가된 부분: privacyAgreementChecked 전달 받음

  const AgreementCheckbox({
    Key? key,
  }) : super(key: key);

  @override
  _AgreementCheckboxState createState() => _AgreementCheckboxState();
}

class _AgreementCheckboxState extends State<AgreementCheckbox> {
  bool isExpanded = false;
  bool allAgreementsChecked = false;
  bool termsAgreementChecked = false;
  bool privacyAgreementChecked = false;
  bool marketingAgreementChecked = false;

  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 24,
          width: 263,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    allAgreementsChecked = !allAgreementsChecked;
                    termsAgreementChecked = allAgreementsChecked;
                    privacyAgreementChecked = allAgreementsChecked;
                    marketingAgreementChecked = allAgreementsChecked;
                  });
                },
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Color(0xFFDCDCE2)),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: allAgreementsChecked
                        ? Icon(
                            Icons.check,
                            size: 12,
                            color: kBlackColor,
                          )
                        : Container(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                '전체 약관 동의',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 0.12,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: kBlackColor,
                ),
              ),
            ],
          ),
        ),
        if (isExpanded)
          Column(
            children: [
              SizedBox(
                height: 7,
              ),
              Container(
                width: 270,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.50,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              buildCheckboxRow(
                isChecked: termsAgreementChecked,
                title: '[필수] 퍼즈 이용 약관에 동의',
                onTap: () {
                  setState(() {
                    termsAgreementChecked = !termsAgreementChecked;
                  });
                },
                onAdditionalAction: () {
                  // Your additional action for the first button
                  print('Additional action for the first button');
                },
              ),
              buildCheckboxRow(
                isChecked: privacyAgreementChecked,
                title: '[필수] 개인정보 수집 및 이용에 동의',
                onTap: () {
                  setState(() {
                    privacyAgreementChecked = !privacyAgreementChecked;
                  });
                },
                onAdditionalAction: () {
                  // Your additional action for the second button
                  print('Additional action for the second button');
                },
              ),
              buildCheckboxRow(
                isChecked: marketingAgreementChecked,
                title: '[선택] 마케팅 정보 수신 및 선택적 개인정보 제공',
                onTap: () {
                  setState(() {
                    marketingAgreementChecked = !marketingAgreementChecked;
                  });
                },
                onAdditionalAction: () {
                  // Your additional action for the third button
                  print('Additional action for the third button');
                },
              ),
            ],
          ),
      ],
    );
  }

  Widget buildCheckboxRow({
    required bool isChecked,
    required String title,
    required VoidCallback onTap,
    required VoidCallback onAdditionalAction,
  }) {
    return Container(
      width: 266,
      height: 24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xFFDCDCE2)),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: isChecked
                    ? Icon(
                        Icons.check,
                        size: 12,
                        color: kBlackColor,
                      )
                    : Container(),
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 10,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
              height: 0.24,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: onAdditionalAction,
            child: Container(
              width: 11,
              height: 11,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Color(0xFFF9F9FB)),
                color: Color(0xFFF9F9FB),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 8,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
