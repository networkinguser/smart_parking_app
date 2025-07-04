class Floor {
  final int floorNumber;
  final int totalSpots;
  final int takenSpots;

  Floor({
    required this.floorNumber,
    required this.totalSpots,
    required this.takenSpots,
  });

  int get freeSpots => totalSpots - takenSpots;
  bool get isFull => freeSpots == 0;
}
