import 'package:flutter/material.dart';
import '../models/facility.dart';
import '../services/facility_service.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({super.key});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  late Future<List<Facility>> _facilities;

  @override
  void initState() {
    super.initState();
    _loadFacilities();
  }

  void _loadFacilities() {
    setState(() {
      _facilities = FacilityService.getAll();
    });
  }

  void _showFacilityDialog({Facility? facility}) {
    final nameController = TextEditingController(text: facility?.name ?? '');
    final locationController =
        TextEditingController(text: facility?.location ?? '');
    final capacityController =
        TextEditingController(text: facility?.capacity.toString() ?? '');
    final isEditing = facility != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          isEditing ? 'Edit Facility' : 'Add Facility',
          style: const TextStyle(color: Color(0xFF1565C0)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: capacityController,
              decoration: const InputDecoration(labelText: 'Capacity'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newFacility = Facility(
                name: nameController.text,
                location: locationController.text,
                capacity: int.tryParse(capacityController.text) ?? 0,
              );
              try {
                if (isEditing) {
                  await FacilityService.update(facility.id!, newFacility);
                } else {
                  await FacilityService.create(newFacility);
                }
                if (ctx.mounted) Navigator.pop(ctx);
                _loadFacilities();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF1565C0),
                      content: Text(isEditing
                          ? 'Facility updated successfully'
                          : 'Facility created successfully'),
                    ),
                  );
                }
              } catch (e) {
                if (ctx.mounted) {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Error: $e'),
                    ),
                  );
                }
              }
            },
            child: Text(isEditing ? 'Update' : 'Add'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(Facility facility) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Delete Facility',
          style: TextStyle(color: Colors.red),
        ),
        content: Text('Are you sure you want to delete "${facility.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              try {
                await FacilityService.delete(facility.id!);
                if (ctx.mounted) Navigator.pop(ctx);
                _loadFacilities();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Facility deleted successfully'),
                    ),
                  );
                }
              } catch (e) {
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting facility: $e')),
                  );
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facilities'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Facility>>(
        future: _facilities,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xFF1565C0)));
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      color: Colors.red, size: 48),
                  const SizedBox(height: 8),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _loadFacilities,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final facilities = snapshot.data!;
          if (facilities.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.business, color: Color(0xFFBBDEFB), size: 64),
                  SizedBox(height: 12),
                  Text('No facilities found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              final f = facilities[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF1565C0),
                    child: Icon(Icons.business, color: Colors.white),
                  ),
                  title: Text(f.name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${f.location}\nCapacity: ${f.capacity}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF1565C0)),
                        onPressed: () => _showFacilityDialog(facility: f),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(f),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFacilityDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
