import 'package:flutter/material.dart';
import 'package:recipes/utils/colors.dart';
import 'package:recipes/widgets/customText.dart';

class CustomButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String text;
  final double ?textSize;
  final Color ?buttonColor;
  final Color ?textColor;
  final EdgeInsets? padding;

  CustomButton({
    required this.onPressed,
    required this.text,
    this.padding = const EdgeInsets.symmetric(vertical: 10),
    this.textSize = 18,
    this.buttonColor = primaryColor,
    this.textColor = Colors.white
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
        text: text,
        size: textSize,
        color: textColor,
      ),
      style: TextButton.styleFrom(
          backgroundColor: buttonColor,
          padding: padding
      ),
    );
  }
}