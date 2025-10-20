import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelperController extends GetxController {
  static const String _accessTokenKey = 'access_token';
  static const String _selectedRoleKey = 'role';

  // Save access token
  Future<void> saveToken(String token) async {
    final String saveToken = 'Bearer $token';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, saveToken);
    await prefs.setBool('success', true);
  }

  // Retrieve access token
  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Clear access token
  Future<void> clearAllData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey); // Clear the token
    await prefs.remove(_selectedRoleKey); // Clear the role
    await prefs.remove('success'); // Clear the login status
  }

  //save role
  Future<void> saveSelectedRole(String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedRoleKey, role);
  }

  // Retrieve selected role
  Future<String?> getSelectedRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedRoleKey);
  }

  Future<bool?> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("success") ?? false;
  }

}
