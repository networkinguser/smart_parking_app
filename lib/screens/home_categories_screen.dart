import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'vehicles_screen.dart';
import 'history_screen.dart';
import '../data/mock_user_data.dart';
import '../models/user.dart';

class HomeCategoriesScreen extends StatelessWidget {
  const HomeCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = mockUser;
    final activeSessionIndex = user.parkingHistory.indexWhere(
      (h) => h.status == 'active',
    );
    final activeSession =
        activeSessionIndex != -1
            ? user.parkingHistory[activeSessionIndex]
            : null;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Parking'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (activeSession != null) ...[
              _ActiveSessionCard(
                session: activeSession,
                onEndSession: () {
                  final updated = ParkingHistory(
                    id: activeSession.id,
                    parkingName: activeSession.parkingName,
                    vehiclePlate: activeSession.vehiclePlate,
                    entryTime: activeSession.entryTime,
                    exitTime: DateTime.now(),
                    totalCost: activeSession.totalCost,
                    status: 'completed',
                  );
                  user.parkingHistory[activeSessionIndex] = updated;
                  (context as Element).markNeedsBuild();
                },
              ),
              const SizedBox(height: 18),
            ],
            const SizedBox(height: 8),
            Text(
              'Quick Actions',
              style: TextStyle(
                color: Colors.blue[900],
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 16),
            _buildQuickActions(context),
            const SizedBox(height: 28),
            _buildVehiclesSummary(context, user),
            const SizedBox(height: 20),
            _buildRecentActivity(context, user),
            const SizedBox(height: 24),
            Center(
              child: Text(
                'Smart Parking • FSAC 2025',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final List<_QuickAction> actions = [
      _QuickAction(
        icon: Icons.local_parking,
        label: 'Parking',
        color: Colors.blue,
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            ),
      ),
      _QuickAction(
        icon: Icons.directions_car,
        label: 'Vehicles',
        color: Colors.green,
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VehiclesScreen()),
            ),
      ),
      _QuickAction(
        icon: Icons.history,
        label: 'History',
        color: Colors.orange,
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HistoryScreen()),
            ),
      ),
      _QuickAction(
        icon: Icons.contact_support,
        label: 'Contact Us',
        color: Colors.purple,
        onTap: () {
          // TODO: Contact Us
        },
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.05,
      physics: const NeverScrollableScrollPhysics(),
      children:
          actions.map((action) => _QuickActionCard(action: action)).toList(),
    );
  }

  Widget _buildVehiclesSummary(BuildContext context, User user) {
    final defaultVehicle = user.vehicles.firstWhere(
      (v) => v.isDefault,
      orElse: () => user.vehicles.first,
    );
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => VehiclesScreen()),
            ),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.directions_car, color: Colors.blue[700], size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'My Vehicles',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${user.vehicles.length} vehicles • Default: ${defaultVehicle.brand} ${defaultVehicle.model} (${defaultVehicle.plateNumber})',
                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(BuildContext context, User user) {
    final recentHistory = user.parkingHistory.take(3).toList();
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => HistoryScreen()),
            ),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Text(
                        '${user.parkingHistory.length} sessions',
                        style: TextStyle(color: Colors.grey[600], fontSize: 13),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (recentHistory.isEmpty)
                Text(
                  'No recent parking sessions',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                )
              else
                ...recentHistory.map(
                  (history) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color:
                                history.status == 'active'
                                    ? Colors.green[700]
                                    : Colors.blue[700],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                history.parkingName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${history.entryTime.day}/${history.entryTime.month} - ${history.totalCost} DH',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
}

class _QuickActionCard extends StatelessWidget {
  final _QuickAction action;
  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: action.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.13),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey[200]!),
        ),
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: action.color.withOpacity(0.13),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(14),
              child: Icon(action.icon, size: 32, color: action.color),
            ),
            const SizedBox(height: 12),
            Text(
              action.label,
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveSessionCard extends StatelessWidget {
  final dynamic session;
  final VoidCallback onEndSession;
  const _ActiveSessionCard({required this.session, required this.onEndSession});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue[50],
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_parking, color: Colors.blue[800], size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Active Parking Session',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Parking: ${session.parkingName}',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Text('Vehicle: ${session.vehiclePlate}'),
            Text(
              'Entry: ${session.entryTime.hour.toString().padLeft(2, '0')}:${session.entryTime.minute.toString().padLeft(2, '0')}',
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onEndSession,
                icon: const Icon(Icons.exit_to_app),
                label: const Text('End Session'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
