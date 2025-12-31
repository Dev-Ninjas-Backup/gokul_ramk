import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:gokul_ramk/features/user/user_home/model/program_model.dart';
import 'package:gokul_ramk/features/user/user_home/service/user_home_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ProgramDetailsController extends GetxController {
  final CategoryService service = CategoryService(
    client: NetworkClient(
      onUnAuthorize: () {
        if (kDebugMode) {
          print("unauthorized");
        }
      },
    ),
  );

  var isLoading = false.obs;
  var program = Rxn<Program1>();
  var errorMessage = ''.obs;

  Future<void> fetchProgramDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await service.fetchProgramById(id);

      if (result != null) {
        program.value = result;
      } else {
        errorMessage.value = 'Program not found';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> showBuyDialog(BuildContext context, String id) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        // ← looks native on iOS/Android
        title: const Text('Confirm Purchase'),
        content: const Text('Do you want to buy this program?'),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            // ← modern look, Material 3
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Buy Now'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      bookProgram(id);
    }
  }

  SharedPreferencesHelperController pref =
      Get.find<SharedPreferencesHelperController>();

  Future<void> bookProgram(String id) async {
    try {
      final url = Uri.parse('${Urls.baseUrl}/programs/book-program/$id');

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',

          'Authorization': await pref.getAccessToken() ?? '',
        },
      );

      final decoded = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode==201) {
        final checkoutUrl = decoded['data'];

        if (checkoutUrl != null) {
          await _launchUrl(checkoutUrl);
        }
      } else {
      print("Booking failed");
        Get.snackbar('Error', decoded['message'] ?? 'Booking failed');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar('Error', 'Could not open payment link');
    }
  }
}
