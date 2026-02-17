import '../models/user.dart';
import 'api_service.dart';

class UserService {
  static Future<List<User>> getAll() async {
    final data = await ApiService.getAll('users');
    return data.map((json) => User.fromJson(json)).toList();
  }

  static Future<User> create(User user) async {
    final data = await ApiService.create('users', user.toJson());
    return User.fromJson(data);
  }

  static Future<User> update(int id, User user) async {
    final data = await ApiService.update('users', id, user.toJson());
    return User.fromJson(data);
  }

  static Future<void> delete(int id) async {
    await ApiService.delete('users', id);
  }
}
