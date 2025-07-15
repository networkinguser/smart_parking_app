import '../models/user.dart';

// Mock user data
User mockUser = User(
  id: '1',
  name: 'Saad farsi',
  email: 'saadfarsi1@gmail.com',
  phone: '+212 6 12 34 56 78',
  profileImage: null, // No image, use gender-based icon
  gender: 'male',
  vehicles: [
    Vehicle(
      id: '1',
      plateNumber: '12345-A-6',
      brand: 'Renault',
      model: 'Clio',
      color: 'White',
      isDefault: true,
    ),
    Vehicle(
      id: '2',
      plateNumber: '67890-B-6',
      brand: 'Peugeot',
      model: '208',
      color: 'Blue',
      isDefault: false,
    ),
  ],
  parkingHistory: [
    ParkingHistory(
      id: '1',
      parkingName: 'Parking Hassan II',
      vehiclePlate: '12345-A-6',
      entryTime: DateTime.now().subtract(const Duration(hours: 2)),
      exitTime: DateTime.now().subtract(const Duration(hours: 1)),
      totalCost: 5.0,
      status: 'completed',
    ),
    ParkingHistory(
      id: '2',
      parkingName: 'Parking Marina',
      vehiclePlate: '12345-A-6',
      entryTime: DateTime.now().subtract(const Duration(days: 1)),
      exitTime: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      totalCost: 12.0,
      status: 'completed',
    ),
    ParkingHistory(
      id: '3',
      parkingName: 'Parking Hassan II',
      vehiclePlate: '67890-B-6',
      entryTime: DateTime.now().subtract(const Duration(minutes: 30)),
      totalCost: 2.5,
      status: 'active',
    ),
  ],
);
