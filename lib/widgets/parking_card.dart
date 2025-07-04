import 'package:flutter/material.dart';
import '../models/parking.dart';

class ParkingCard extends StatelessWidget {
  final Parking parking;
  final VoidCallback onTap;

  const ParkingCard({required this.parking, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              parking.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(parking.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(parking.location),
                  Text('Price: ${parking.pricePerHour} DH/hour'),
                  Text(parking.isOpenNow ? '🟢 Open' : '🔴 Closed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
