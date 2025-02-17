import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CurrentTicketComponent extends StatelessWidget {
  final String location;
  final String parkingNumber;
  final String startTime;
  final bool isActive;

  const CurrentTicketComponent({
    Key? key,
    required this.location,
    required this.parkingNumber,
    required this.startTime,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.shade300, Colors.green.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
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
          Text(
            'Current Ticket',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text('Location: $location', style: TextStyle(color: Colors.white70)),
          Text('Parking Number: $parkingNumber', style: TextStyle(color: Colors.white70)),
          Text('Start Time: $startTime', style: TextStyle(color: Colors.white70)),
          Text('Status: ${isActive ? "Active" : "Inactive"}', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}