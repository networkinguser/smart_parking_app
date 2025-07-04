import 'package:flutter/material.dart';
import '../models/parking.dart';

class ParkingDetailsScreen extends StatelessWidget {
  final Parking parking;

  const ParkingDetailsScreen({required this.parking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(parking.name),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(parking.location, style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Price: ${parking.pricePerHour} DH/h'),
            Text('Open: ${parking.openTime} - ${parking.closeTime}'),
            Text(
              parking.isOpenNow ? 'Status: Open Now' : 'Status: Closed',
              style: TextStyle(
                 color: parking.isOpenNow ? Colors.green : Colors.red),
            ),

            SizedBox(height: 16),
            Text('Floors:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...parking.floors.map((floor) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Text('Floor ${floor.floorNumber}'),
                  SizedBox(width: 12),
                  Text('Free: ${floor.freeSpots}'),
                  SizedBox(width: 12),
                  Text('Taken: ${floor.takenSpots}'),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
