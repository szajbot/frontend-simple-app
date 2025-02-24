import 'dart:convert';
import 'package:flutter/material.dart';
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
  double _balance = 0;
  late Future<Map<String, dynamic>> _homeDataFuture;

  @override
  void initState() {
    super.initState();
    _homeDataFuture = fetchInitialData();
  }

  Future<Map<String, dynamic>> fetchInitialData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id'); // Retrieve user ID

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("User ID not found. Please log in again.");
        return {};
      }

      final balanceUrl = Uri.parse('http://10.0.2.2:8000/drivers/$userId/balance');
      final balanceResponse = await http.get(balanceUrl, headers: {'Content-Type': 'application/json'});

      final activeTicketsUrl = Uri.parse('http://10.0.2.2:8000/tickets/user/$userId/active');
      final activeTicketsResponse = await http.get(activeTicketsUrl, headers: {'Content-Type': 'application/json'});

      if (balanceResponse.statusCode == 200 &&
          (activeTicketsResponse.statusCode == 200 || activeTicketsResponse.statusCode == 404)) {

        final balanceData = jsonDecode(balanceResponse.body);
        List<dynamic> activeTicketsData;
        if (activeTicketsResponse.statusCode == 404) {
          activeTicketsData = [];
        } else {
          activeTicketsData = jsonDecode(activeTicketsResponse.body);
        }
        final List<dynamic> parkingDetailsData =
          [
            {
              'name': 'Parking UNIWERSUM',
              'address': 'Al. Jerozolimskie 56, 00-803 Warszawa',
              'freeSpots': 17,
              'occupiedSpots': 142,
              'imageUrl': 'assets/parking_one.jpg',
              // Placeholder image
            },
            {
              'name': 'East Side Parking Garage',
              'address': '456 East St, Suburbs',
              'freeSpots': 35,
              'occupiedSpots': 65,
              'imageUrl': 'assets/parking_two.jpg',
              // Placeholder image
            },
          ];

        setState(() {
          _isLoading = false;
          _balance = balanceData["account_balance"];
        });

        return {
          'accountBalance': _balance,
          'currentTicket': activeTicketsData.isNotEmpty  ? activeTicketsData[0] : null,
          'parkingDetails': parkingDetailsData,
        };
      } else {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("Failed to load data.");
        return {};
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showErrorMessage("Error fetching data: ${e.toString()}");
      return {};
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background2,
      body: FutureBuilder<Map<String, dynamic>>(
        future: _homeDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading data.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                      height: 100,
                      child: AccountBalanceComponent(
                        balance: accountBalance ?? 0.0,
                      ),
                    ),
                    if (currentTicket != null)
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        width: double.infinity,
                        height: 180,
                        child: CurrentTicketComponent(
                          ticketNumber: currentTicket['id'].toString(),
                          entranceDate: currentTicket['entrance_date'] ?? 'Unknown',
                          registration: currentTicket['registration'] ?? 'Unknown',
                          parkingName: currentTicket['parking_name'] ?? 'Parking UNIWERSUM',
                          location: currentTicket['location'] ?? 'Al. Jerozolimskie 56, 00-803 Warszawa',
                        ),
                      ),
                    if (parkingDetails != null && parkingDetails.isNotEmpty)
                      ...List.generate(parkingDetails.length, (index) {
                        final parking = parkingDetails[index];
                        return Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          width: double.infinity,
                          height: 200,
                          child: ParkingComponent(
                            name: parking['name'] ?? 'Unknown',
                            address: parking['address'] ?? 'Unknown',
                            freeSpots: parking['freeSpots'] ?? 0,
                            occupiedSpots: parking['occupiedSpots'] ?? 0,
                            imageUrl: parking['imageUrl'] ?? '',
                          ),
                        );
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
