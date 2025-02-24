import 'package:flutter/material.dart';
import 'package:parking_lot/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/my_buttom.dart';
import '../components/my_textfield.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  Future<void> signUserIn() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final url = Uri.parse('http://10.0.2.2:8000/user/login'); // API URL

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "login": email,
          "password": password
        }),
      );

      Navigator.pop(context); // Close loading indicator

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data["id"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_id', user.toString());

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Show error message
        genericErrorMessage("Invalid email or password.");
      }
    } catch (e) {
      Navigator.pop(context); // Close loading indicator
      genericErrorMessage("Error connecting to server.");
    }
  }

  void genericErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Login Error"),
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
        body: SingleChildScrollView(
            child: Align(
                alignment: AlignmentDirectional.center,
                child: Column(children: [
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 150,
                    color: CustomColors.icon,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Welcome back !',
                    style: TextStyle(
                      color: CustomColors.componentFont,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 100),
                  MyTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),
                  const SizedBox(height: 15),
                  MyTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  MyButton(
                    onTap: signUserIn,
                    text: 'Sign In',
                    paddingSize: 22,
                    horizontalSize: 25,
                    fontSize: 15,
                    fontColor: CustomColors.componentFont,
                    buttonColor: CustomColors.component,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 650,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Not a member? ',
                      style: TextStyle(color: CustomColors.componentFont, fontSize: 12),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyButton(
                    onTap: widget.onTap,
                    text: 'Sign up!',
                    paddingSize: 7,
                    horizontalSize: 110,
                    fontSize: 12,
                    fontColor: CustomColors.componentFont,
                    buttonColor: CustomColors.component,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ]))));
  }
}
