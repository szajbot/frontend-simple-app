import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../colors.dart';
import '../components/my_buttom.dart';

class MyItemsContainer extends StatefulWidget {
  @override
  State<MyItemsContainer> createState() => _MyItemsContainerState();
}

class _MyItemsContainerState extends State<MyItemsContainer> {
  bool _isLoading = true;
  late Future<List<Map<String, dynamic>>> _ticketsFuture;

  @override
  void initState() {
    super.initState();
    _ticketsFuture = fetchTickets();
  }

  Future<void> payForTicket(String ticketNumber) async {
    try {

      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id'); // Retrieve user ID

      if (userId == null) {
        setState(() {
          _isLoading = false;
        });
        showErrorMessage("User ID not found. Please log in again.");
      }

      final ticketUrl = Uri.parse(
          'http://10.0.2.2:8000/tickets/pay/$userId/$ticketNumber'); // API URL
      final ticketResponse = await http
          .post(ticketUrl, headers: {'Content-Type': 'application/json'});

      if (ticketResponse.statusCode == 200) {
        setState(() {
          _ticketsFuture = fetchTickets(); // Refresh tickets after payment
          showErrorMessage("Ticket payed successfully.");
        });
      } else {
        showErrorMessage("Failed to pay for ticket.");
      }
    } catch (e) {
      showErrorMessage("Error processing payment: ${e.toString()}");
    }
  }

  void showOkMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
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
          'http://10.0.2.2:8000/tickets/user/$userId/deactivate'); // API URL
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background2,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _ticketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading tickets.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No tickets available.',
                style: TextStyle(
                    fontSize: 30, // Increased font size
                    fontWeight: FontWeight.bold, // Bold text
                    color: CustomColors
                        .componentFont // Optional: change color for better visibility
                    ),
              ),
            );
          } else {
            // Generate TicketComponents from returned data
            final tickets = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: tickets.map((ticket) {
                      return TicketComponent(
                        ticketNumber: ticket['id'].toString(),
                        start: ticket['entrance_date'] ?? 'Unknown',
                        end: ticket['exit_date'] ?? 'Unknown',
                        cost: (ticket['amount'] ?? 0).toDouble(),
                        payed: (ticket['payed'] == true ? true: false),
                        registrationNumber:
                            ticket['registration'] ?? 'Unknown',
                        model: ticket['model'] ?? 'Unknown',
                        brand: ticket['brand'] ?? 'Unknown',
                        onPay: payForTicket, // Pass the function
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class TicketComponent extends StatelessWidget {
  final String ticketNumber;
  final String start;
  final String end;
  final double cost;
  final bool payed;
  final String registrationNumber;
  final String model;
  final String brand;
  final Function(String) onPay; // Callback for payment

  const TicketComponent({
    Key? key,
    required this.ticketNumber,
    required this.start,
    required this.end,
    required this.cost,
    required this.payed,
    required this.registrationNumber,
    required this.model,
    required this.brand,
    required this.onPay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(start: 20),
                  child: Icon(Icons.local_parking, size: 50, color: Colors.white),
                ),
                Text(
                  "Ticket#: $ticketNumber",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white54),
                ),
              ],
            ),
            Divider(thickness: 1.5, color: Colors.grey.shade300),
            Text(
              'Start: $start',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              'End: $end',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registration number: $registrationNumber',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Brand: $brand',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Model: $model',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Cost: ${cost.toStringAsFixed(2)} PLN',
              style: TextStyle(
                color: Colors.yellowAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            !payed
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your ticket is still unpaid!',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                MyButton(
                  onTap: () => onPay(ticketNumber), // Correct callback usage
                  text: 'Pay Now!',
                  paddingSize: 4,
                  horizontalSize: 15,
                  fontSize: 16,
                  fontColor: CustomColors.componentFont,
                  buttonColor: CustomColors.background2,
                ),
              ],
            )
                : Text(
              'Your ticket is already paid :)',
              style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

