import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../colors.dart';
import '../components/account_balance_component.dart';
import '../components/current_ticket_component.dart';
import '../components/parking_component.dart';

class HomeContainer extends StatefulWidget {
  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
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
