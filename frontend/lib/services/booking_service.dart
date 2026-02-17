import '../models/booking.dart';
import 'api_service.dart';

class BookingService {
  static Future<List<Booking>> getAll() async {
    final data = await ApiService.getAll('bookings');
    return data.map((json) => Booking.fromJson(json)).toList();
  }

  static Future<Booking> create(Booking booking) async {
    final data = await ApiService.create('bookings', booking.toJson());
    return Booking.fromJson(data);
  }

  static Future<Booking> update(int id, Booking booking) async {
    final data = await ApiService.update('bookings', id, booking.toJson());
    return Booking.fromJson(data);
  }

  static Future<void> delete(int id) async {
    await ApiService.delete('bookings', id);
  }
}
