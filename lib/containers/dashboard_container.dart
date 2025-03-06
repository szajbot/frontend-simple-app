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
      final activeTicketsUrl = Uri.parse('http://10.0.2.2:8000/tickets/user/$userId/active');
      final parkingsUrl = Uri.parse('http://10.0.2.2:8000/parkings');

      final responses = await Future.wait([
        http.get(balanceUrl, headers: {'Content-Type': 'application/json'}),
        http.get(activeTicketsUrl, headers: {'Content-Type': 'application/json'}),
        http.get(parkingsUrl, headers: {'Content-Type': 'application/json'}),
      ]);

      final balanceResponse = responses[0];
      final activeTicketsResponse = responses[1];
      final parkingResponse = responses[2];

      if (balanceResponse.statusCode == 200
          && (activeTicketsResponse.statusCode == 200 || activeTicketsResponse.statusCode == 404)
          && parkingResponse.statusCode == 200) {

        final balanceData = jsonDecode(balanceResponse.body);
        List<dynamic> activeTicketsData;
        if (activeTicketsResponse.statusCode == 404) {
          activeTicketsData = [];
        } else {
          activeTicketsData = jsonDecode(activeTicketsResponse.body);
        }
        List<dynamic> parkingDetailsData = jsonDecode(parkingResponse.body);

        if (parkingDetailsData.isNotEmpty) {
          parkingDetailsData[0]['imageUrl'] = 'assets/parking_one.jpg';
          if (parkingDetailsData.length > 1) {
            parkingDetailsData[1]['imageUrl'] = 'assets/parking_two.jpg';
          }
        }

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
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: 100,
                    child: AccountBalanceComponent(balance: accountBalance ?? 0.0),
                  ),
                  if (currentTicket != null)
                    Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 180,
                      child: CurrentTicketComponent(
                        ticketNumber: currentTicket['id'].toString(),
                        entranceDate: currentTicket['entrance_date'] ?? 'Unknown',
                        registration: currentTicket['registration'] ?? 'Unknown',
                        parkingName: currentTicket['name'] ?? 'Unknown',
                        location: currentTicket['address'] ?? 'Unknown',
                      ),
                    ),
                  if (parkingDetails != null && parkingDetails.isNotEmpty)
                    ...parkingDetails.map((parking) => Container(
                      margin: EdgeInsets.all(10),
                      width: double.infinity,
                      height: 200,
                      child: ParkingComponent(
                        name: parking['name'] ?? 'Unknown',
                        address: parking['address'] ?? 'Unknown',
                        freeSpots: parking['free_spots'] ?? 0,
                        occupiedSpots: parking['occupied_spots'] ?? 0,
                        imageUrl: parking['imageUrl'] ?? '',
                      ),
                    )),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
