import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../model/package_model.dart';
import '../model/program_model.dart';
import '../model/category_model.dart';
import '../service/session_service.dart';

class CreateSessionController extends GetxController {
  final titleCtrl = TextEditingController();
  final durationCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  var packages = <PackageModel>[].obs;
  var programs = <ProgramModel>[].obs;
  var categories = <CategoryModel>[].obs;

  var selectedPackageId = RxnString();
  var selectedProgramId = RxnString();
  var selectedCategoryId = RxnString();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDropdowns();
  }

  Future<void> fetchDropdowns() async {
    isLoading(true);
    try {
      final p = await SessionService.fetchPackages();
      packages.assignAll(p);

      final pr = await SessionService.fetchPrograms();
      programs.assignAll(pr);

      final c = await SessionService.fetchCategories();
      categories.assignAll(c);

      if (packages.isNotEmpty) selectedPackageId.value = packages.first.id;
      if (programs.isNotEmpty) selectedProgramId.value = programs.first.id;
      if (categories.isNotEmpty) selectedCategoryId.value = categories.first.id;
    } catch (e) {
      print('fetchDropdowns error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> createSession() async {
    if (selectedCategoryId.value == null || selectedCategoryId.value!.isEmpty) {
      Get.snackbar('Validation', 'Please select a category');
      return;
    }

    isLoading(true);
    try {
      final Map<String, dynamic> body = {
        'title': titleCtrl.text.trim(),
        'duration': int.tryParse(durationCtrl.text.trim()) ?? 0,
        'price': int.tryParse(priceCtrl.text.trim()) ?? 0,
        'description': descCtrl.text.trim(),
        'categoryId': selectedCategoryId.value,
      };

      // optional
      if (selectedProgramId.value != null &&
          selectedProgramId.value!.isNotEmpty) {
        body['programId'] = selectedProgramId.value;
      }
      if (selectedPackageId.value != null &&
          selectedPackageId.value!.isNotEmpty) {
        body['packageId'] = selectedPackageId.value;
      }

      final service = SessionService(
        NetworkClient(
          onUnAuthorize: () => EasyLoading.showInfo('Unauthorized'),
        ),
      );
      final res = await service.createSession(body: body);
      if (res.isSuccess) {
        final msg =
            res.responseData?['message'] ?? 'Session created successfully';
        EasyLoading.showInfo(msg);
        clearAll();
      } else {
        Get.snackbar('Error', res.errorMessage ?? 'Failed to create session');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void clearAll() {
    titleCtrl.clear();
    durationCtrl.clear();
    priceCtrl.clear();
    descCtrl.clear();
    if (packages.isNotEmpty) selectedPackageId.value = packages.first.id;
    if (programs.isNotEmpty) selectedProgramId.value = programs.first.id;
    if (categories.isNotEmpty) selectedCategoryId.value = categories.first.id;
  }
}
