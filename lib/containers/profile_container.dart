import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../colors.dart';
import '../components/my_buttom.dart';
import '../components/my_textfield.dart';
import '../pages/login_or_registerPage.dart';

class ProfileContainer extends StatefulWidget {
  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _balanceController = TextEditingController();
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    fetchDriverDetails();
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear user session

    // Navigate to login/register page and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginOrRegisterPage()),
          (Route<dynamic> route) => false, // This removes all previous screens
    );
  }

  Future<void> addBalance() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id'); // Retrieve user ID

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("User ID not found. Please log in again.");
        return;
      }

      final url = Uri.parse('http://10.0.2.2:8000/drivers/$userId/'); // API URL
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _nameController.text = data["name"] ?? "";
          _surnameController.text = data["surname"] ?? "";
          _balanceController.text = data["account_balance"].toString() ?? "";
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("Failed to load driver details.");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showErrorMessage("Error fetching driver details.");
    }
  }

  Future<void> fetchDriverDetails() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id'); // Retrieve user ID

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("User ID not found. Please log in again.");
        return;
      }

      final url = Uri.parse('http://10.0.2.2:8000/drivers/$userId/'); // API URL
      final response = await http.get(url, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          _nameController.text = data["name"] ?? "";
          _surnameController.text = data["surname"] ?? "";
          _balanceController.text = data["account_balance"].toString() ?? "";
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("Failed to load driver details.");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showErrorMessage("Error fetching driver details.");
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
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

  Future<void> saveChanges() async {
    final url = Uri.parse('http://10.0.2.2:8000/driver/update/');
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');

    if (userId == null) {
      showErrorMessage("User ID not found.");
      return;
    }

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id": userId,
          "name": _nameController.text,
          "surname": _surnameController.text,
          "balance": _balanceController.text
        }),
      );

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Profile updated successfully."),
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
      } else {
        showErrorMessage("Failed to update profile.");
      }
    } catch (e) {
      showErrorMessage("Error updating profile.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.background2,
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                    margin: EdgeInsets.fromLTRB(15, 100, 0, 0),
                    child: Text(
                      "Account Information",
                      style: TextStyle(
                          fontSize: 28,
                          color: CustomColors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Divider(thickness: 2.5, color: Colors.grey.shade700),
              buildTextField("Name", _nameController, true),
              buildTextField("Surname", _surnameController, true),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                  width: 150,
                  height: 50,
                  child: MyButton(
                    onTap: saveChanges,
                    text: 'Save changes',
                    paddingSize: 0,
                    horizontalSize: 0,
                    fontSize: 15,
                    fontColor: CustomColors.componentFont,
                    buttonColor: CustomColors.component2,
                  ),
                ),
              ),
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
              buildTextField("Balance", _balanceController, false),
              Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                    alignment: Alignment.topLeft,
                    width: 150,
                    height: 50,
                    child: MyButton(
                      onTap: saveChanges,
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
                      onTap: logout,
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
        ));
  }

  Widget buildTextField(String label, TextEditingController controller, bool editable) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
              margin: EdgeInsets.fromLTRB(40, 5, 0, 0),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 16,
                    color: CustomColors.white,
                    fontWeight: FontWeight.bold),
              )),
        ),
        MyTextField(hintText: label, obscureText: false, controller: controller, enabled: editable),
      ],
    );
  }
}
