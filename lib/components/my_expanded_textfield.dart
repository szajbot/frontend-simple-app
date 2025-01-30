import 'package:flutter/material.dart';

class MyExpandedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final double height;
  const MyExpandedTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText, required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey.shade700),
          ),
          child: TextField(
            maxLines: null,
            keyboardType: TextInputType.multiline,
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(
              fontSize: 14
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 15),
              border: InputBorder.none,
            ),
          ),
        )
    );


  }
}
