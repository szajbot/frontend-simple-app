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
  final _modelController = TextEditingController();
  final _registrationController = TextEditingController();
  final _brandController = TextEditingController();
  bool _isLoading = true;
  bool _haveCar = false;
  bool _openAddCarButton = false;

  void openOrCloseAddCarButton() {
    setState(() {
      _openAddCarButton = !_openAddCarButton;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProfileDetails();
  }

  void createCar() async {
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

      final driverUrl = Uri.parse('http://10.0.2.2:8000/drivers/$userId');
      final driverResponse = await http
          .get(driverUrl, headers: {'Content-Type': 'application/json'});

      if (driverResponse.statusCode == 200) {
        final driverData = jsonDecode(driverResponse.body);
        var driver_id = driverData["id"] ?? "";

        final carUrl = Uri.parse('http://10.0.2.2:8000/cars');
        final carResponse = await http.post(
          carUrl,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "driver_id": driver_id,
            "brand": _brandController.text,
            "model": _modelController.text,
            "registration": _registrationController.text,
          }),
        );

        if (carResponse.statusCode == 200) {
          setState(() {
            _haveCar = true;
            _openAddCarButton = false;
          });
        }
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

      final balanceToAdd = 10;

      final url = Uri.parse(
          'http://10.0.2.2:8000/drivers/$userId/$balanceToAdd'); // API URL
      final response =
          await http.post(url, headers: {'Content-Type': 'application/json'});

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

  Future<void> fetchProfileDetails() async {
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

      final driverUrl =
          Uri.parse('http://10.0.2.2:8000/drivers/$userId'); // API URL
      final driverResponse = await http
          .get(driverUrl, headers: {'Content-Type': 'application/json'});

      if (driverResponse.statusCode == 200) {
        final driverData = jsonDecode(driverResponse.body);

        var driver_id = driverData["id"] ?? "";
        final carUrl = Uri.parse('http://10.0.2.2:8000/cars/driver/$driver_id');
        final carResponse = await http
            .get(carUrl, headers: {'Content-Type': 'application/json'});

        if (carResponse.statusCode == 200) {
          final carData = jsonDecode(carResponse.body);
          setState(() {
            _nameController.text = driverData["name"] ?? "";
            _surnameController.text = driverData["surname"] ?? "";
            _balanceController.text =
                driverData["account_balance"].toString() ?? "";

            _registrationController.text = carData["registration"] ?? "";
            _brandController.text = carData["brand"] ?? "";
            _modelController.text = carData["model"] ?? "";

            _haveCar = true;
            _isLoading = false;
          });
        } else {
          setState(() {
            _nameController.text = driverData["name"] ?? "";
            _surnameController.text = driverData["surname"] ?? "";
            _balanceController.text =
                driverData["account_balance"].toString() ?? "";

            _haveCar = false;
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("Failed to load profile details.");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showErrorMessage("Error fetching profile details.");
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
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id'); // Retrieve user ID

    if (userId == null) {
      setState(() {
        _isLoading = false;
      });
      showErrorMessage("User ID not found. Please log in again.");
      return;
    }

    final url = Uri.parse('http://10.0.2.2:8000/drivers/$userId');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
            {"name": _nameController.text, "surname": _surnameController.text}),
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
                            onTap: addBalance,
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
                            "Car",
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
                    _haveCar
                        ? Column(
                            children: [
                              buildTextField("Brand", _brandController, false),
                              buildTextField("Model", _modelController, false),
                              buildTextField("Registration number",
                                  _registrationController, false),
                            ],
                          )
                        : AnimatedContainer(
                            duration: const Duration(milliseconds: 100),
                            child: !_openAddCarButton
                                ? Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(25, 15, 0, 0),
                                      alignment: Alignment.topLeft,
                                      width: 150,
                                      height: 50,
                                      child: MyButton(
                                        onTap: openOrCloseAddCarButton,
                                        text: 'Add car',
                                        paddingSize: 0,
                                        horizontalSize: 0,
                                        fontSize: 15,
                                        fontColor: CustomColors.componentFont,
                                        buttonColor: CustomColors.component2,
                                      ),
                                    ))
                                : Column(
                                    children: [
                                      buildTextField(
                                          "Brand", _brandController, true),
                                      buildTextField(
                                          "Model", _modelController, true),
                                      buildTextField("Registration number",
                                          _registrationController, true),
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(
                                                25, 15, 0, 0),
                                            alignment: Alignment.topLeft,
                                            width: 150,
                                            height: 50,
                                            child: MyButton(
                                              onTap: createCar,
                                              text: 'Save car',
                                              paddingSize: 0,
                                              horizontalSize: 0,
                                              fontSize: 15,
                                              fontColor:
                                                  CustomColors.componentFont,
                                              buttonColor:
                                                  CustomColors.component2,
                                            ),
                                          ))
                                    ],
                                  ),
                          ),
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

  Widget buildTextField(
      String label, TextEditingController controller, bool editable) {
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
        MyTextField(
            hintText: label,
            obscureText: false,
            controller: controller,
            enabled: editable),
      ],
    );
  }
}
