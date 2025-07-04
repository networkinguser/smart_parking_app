import '../models/parking.dart';
import '../models/floor.dart';

List<Parking> mockParkings = [
  Parking(
    id: '1',
    name: 'Parking Hassan II',
    location: 'Casablanca',
    imageUrl: 'assets/images/parking1.png', // add this image later
    pricePerHour: 5.0,
    openTime: '08:00',
    closeTime: '22:00',
    isOpenNow: true,
    floors: [
      Floor(floorNumber: 1, totalSpots: 10, takenSpots: 3),
      Floor(floorNumber: 2, totalSpots: 10, takenSpots: 10),
    ],
  ),
  Parking(
    id: '2',
    name: 'Parking Marina',
    location: 'Rabat',
    imageUrl: 'assets/images/parking2.jpeg', // add this image later
    pricePerHour: 4.0,
    openTime: '07:00',
    closeTime: '21:00',
    isOpenNow: false,
    floors: [
      Floor(floorNumber: 1, totalSpots: 15, takenSpots: 5),
      Floor(floorNumber: 2, totalSpots: 15, takenSpots: 15),
      Floor(floorNumber: 3, totalSpots: 15, takenSpots: 10),
    ],
  ),
];
