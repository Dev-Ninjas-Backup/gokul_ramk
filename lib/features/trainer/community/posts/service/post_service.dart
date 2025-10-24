import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/endpoint/end_points.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import 'package:http/http.dart' as http;
import 'package:gokul_ramk/core/services/local_service/shared_preferences_helper.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import 'package:http_parser/http_parser.dart';

Future<NetworkResponse> createPost({
  required String title,
  required String content,
  required File imageFile,
}) async {
  try {
    final sharedPrefs = Get.put(SharedPreferencesHelperController());
    final token = (await sharedPrefs.getAccessToken())?.trim();

    String ext = path.extension(imageFile.path).toLowerCase();
    String mimeSubtype;

    if (ext == '.png') {
      mimeSubtype = 'png';
    } else if (ext == '.jpg' || ext == '.jpeg') {
      mimeSubtype = 'jpeg';
    } else {
      mimeSubtype = 'octet-stream';
    }

    if (token == null || token.isEmpty) {
      throw Exception('No access token found');
    }

    final uri = Uri.parse(Urls.trainerPost);
    final request = http.MultipartRequest('POST', uri);

    request.fields['title'] = title;
    request.fields['content'] = content;

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
        contentType: MediaType('image', mimeSubtype),
      ),
    );

    request.headers['Authorization'] = token;

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    final Map<String, dynamic> jsonResponse = jsonDecode(responseBody);

    return NetworkResponse(
      statusCode: response.statusCode,
      isSuccess: response.statusCode >= 200 && response.statusCode < 300,
      responseData: jsonResponse,
    );
  } catch (e, st) {
    debugPrint('Error creating post: $e\n$st');
    throw Exception('Error creating post: $e');
  }
}
