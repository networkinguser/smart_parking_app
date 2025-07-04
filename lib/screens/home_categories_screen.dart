import 'package:flutter/material.dart';
import 'home_screen.dart'; // adjust if your HomeScreen is in another folder

class HomeCategoriesScreen extends StatelessWidget {
  const HomeCategoriesScreen({super.key});

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
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                // Parking button
                _buildCategoryCard(
                  context,
                  icon: Icons.local_parking,
                  label: 'Parking',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
                // Shopping button
                _buildCategoryCard(
                  context,
                  icon: Icons.shopping_bag,
                  label: 'Shopping',
                  onTap: () {
                    // Later you can navigate to shopping screen
                  },
                ),
                // Food button
                _buildCategoryCard(
                  context,
                  icon: Icons.restaurant,
                  label: 'Food',
                  onTap: () {
                    // Later you can navigate to food screen
                  },
                ),
                // Gas stations button
                _buildCategoryCard(
                  context,
                  icon: Icons.local_gas_station,
                  label: 'Gas Stations',
                  onTap: () {
                    // Later you can navigate to gas stations screen
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Text(
                '© Smart Parking • FSAC 2025',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context,
      {required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 50, color: Colors.blue[700]),
              SizedBox(height: 12),
              Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
