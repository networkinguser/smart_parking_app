import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/parking.dart';
import '../models/floor.dart';

class ParkingDetailsScreen extends StatelessWidget {
  final Parking parking;

  const ParkingDetailsScreen({required this.parking});

  @override
  Widget build(BuildContext context) {
    // Calculate totals
    int totalSpots = parking.floors.fold(
      0,
      (sum, floor) => sum + floor.totalSpots,
    );
    int totalTaken = parking.floors.fold(
      0,
      (sum, floor) => sum + floor.takenSpots,
    );
    int totalFree = totalSpots - totalTaken;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Banner Image with App Bar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.blue[800],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(parking.imageUrl, fit: BoxFit.cover),
              title: Text(
                parking.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Status Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.blue[700],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '${parking.pricePerHour} DH/hour',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                parking.isOpenNow
                                    ? Colors.green[600]
                                    : Colors.red[600],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            parking.isOpenNow ? 'OPEN NOW' : 'CLOSED',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Location Section
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.red[600],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                parking.location,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () => _openGoogleMaps(parking.location),
                            icon: const Icon(Icons.map, color: Colors.white),
                            label: const Text(
                              'Open in Google Maps',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[600],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Opening Hours
                  Text(
                    'Opening Hours',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.orange[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: Colors.orange[600],
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '${parking.openTime} - ${parking.closeTime}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Total Spots Summary
                  Text(
                    'Parking Summary',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSummaryItem(
                          'Total Spots',
                          totalSpots.toString(),
                          Colors.blue[600]!,
                        ),
                        _buildSummaryItem(
                          'Available',
                          totalFree.toString(),
                          Colors.green[600]!,
                        ),
                        _buildSummaryItem(
                          'Occupied',
                          totalTaken.toString(),
                          Colors.red[600]!,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Floors Section
                  Text(
                    'Floor Details',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...parking.floors.map((floor) => _buildFloorCard(floor)),

                  const SizedBox(height: 20),

                  // Weekly Occupancy & AI Tip
                  Text(
                    'Weekly Occupancy',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _WeeklyOccupancyChart(),
                  const SizedBox(height: 8),
                  _AITip(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFloorCard(Floor floor) {
    int freeSpots = floor.freeSpots;
    int takenSpots = floor.takenSpots;
    double occupancyRate =
        floor.totalSpots > 0 ? takenSpots / floor.totalSpots : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Floor ${floor.floorNumber}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color:
                      occupancyRate < 0.8 ? Colors.green[100] : Colors.red[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  occupancyRate < 0.8 ? 'Available' : 'Nearly Full',
                  style: TextStyle(
                    color:
                        occupancyRate < 0.8
                            ? Colors.green[700]
                            : Colors.red[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Progress Bar
          LinearProgressIndicator(
            value: occupancyRate,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              occupancyRate < 0.8 ? Colors.green[600]! : Colors.red[600]!,
            ),
            minHeight: 8,
          ),
          const SizedBox(height: 8),

          // Spots Details
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$freeSpots available',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.red[600],
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$takenSpots occupied',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _openGoogleMaps(String location) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

class _WeeklyOccupancyChart extends StatelessWidget {
  final List<int> mockData = const [30, 60, 80, 50, 90, 40, 20]; // Mon-Sun %
  final List<String> days = const [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            7,
            (i) => _Bar(day: days[i], percent: mockData[i]),
          ),
        ),
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  final String day;
  final int percent;
  const _Bar({required this.day, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 60,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 16,
            height: percent * 0.6,
            decoration: BoxDecoration(
              color:
                  percent > 70
                      ? Colors.red[400]
                      : percent > 40
                      ? Colors.orange[400]
                      : Colors.green[400],
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(day, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
      ],
    );
  }
}

class _AITip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: const [
            Icon(Icons.insights, color: Colors.blue, size: 22),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'AI Tip: Best time to park is weekday mornings. Usually full on Friday evenings.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
