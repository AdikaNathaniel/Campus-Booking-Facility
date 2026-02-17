import '../models/facility.dart';
import 'api_service.dart';

class FacilityService {
  static Future<List<Facility>> getAll() async {
    final data = await ApiService.getAll('facilities');
    return data.map((json) => Facility.fromJson(json)).toList();
  }

  static Future<Facility> create(Facility facility) async {
    final data = await ApiService.create('facilities', facility.toJson());
    return Facility.fromJson(data);
  }

  static Future<Facility> update(int id, Facility facility) async {
    final data = await ApiService.update('facilities', id, facility.toJson());
    return Facility.fromJson(data);
  }

  static Future<void> delete(int id) async {
    await ApiService.delete('facilities', id);
  }
}
