import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors.dart';

class ParkingComponent extends StatelessWidget {
  final String name;
  final String address;
  final int freeSpots;
  final int occupiedSpots;
  final String imageUrl;

  const ParkingComponent({
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
            child: Image.network(
              'https://picsum.photos/id/870/200/300?grayscale&blur=2',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Content Overlay
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.2)],
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text('Address: $address', style: TextStyle(color: Colors.white70)),
                Text('Free Spots: $freeSpots', style: TextStyle(color: Colors.white70)),
                Text('Occupied Spots: $occupiedSpots', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}