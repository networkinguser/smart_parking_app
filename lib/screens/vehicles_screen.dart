import 'package:flutter/material.dart';
import '../data/mock_user_data.dart';
import '../models/user.dart';

class VehiclesScreen extends StatefulWidget {
  @override
  _VehiclesScreenState createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends State<VehiclesScreen> {
  late List<Vehicle> vehicles;

  @override
  void initState() {
    super.initState();
    vehicles = List.from(mockUser.vehicles);
  }

  void _setDefaultVehicle(Vehicle vehicle) {
    setState(() {
      for (var v in vehicles) {
        v = Vehicle(
          id: v.id,
          plateNumber: v.plateNumber,
          brand: v.brand,
          model: v.model,
          color: v.color,
          isDefault: v.id == vehicle.id,
        );
      }
    });
  }

  void _addVehicle() {
    showDialog(
      context: context,
      builder:
          (context) => _AddVehicleDialog(
            onVehicleAdded: (vehicle) {
              setState(() {
                vehicles.add(vehicle);
              });
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Vehicles'),
        backgroundColor: Colors.blue[800],
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addVehicle),
        ],
      ),
      body:
          vehicles.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = vehicles[index];
                  return _buildVehicleCard(vehicle);
                },
              ),
      floatingActionButton:
          vehicles.isNotEmpty
              ? FloatingActionButton(
                onPressed: _addVehicle,
                backgroundColor: Colors.blue[600],
                child: const Icon(Icons.add, color: Colors.white),
              )
              : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No vehicles added yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first vehicle to get started',
            style: TextStyle(color: Colors.grey[500]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _addVehicle,
            icon: const Icon(Icons.add),
            label: const Text('Add Vehicle'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleCard(Vehicle vehicle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _getVehicleColor(vehicle.color),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.directions_car,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${vehicle.brand} ${vehicle.model}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (vehicle.isDefault) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'Default',
                                style: TextStyle(
                                  color: Colors.green[700],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        vehicle.plateNumber,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        vehicle.color,
                        style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'default':
                        _setDefaultVehicle(vehicle);
                        break;
                      case 'edit':
                        // TODO: Implement edit vehicle
                        break;
                      case 'delete':
                        _showDeleteDialog(vehicle);
                        break;
                    }
                  },
                  itemBuilder:
                      (context) => [
                        if (!vehicle.isDefault)
                          const PopupMenuItem(
                            value: 'default',
                            child: Row(
                              children: [
                                Icon(Icons.star, size: 20),
                                SizedBox(width: 8),
                                Text('Set as Default'),
                              ],
                            ),
                          ),
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 20),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 20, color: Colors.red),
                              SizedBox(width: 8),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getVehicleColor(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'white':
        return Colors.grey[300]!;
      case 'black':
        return Colors.grey[800]!;
      case 'blue':
        return Colors.blue[600]!;
      case 'red':
        return Colors.red[600]!;
      case 'green':
        return Colors.green[600]!;
      case 'yellow':
        return Colors.yellow[600]!;
      case 'orange':
        return Colors.orange[600]!;
      case 'purple':
        return Colors.purple[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  void _showDeleteDialog(Vehicle vehicle) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Delete Vehicle'),
            content: Text(
              'Are you sure you want to delete ${vehicle.brand} ${vehicle.model}?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    vehicles.removeWhere((v) => v.id == vehicle.id);
                  });
                  Navigator.pop(context);
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }
}

class _AddVehicleDialog extends StatefulWidget {
  final Function(Vehicle) onVehicleAdded;

  const _AddVehicleDialog({required this.onVehicleAdded});

  @override
  _AddVehicleDialogState createState() => _AddVehicleDialogState();
}

class _AddVehicleDialogState extends State<_AddVehicleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _plateController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  String _selectedColor = 'White';

  final List<String> _colors = [
    'White',
    'Black',
    'Blue',
    'Red',
    'Green',
    'Yellow',
    'Orange',
    'Purple',
  ];

  @override
  void dispose() {
    _plateController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    super.dispose();
  }

  void _addVehicle() {
    if (_formKey.currentState!.validate()) {
      final vehicle = Vehicle(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        plateNumber: _plateController.text,
        brand: _brandController.text,
        model: _modelController.text,
        color: _selectedColor,
        isDefault: false,
      );
      widget.onVehicleAdded(vehicle);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Vehicle'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _plateController,
                decoration: const InputDecoration(
                  labelText: 'Plate Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter plate number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Brand',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter brand';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _modelController,
                decoration: const InputDecoration(
                  labelText: 'Model',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter model';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedColor,
                decoration: const InputDecoration(
                  labelText: 'Color',
                  border: OutlineInputBorder(),
                ),
                items:
                    _colors.map((color) {
                      return DropdownMenuItem(value: color, child: Text(color));
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedColor = value!;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: _addVehicle, child: const Text('Add')),
      ],
    );
  }
}
