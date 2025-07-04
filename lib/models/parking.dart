import 'floor.dart';

class Parking {
  final String id;
  final String name;
  final String location;
  final String imageUrl;
  final double pricePerHour;
  final String openTime;
  final String closeTime;
  final bool isOpenNow;
  final List<Floor> floors;

  Parking({
    required this.id,
    required this.name,
    required this.location,
    required this.imageUrl,
    required this.pricePerHour,
    required this.openTime,
    required this.closeTime,
    required this.isOpenNow,
    required this.floors,
  });

  int get totalFloors => floors.length;
  int get totalSpots => floors.fold(0, (sum, floor) => sum + floor.totalSpots);
  int get totalFreeSpots =>
      floors.fold(0, (sum, floor) => sum + floor.freeSpots);
  bool get isFull => totalFreeSpots == 0;
}
