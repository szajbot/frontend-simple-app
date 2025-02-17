import 'package:flutter/material.dart';
import '../colors.dart';

class MyItemsContainer extends StatefulWidget {
  @override
  State<MyItemsContainer> createState() => _MyItemsContainerState();
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

class _MyItemsContainerState extends State<MyItemsContainer> {
  // Simulating an API call
  Future<List<Map<String, dynamic>>> fetchTickets() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate network delay
    return [
      {
        'ticketNumber': '123456',
        'start': '2025-02-02 16:20',
        'end': '2025-02-02 18:20',
        'cost': 5.50,
      },
      {
        'ticketNumber': '123457',
        'start': '2025-02-03 12:00',
        'end': '2025-02-03 14:30',
        'cost': 8.75,
      },
      {
        'ticketNumber': '123458',
        'start': '2025-02-04 09:00',
        'end': '2025-02-04 10:45',
        'cost': 4.25,
      },
      {
        'ticketNumber': '123458',
        'start': '2025-02-04 09:00',
        'end': '2025-02-04 10:45',
        'cost': 4.25,
      },
      {
        'ticketNumber': '123458',
        'start': '2025-02-04 09:00',
        'end': '2025-02-04 10:45',
        'cost': 4.25,
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.background2,
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading tickets.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tickets available.'));
          } else {
            // Generate TicketComponents from returned data
            final tickets = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: tickets.map((ticket) {
                  return TicketComponent(
                    ticketNumber: ticket['ticketNumber'],
                    start: ticket['start'],
                    end: ticket['end'],
                    cost: ticket['cost'],
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
