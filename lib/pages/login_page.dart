import 'package:flutter/material.dart';

import '../components/my_buttom.dart';
import '../components/my_textfield.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;

  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      //TODO placeholder for login
      //pop the loading circle
      Navigator.pop(context);
    } on Exception catch (e) {
      //pop the loading circle
      Navigator.pop(context);
      genericErrorMessage(e as String);
    }
  }

  // String _mapFirebaseErrorToCustomMessage(String errorCode) {
  //   switch (errorCode) {
  //     case 'invalid-email':
  //       return 'Invalid email address. Please enter a valid email.';
  //     case 'invalid-login-credentials':
  //       return 'Incorrect password or user not found.';
  //     default:
  //       return errorCode;
  //   }
  // }

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
        backgroundColor: const Color.fromARGB(255, 210, 190, 190),
        body: SingleChildScrollView(
            child: Align(
                alignment: AlignmentDirectional.center,
                child: Column(children: [
                  const SizedBox(height: 50),
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 150,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Welcome back !',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 100),
                  MyTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                  ),

                  const SizedBox(height: 15),
                  MyTextField(
                    controller: passwordController,
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
                    fontColor: Colors.white,
                    buttonColor: Colors.grey.shade800,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height - 630,
                  ),

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Not a member? ',
                      style: TextStyle(color: Colors.grey[900], fontSize: 12),
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
                    fontColor: Colors.white,
                    buttonColor: Colors.grey.shade800,
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                ])
            )
        )
    );
  }


}
