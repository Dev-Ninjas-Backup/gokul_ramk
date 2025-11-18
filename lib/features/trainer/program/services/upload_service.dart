// // core/services/upload_service.dart
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gokul_ramk/core/services/network_service/network_client.dart';

// class UploadService {
//   final NetworkClient _client = Get.find<NetworkClient>();
//   static const String _base = "https://wellfitsync.com";

//   Future<String?> upload(File file) async {
//     final response = await _client.uploadFile(
//       url: "$_base/upload",
//       file: file,
//     );

//     if (response.isSuccess) {
//       final String relativeUrl = response.responseData!['file']['url'];
//       return _base + relativeUrl; // → full URL
//     }

//     Get.snackbar("Upload Failed", response.errorMessage ?? "", backgroundColor: Colors.red);
//     return null;
//   }
// }