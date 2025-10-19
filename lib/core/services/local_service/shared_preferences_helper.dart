// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesHelper extends GetxController {
//   static const String _accessTokenKey = 'access_token';
//   static const String _selectedRoleKey = 'role';
//   static const String _userId = "id";

//   // Save access token
//   Future<void> saveToken(String token) async {
//     final String saveToken = 'Bearer $token';
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_accessTokenKey, saveToken);
//     await prefs.setBool('isLogin', true);
//   }

//   // Retrieve access token
//   Future<String?> getAccessToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_accessTokenKey);
//   }

//   // Clear access token
//   Future<void> clearAllData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_accessTokenKey); // Clear the token
//     await prefs.remove(_selectedRoleKey); // Clear the role
//     await prefs.remove('isLogin'); // Clear the login status
//   }

//   //save role
//   Future<void> saveSelectedRole(String role) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_selectedRoleKey, role);
//   }

//   // Retrieve selected role
//   Future<String?> getSelectedRole() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_selectedRoleKey);
//   }

//   Future<bool?> checkLogin() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getBool("isLogin") ?? false;
//   }

//   //save user id
//   Future<void> saveUserId(String id) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_userId, id);
//   }

//   // Retrieve user id
//   Future<String?> getUserId() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_userId);
//   }

//   // Save the flag indicating the dialog has been shown
//   // Future<void> setWelcomeDialogShown(bool value) async {
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   await prefs.setBool(_isWelcomeDialogShownKey, value);
//   // }

//   // Retrieve the flag to check if the dialog has been shown
//   // Future<bool> isWelcomeDialogShown() async {
//   //   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   //   return prefs.getBool(_isWelcomeDialogShownKey) ?? false;
//   // }
// }
