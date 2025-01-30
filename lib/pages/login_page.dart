import 'package:flutter/material.dart';
import 'package:parking_lot/colors.dart';

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
    final url = Uri.parse('https://yourapi.com/login');

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );

    // try {
    //   final response = await http.post(
    //     url,
    //     body: json.encode({
    //       'email': email,
    //       'password': password,
    //     }),
    //     headers: {'Content-Type': 'application/json'},
    //   );
    //
    //   if (response.statusCode == 200) {
    //     // Assuming the response contains a success message or token
    //     final responseData = json.decode(response.body);
    //     if (responseData['success'] == true) {
    //       // If login is successful, navigate to HomePage
    //       Navigator.pushReplacement(
    //         context,
    //         MaterialPageRoute(builder: (context) => HomePage()),
    //       );
    //     } else {
    //       // Handle failed login response
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('Invalid credentials')),
    //       );
    //     }
    //   } else {
    //     // Handle unsuccessful response (non-200 status code)
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text('Login failed')),
    //     );
    //   }
    // } catch (error) {
    //   // Handle error in making request (e.g., no internet)
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('An error occurred')),
    //   );
    // }
  }

  void genericErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
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
