import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../colors.dart';
import '../components/account_balance_component.dart';
import '../components/current_ticket_component.dart';
import '../components/parking_component.dart';

class HomeContainer extends StatefulWidget {
  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  bool _isLoading = true;

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

  Future<List<Map<String, dynamic>>> fetchTickets() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id'); // Retrieve user ID

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("User ID not found. Please log in again.");
        return [];
      }

      final ticketUrl = Uri.parse(
          'http://10.0.2.2:8000/tickets/user/$userId/active'); // API URL
      final ticketResponse = await http
          .get(ticketUrl, headers: {'Content-Type': 'application/json'});

      if (ticketResponse.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(ticketResponse.body);
        return decodedData.cast<Map<String, dynamic>>().toList();
      } else {
        setState(() {
          _isLoading = false;
        });
        // showErrorMessage("Failed to load tickets.");
        return [];
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showErrorMessage("Error fetching tickets: ${e.toString()}");
      return [];
    }
  }

  // Simulated API call
  Future<Map<String, dynamic>> fetchHomeData() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return {
      'currentTicket': {
        'location': 'Downtown Parking Lot',
        'parkingNumber': 'A12',
        'startTime': '2025-02-02 16:20',
        'isActive': true,
      },
      'accountBalance': 23.75,
      'parkingDetails': [
        {
          'name': 'Downtown Parking Lot',
          'address': '123 Main St, City Center',
          'freeSpots': 20,
          'occupiedSpots': 80,
          'imageUrl': 'https://via.placeholder.com/400x200',
          // Placeholder image
        },
        {
          'name': 'East Side Parking Garage',
          'address': '456 East St, Suburbs',
          'freeSpots': 35,
          'occupiedSpots': 65,
          'imageUrl': 'https://via.placeholder.com/400x200',
          // Placeholder image
        },
      ],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background2,
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchHomeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data.'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No data available.'));
          } else {
            final data = snapshot.data!;
            final currentTicket = data['currentTicket'];
            final accountBalance = data['accountBalance'];
            final parkingDetails = data['parkingDetails'];

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: double.infinity,
                      height: 150,
                      child: CurrentTicketComponent(
                        location: currentTicket['location'],
                        parkingNumber: currentTicket['parkingNumber'],
                        startTime: currentTicket['startTime'],
                        isActive: currentTicket['isActive'],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      width: double.infinity,
                      height: 100,
                      child: AccountBalanceComponent(
                        balance: accountBalance,
                      ),
                    ),
                    ...List.generate(parkingDetails.length, (index) {
                      final parking = parkingDetails[index];
                      return Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: double.infinity,
                          height: 200,
                          child: ParkingComponent(
                            name: parking['name'],
                            address: parking['address'],
                            freeSpots: parking['freeSpots'],
                            occupiedSpots: parking['occupiedSpots'],
                            imageUrl: parking['imageUrl'],
                          ));
                    }),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
