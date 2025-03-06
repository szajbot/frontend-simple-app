import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final double paddingSize;
  final double horizontalSize;
  final double fontSize;
  final Color fontColor;
  final Color buttonColor;

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.paddingSize,
    required this.horizontalSize,
    required this.fontSize,
    required this.fontColor,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(paddingSize),
        margin: EdgeInsets.symmetric(horizontal: horizontalSize),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(8),

        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: fontColor, fontWeight: FontWeight.bold, fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}