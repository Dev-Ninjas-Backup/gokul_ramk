// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/features/trainer/home/home_screen/meal_screen/model/meal_model.dart';
import 'package:http/http.dart' as http;

class MealService {
  // NetworkClient client = NetworkClient(
  //   onUnAuthorize: () {
  //     EasyLoading.showToast("Unauthorized");
  //   },
  // );

  Future<Map<String, dynamic>> createMeal(MealCreateRequest meal) async {
    final url = Uri.parse(Urls.createMeal);

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(meal.toJson()),
      );

      print("STATUS: ${res.statusCode}");
      print("BODY: ${res.body}");

      final body = jsonDecode(res.body);

      return {
        "success": res.statusCode == 200 || res.statusCode == 201,
        "message": body["message"] ?? "No message returned",
      };
    } catch (e) {
      print("Meal create error: $e");

      return {"success": false, "message": "Something went wrong"};
    }
  }
}
