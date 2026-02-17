import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  late Future<List<Booking>> _bookings;

  @override
  void initState() {
    super.initState();
    _loadBookings();
  }

  void _loadBookings() {
    setState(() {
      _bookings = BookingService.getAll();
    });
  }

  void _showBookingDialog({Booking? booking}) {
    final facilityIdController =
        TextEditingController(text: booking?.facilityId.toString() ?? '');
    final userIdController =
        TextEditingController(text: booking?.userId.toString() ?? '');
    final dateController = TextEditingController(text: booking?.date ?? '');
    final startTimeController =
        TextEditingController(text: booking?.startTime ?? '');
    final endTimeController =
        TextEditingController(text: booking?.endTime ?? '');
    final statusController =
        TextEditingController(text: booking?.status ?? 'confirmed');
    final isEditing = booking != null;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          isEditing ? 'Edit Booking' : 'Add Booking',
          style: const TextStyle(color: Color(0xFF1565C0)),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: facilityIdController,
                decoration: const InputDecoration(labelText: 'Facility ID'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: userIdController,
                decoration: const InputDecoration(labelText: 'User ID'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: dateController,
                decoration:
                    const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: startTimeController,
                decoration:
                    const InputDecoration(labelText: 'Start Time (HH:MM)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: endTimeController,
                decoration:
                    const InputDecoration(labelText: 'End Time (HH:MM)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: statusController,
                decoration: const InputDecoration(
                    labelText: 'Status (confirmed/pending/cancelled)'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newBooking = Booking(
                facilityId: int.tryParse(facilityIdController.text) ?? 0,
                userId: int.tryParse(userIdController.text) ?? 0,
                date: dateController.text,
                startTime: startTimeController.text,
                endTime: endTimeController.text,
                status: statusController.text,
              );
              try {
                if (isEditing) {
                  await BookingService.update(booking.id!, newBooking);
                } else {
                  await BookingService.create(newBooking);
                }
                if (ctx.mounted) Navigator.pop(ctx);
                _loadBookings();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: const Color(0xFF1565C0),
                      content: Text(isEditing
                          ? 'Booking updated successfully'
                          : 'Booking created successfully'),
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

  void _confirmDelete(Booking booking) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          'Delete Booking',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
            'Are you sure you want to delete the booking on ${booking.date}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              try {
                await BookingService.delete(booking.id!);
                if (ctx.mounted) Navigator.pop(ctx);
                _loadBookings();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Booking deleted successfully'),
                    ),
                  );
                }
              } catch (e) {
                if (ctx.mounted) Navigator.pop(ctx);
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error deleting booking: $e')),
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

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return const Color(0xFF2E7D32);
      case 'pending':
        return const Color(0xFFE65100);
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Booking>>(
        future: _bookings,
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
                    onPressed: _loadBookings,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          final bookings = snapshot.data!;
          if (bookings.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today,
                      color: Color(0xFFBBDEFB), size: 64),
                  SizedBox(height: 12),
                  Text('No bookings found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 80),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final b = bookings[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _getStatusColor(b.status),
                    child:
                        const Icon(Icons.calendar_today, color: Colors.white, size: 20),
                  ),
                  title: Text(
                    b.facilityName ?? 'Facility #${b.facilityId}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'User: ${b.userName ?? '#${b.userId}'}\n'
                    'Date: ${b.date}\n'
                    'Time: ${b.startTime} - ${b.endTime}\n'
                    'Status: ${b.status}',
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF1565C0)),
                        onPressed: () => _showBookingDialog(booking: b),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmDelete(b),
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
        onPressed: () => _showBookingDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
