import 'package:flutter/material.dart';

import '../components/my_buttom.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

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

  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });

    if (passwordController.text == confirmPasswordController.text) {
      try {
        //TODO placeholder for registration

        Navigator.pop(context);
      } on Exception catch (e) {
        Navigator.pop(context);

        genericErrorMessage(e as String);
      }
    } else {
      genericErrorMessage("Password don't match!");
    }

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
      backgroundColor: const Color.fromARGB(255, 210, 190, 190),
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
                  fontColor: Colors.white,
                  buttonColor: Colors.black,
                ),
                const SizedBox(height: 20),

                // continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Text(
                          'OR',
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      onTap: () => null, //TODO AuthService().signInWithGoogle()
                      imagePath: 'assets/xd.png',
                      height: 50,
                      width: 50,
                      backgroundColor: Color.fromARGB(100, 100, 100, 100),
                    ),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height - 750,
                ),

                Text(
                  'Already have an account? ',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
                  fontColor: Colors.white,
                  buttonColor: Colors.grey.shade800,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}