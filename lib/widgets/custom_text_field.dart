import 'package:flutter/material.dart';
import 'package:pause/constants/constants_color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function textChanged;
  final Function? showClicked;
  final int? maxLength;
  final TextInputType? inputType;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.textChanged,
    this.maxLength,
    this.inputType,
    this.obscureText = false,
    this.showClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: kTextFieldBorderColor,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLength: maxLength,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          counterText: '',
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: kTextFieldHintColor,
            height: 20 / 16,
          ),
          suffix: obscureText
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (showClicked == null) return;
                    showClicked!();
                  },
                  child: Text(
                    'Show',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      height: 20 / 16,
                    ),
                  ),
                )
              : null,
        ),
        onChanged: (text) => textChanged(text),
        style: TextStyle(
          fontSize: 16,
          color: kBlack300,
          height: 20 / 16,
        ),
      ),
    );
  }
}
