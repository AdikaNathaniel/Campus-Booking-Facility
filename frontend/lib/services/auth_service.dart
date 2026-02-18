import '../models/user.dart';
import 'api_service.dart';

class AuthService {
  static User? _currentUser;

  static User? get currentUser => _currentUser;

  static bool get isLoggedIn => _currentUser != null;

  static bool get isAdmin => _currentUser?.role == 'admin';

  static bool get isFaculty => _currentUser?.role == 'faculty';

  static bool get isStudent => _currentUser?.role == 'student';

  static Future<User?> login(String email) async {
    final data = await ApiService.getAll('users');
    final users = data.map((json) => User.fromJson(json)).toList();

    final match = users.where(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );

    if (match.isNotEmpty) {
      _currentUser = match.first;
      return _currentUser;
    }
    return null;
  }

  static Future<User> register({
    required String name,
    required String email,
    required String role,
  }) async {
    final newUser = User(name: name, email: email, role: role);
    final data = await ApiService.create('users', newUser.toJson());
    _currentUser = User.fromJson(data);
    return _currentUser!;
  }

  static void logout() {
    _currentUser = null;
  }
}
