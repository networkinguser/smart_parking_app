class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final String gender; // 'male' or 'female'
  final List<Vehicle> vehicles;
  final List<ParkingHistory> parkingHistory;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    required this.gender,
    required this.vehicles,
    required this.parkingHistory,
  });
}

class Vehicle {
  final String id;
  final String plateNumber;
  final String brand;
  final String model;
  final String color;
  final bool isDefault;

  Vehicle({
    required this.id,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.color,
    this.isDefault = false,
  });
}

class ParkingHistory {
  final String id;
  final String parkingName;
  final String vehiclePlate;
  final DateTime entryTime;
  final DateTime? exitTime;
  final double totalCost;
  final String status; // 'active', 'completed', 'cancelled'

  ParkingHistory({
    required this.id,
    required this.parkingName,
    required this.vehiclePlate,
    required this.entryTime,
    this.exitTime,
    required this.totalCost,
    required this.status,
  });
}
