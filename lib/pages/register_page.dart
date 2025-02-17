import 'package:flutter/material.dart';

import '../colors.dart';
import '../components/my_buttom.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> signUserUp() async {
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      genericErrorMessage("Passwords do not match!");
      return;
    }

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/user/register'),
        headers: {
          'Content-Type': 'application/json' // 'application/x-www-form-urlencoded' or whatever you need
        },
        body: jsonEncode({
          "login": email,
          "password": password
        }),
      );

      Navigator.pop(context);

      if (response.statusCode == 200) {
        successMessage("Account created successfully!");

        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage(onTap: widget.onTap)),
          );
        });
      } else {
        genericErrorMessage("Registration failed.");
      }
    } catch (e) {
      Navigator.pop(context);
      genericErrorMessage(e.toString());
    }
  }

  /// ✅ Displays a success message
  void successMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// 🚨 Displays an error message
  void genericErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Registration Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                //logo
                const Icon(
                  Icons.lock_person_outlined ,
                  size: 130,
                  color: CustomColors.icon,
                ),

                const SizedBox(height: 50),

                //username
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 15),
                //password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 15),

                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 15),

                //sign in button
                MyButton(
                  onTap: signUserUp,
                  text: 'Sign Up',
                  paddingSize: 22,
                  horizontalSize: 25,
                  fontSize: 15,
                  fontColor: CustomColors.componentFont,
                  buttonColor: CustomColors.component,
                ),
                const SizedBox(height: 20),

                SizedBox(
                  height: MediaQuery.of(context).size.height - 650,
                ),

                Text(
                  'Already have an account? ',
                  style: TextStyle(color: CustomColors.componentFont, fontSize: 12),
                ),

                const SizedBox(
                  height: 10,
                ),

                MyButton(
                  onTap: widget.onTap,
                  text: 'Login now!',
                  paddingSize: 7,
                  horizontalSize: 110,
                  fontSize: 12,
                  fontColor: CustomColors.componentFont,
                  buttonColor: CustomColors.component,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}