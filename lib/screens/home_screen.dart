import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../widgets/parking_card.dart';
import 'parking_details_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Parking'),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: mockParkings
                  .map((parking) => ParkingCard(
                        parking: parking,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ParkingDetailsScreen(parking: parking),
                            ),
                          );
                        },
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                'Smart Parking • FSAC 2025',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
