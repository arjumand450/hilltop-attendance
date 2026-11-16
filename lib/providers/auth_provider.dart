import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class AuthProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _users = [];
  Map<String, dynamic>? _currentUser;
  String? _error;
  bool _isLoading = false;

  bool get isLoggedIn => _currentUser != null;
  String? get userName => _currentUser?['name'] as String?;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> _loadUsers() async {
    if (_users.isNotEmpty) return;
    final raw = await rootBundle.loadString('assets/users.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    _users = List<Map<String, dynamic>>.from(data['users'] as List);
  }

  /// Returns true if the email and password match a user in users.json.
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _loadUsers();
      final match = _users.where((u) =>
          (u['email'] as String).toLowerCase() == email.trim().toLowerCase() &&
          u['password'] == password);

      if (match.isEmpty) {
        _error = 'Wrong email or password';
        return false;
      }
      _currentUser = match.first;
      return true;
    } catch (e) {
      _error = 'Could not load users';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    _currentUser = null;
    _error = null;
    notifyListeners();
  }
}