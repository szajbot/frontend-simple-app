import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../colors.dart';

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

      final ticketUrl =
          Uri.parse('http://10.0.2.2:8000/tickets/user/$userId'); // API URL
      final ticketResponse = await http
          .get(ticketUrl, headers: {'Content-Type': 'application/json'});

      if (ticketResponse.statusCode == 200) {
        final List<dynamic> decodedData = jsonDecode(ticketResponse.body);
        final List<Map<String, dynamic>> filteredTickets = decodedData
            .where((ticket) => ticket['exit_date'] != null)
            .cast<Map<String, dynamic>>()
            .toList();
        return filteredTickets;
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
            return Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading tickets.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No tickets available.',
                style: TextStyle(
                  fontSize: 30, // Increased font size
                  fontWeight: FontWeight.bold, // Bold text
                  color: CustomColors.componentFont // Optional: change color for better visibility
                ),
              ),
            );
          } else {
            // Generate TicketComponents from returned data
            final tickets = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tickets.map((ticket) {
                  return TicketComponent(
                    ticketNumber: ticket['ticketNumber'] ?? 'N/A',
                    start: ticket['start'] ?? 'Unknown',
                    end: ticket['end'] ?? 'Unknown',
                    cost: (ticket['cost'] ?? 0).toDouble(),
                  );
                }).toList(),
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

  const TicketComponent({
    Key? key,
    required this.ticketNumber,
    required this.start,
    required this.end,
    required this.cost,
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
            Center(
              child: Icon(
                Icons.local_parking,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Ticket #$ticketNumber',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'From: $start',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'To: $end',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Cost: ${cost.toStringAsFixed(2)} PLN',
              style: TextStyle(
                color: Colors.yellowAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
