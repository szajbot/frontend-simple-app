import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../colors.dart';

class CurrentTicketComponent extends StatelessWidget {
  final String ticketNumber;
  final String entranceDate;
  final String registration;
  final String parkingName;
  final String location;

  final _firstStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14);

  final _secondStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12);

  CurrentTicketComponent({
    Key? key,
    required this.ticketNumber,
    required this.entranceDate,
    required this.registration,
    required this.parkingName,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(10, 20),
            ),
          ],
          gradient: LinearGradient(
              colors: [CustomColors.componentFont, CustomColors.background2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(math.pi / 4))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Ticket',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          RichText(text: TextSpan(children: [
            TextSpan(text: 'Ticket Number# ', style: _firstStyle),
            TextSpan(text: ' $ticketNumber', style: _secondStyle),
          ])),
          const SizedBox(height: 5),
          RichText(text: TextSpan(children: [
            TextSpan(text: 'Entrance Date: ', style: _firstStyle),
            TextSpan(text: ' $entranceDate', style: _secondStyle),
          ])),
          const SizedBox(height: 5),
          RichText(text: TextSpan(children: [
            TextSpan(text: 'Registration: ', style: _firstStyle),
            TextSpan(text: ' $registration', style: _secondStyle),
          ])),
          const SizedBox(height: 5),
          RichText(text: TextSpan(children: [
            TextSpan(text: 'Parking Name: ', style: _firstStyle),
            TextSpan(text: ' $parkingName', style: _secondStyle),
          ])),
          const SizedBox(height: 5),
          RichText(text: TextSpan(children: [
            TextSpan(text: 'Location: ', style: _firstStyle),
            TextSpan(text: ' $location', style: _secondStyle),
          ])),
        ],
      ),
    );
  }
}
