import 'package:flutter/material.dart';

import '../colors.dart';
import '../components/my_buttom.dart';
import '../components/my_textfield.dart';

class ProfileContainer extends StatefulWidget {
  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  // final _passwordController = TextEditingController();
  // final _confirmPasswordController = TextEditingController();
  // final _emailController = TextEditingController();
  //
  // void changePassword(newPassword, confirmPassword) {
  //   if (newPassword == confirmPassword) {
  //     // FirebaseAuth.instance.currentUser?.updatePassword(newPassword);
  //   }
  // }
  //
  // void changeEmail(newEmail) {
  //   // FirebaseAuth.instance.currentUser?.updateEmail(newEmail);
  // }
  //
  // void signUserOut() {
  //   // FirebaseAuth.instance.signOut();
  // }

  Future<void> voidFunc() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.background2,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(15, 100, 0, 0),
                    child: Text(
                      "Account infromation",
                      style: TextStyle(
                          fontSize: 28,
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Divider(
                thickness: 2.5,
                color: Colors.grey.shade700,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 16,
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              MyTextField(
                hintText: 'Name',
                obscureText: false,
                controller: null,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
                    child: Text(
                      "Surname",
                      style: TextStyle(
                          fontSize: 16,
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              MyTextField(
                hintText: 'Surname',
                obscureText: false,
                controller: null,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          fontSize: 16,
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              MyTextField(
                hintText: 'Email',
                obscureText: false,
                controller: null,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    alignment: Alignment.topLeft,
                    width: 150,
                    height: 50,
                    child: MyButton(
                      onTap: voidFunc,
                      text: 'Save changes',
                      paddingSize: 0,
                      horizontalSize: 0,
                      fontSize: 15,
                      fontColor: CustomColors.componentFont,
                      buttonColor: CustomColors.component2,
                    ),
                  )),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(15, 50, 0, 0),
                    child: Text(
                      "Payments",
                      style: TextStyle(
                          fontSize: 28,
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Divider(
                thickness: 2.5,
                color: Colors.grey.shade700,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
                    child: Text(
                      "Balance",
                      style: TextStyle(
                          fontSize: 16,
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              MyTextField(
                hintText: '150zł',
                obscureText: false,
                controller: null,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    alignment: Alignment.topLeft,
                    width: 150,
                    height: 50,
                    child: MyButton(
                      onTap: voidFunc,
                      text: 'Add balance',
                      paddingSize: 0,
                      horizontalSize: 0,
                      fontSize: 15,
                      fontColor: CustomColors.componentFont,
                      buttonColor: CustomColors.component2,
                    ),
                  )),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(15, 50, 0, 0),
                    child: Text(
                      "Other",
                      style: TextStyle(
                          fontSize: 28,
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Divider(
                thickness: 2.5,
                color: Colors.grey.shade700,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    alignment: Alignment.topLeft,
                    width: 150,
                    height: 50,
                    child: MyButton(
                      onTap: voidFunc,
                      text: 'Logout',
                      paddingSize: 0,
                      horizontalSize: 0,
                      fontSize: 15,
                      fontColor: CustomColors.componentFont,
                      buttonColor: CustomColors.component2,
                    ),
                  )),
              SizedBox(
                height: 100,
              )
            ],
          ),

          // child: Column(
          //   children: [
          //     const SizedBox(
          //       height: 75,
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         signUserOut();
          //       },
          //       child: Container(
          //         width: MediaQuery.of(context).size.width - 24,
          //         height: 50,
          //         // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //         alignment: AlignmentDirectional.center,
          //         decoration: BoxDecoration(
          //             color: Color.fromARGB(255, 230 -20, 210-20, 210-20),
          //             borderRadius: BorderRadius.all(Radius.circular(8)),
          //             border: Border.all(
          //               width: 2,
          //               // color: Colors.green.shade800
          //             )),
          //         child: Align(
          //             alignment: Alignment.center,
          //             child: Text(
          //               "Logout",
          //               style: TextStyle(
          //                   fontSize: 28, color: Colors.black),
          //             )),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 50,
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          //       child: Container(
          //         width: MediaQuery.of(context).size.width - 16,
          //         height: 30,
          //         child: const Text(
          //           "Change password",
          //           textAlign: TextAlign.start,
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //             fontSize: 22,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.only(bottom: 2),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         children: [
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width,
          //             height: 1,
          //             child: Divider(
          //               thickness: 2,
          //               color: Colors.grey.shade600,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width - 8,
          //       height: 40,
          //       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //       decoration: BoxDecoration(
          //         color: Color.fromARGB(255, 230, 210, 210),
          //         border: Border.all(),
          //         borderRadius: const BorderRadius.all(
          //           Radius.circular(8),
          //         ),
          //       ),
          //       child: TextField(
          //         style: TextStyle(
          //           fontSize: 18,
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         textAlignVertical: TextAlignVertical.bottom,
          //         obscureText: true,
          //         controller: _passwordController,
          //         decoration: InputDecoration(
          //           enabledBorder: OutlineInputBorder(),
          //           focusedBorder: OutlineInputBorder(),
          //           hintText: "new password",
          //           hintStyle:
          //               TextStyle(color: Colors.grey.shade800, fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width - 8,
          //       height: 40,
          //       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //       decoration: BoxDecoration(
          //         color: Color.fromARGB(255, 230, 210, 210),
          //         border: Border.all(),
          //         borderRadius: const BorderRadius.all(
          //           Radius.circular(8),
          //         ),
          //       ),
          //       child: TextField(
          //         style: TextStyle(
          //           fontSize: 18,
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         obscureText: true,
          //         controller: _confirmPasswordController,
          //         textAlignVertical: TextAlignVertical.bottom,
          //         decoration: InputDecoration(
          //           enabledBorder: OutlineInputBorder(),
          //           focusedBorder: OutlineInputBorder(),
          //           hintText: "confirm new password",
          //           hintStyle:
          //               TextStyle(color: Colors.grey.shade800, fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomRight,
          //       child: GestureDetector(
          //         onTap: () {
          //           changePassword(_passwordController.value,
          //               _confirmPasswordController.value);
          //         },
          //         child: Container(
          //           width: 80,
          //           height: 35,
          //           margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //           alignment: AlignmentDirectional.bottomEnd,
          //           decoration: BoxDecoration(
          //               color: Colors.green.shade800,
          //               borderRadius: BorderRadius.all(Radius.circular(8)),
          //               border: Border.all(
          //                 width: 2,
          //                 // color: Colors.green.shade800
          //               )),
          //           child: Align(
          //               alignment: Alignment.center,
          //               child: Text(
          //                 "Save",
          //                 style: TextStyle(
          //                     fontSize: 20, color: Colors.grey.shade200),
          //               )),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          //       child: Container(
          //         width: MediaQuery.of(context).size.width - 16,
          //         height: 30,
          //         child: Text(
          //           "Change email",
          //           textAlign: TextAlign.start,
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.black,
          //             fontSize: 22,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.only(bottom: 2),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         children: [
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width,
          //             height: 1,
          //             child: Divider(
          //               thickness: 2,
          //               color: Colors.grey.shade600,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width - 8,
          //       height: 40,
          //       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          //       decoration: BoxDecoration(
          //         color: Color.fromARGB(255, 230, 210, 210),
          //         border: Border.all(),
          //         borderRadius: const BorderRadius.all(
          //           Radius.circular(8),
          //         ),
          //       ),
          //       child: TextField(
          //         style: TextStyle(
          //           fontSize: 18,
          //           color: Colors.black,
          //         ),
          //         maxLines: 1,
          //         textAlignVertical: TextAlignVertical.bottom,
          //         obscureText: true,
          //         controller: _emailController,
          //         decoration: InputDecoration(
          //           enabledBorder: OutlineInputBorder(),
          //           focusedBorder: OutlineInputBorder(),
          //           hintText: "new email",
          //           hintStyle:
          //               TextStyle(color: Colors.grey.shade800, fontSize: 18),
          //         ),
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomRight,
          //       child: GestureDetector(
          //         onTap: () {
          //           changeEmail(_emailController.value);
          //         },
          //         child: Container(
          //           width: 80,
          //           height: 35,
          //           margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //           alignment: AlignmentDirectional.bottomEnd,
          //           decoration: BoxDecoration(
          //               color: Colors.green.shade800,
          //               borderRadius: BorderRadius.all(Radius.circular(8)),
          //               border: Border.all(
          //                 width: 2,
          //                 // color: Colors.green.shade800
          //               )),
          //           child: Align(
          //               alignment: Alignment.center,
          //               child: Text(
          //                 "Save",
          //                 style: TextStyle(
          //                     fontSize: 20, color: Colors.grey.shade200),
          //               )),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
          //       child: Container(
          //         width: MediaQuery.of(context).size.width - 16,
          //         height: 30,
          //         child: Text(
          //           "Delete all items",
          //           textAlign: TextAlign.start,
          //           style: TextStyle(
          //             fontWeight: FontWeight.bold,
          //             color: Colors.red[400],
          //             fontSize: 24,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Padding(
          //       padding: EdgeInsets.only(bottom: 2),
          //       child: Row(
          //         mainAxisSize: MainAxisSize.max,
          //         children: [
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width,
          //             height: 1,
          //             child: Divider(
          //               thickness: 2,
          //               color: Colors.red[300],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     const Align(
          //       alignment: AlignmentDirectional.topStart,
          //       child: Padding(
          //         padding: EdgeInsetsDirectional.symmetric(horizontal: 4),
          //         child: Text(
          //           "Warning! This option will delete all data",
          //           textAlign: TextAlign.start,
          //           style: TextStyle(color: Colors.red, fontSize: 14),
          //         )
          //       ),
          //     ),
          //     const SizedBox(
          //       height: 10,
          //     ),
          //     Align(
          //       alignment: Alignment.bottomLeft,
          //       child: GestureDetector(
          //         onTap: () {
          //           deleteAllData();
          //         },
          //         child: Container(
          //           width: 90,
          //           height: 40,
          //           margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          //           alignment: AlignmentDirectional.bottomEnd,
          //           decoration: BoxDecoration(
          //               color: Colors.red.shade900,
          //               borderRadius: BorderRadius.all(Radius.circular(8)),
          //               border: Border.all(
          //                 width: 2,
          //                 // color: Colors.green.shade800
          //               )),
          //           child: Align(
          //               alignment: Alignment.center,
          //               child: Text(
          //                 "Delete",
          //                 style: TextStyle(
          //                     fontSize: 24, color: Colors.grey.shade200),
          //               )),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
        ));
  }

  void deleteAllData() {}
}
