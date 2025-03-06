import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors.dart';

class ParkingComponent extends StatelessWidget {
  final String name;
  final String address;
  final int freeSpots;
  final int occupiedSpots;
  final String imageUrl;

  final _firstStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 18);

  final _secondStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14);

  ParkingComponent({
    Key? key,
    required this.name,
    required this.address,
    required this.freeSpots,
    required this.occupiedSpots,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(children: <Widget>[
              Image(
                image: AssetImage(imageUrl),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.6,
                  child: Container(
                    color: const Color(0xFF000000),
                  ),
                ),
              ),
            ]),
          ),
          // Content Overlay
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.2)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 16),
                RichText(text: TextSpan(children: [
                  TextSpan(text: 'Address: ', style: _firstStyle),
                  TextSpan(text: ' $address', style: _secondStyle),
                ])),
                const SizedBox(height: 5),
                RichText(text: TextSpan(children: [
                  TextSpan(text: 'Free Spots: ', style: _firstStyle),
                  TextSpan(text: ' $freeSpots', style: _secondStyle),
                ])),
                const SizedBox(height: 5),
                RichText(text: TextSpan(children: [
                  TextSpan(text: 'Occupied Spots: ', style: _firstStyle),
                  TextSpan(text: ' $occupiedSpots', style: _secondStyle),
                ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}