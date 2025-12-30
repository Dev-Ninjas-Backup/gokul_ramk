import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/services/network_service/network_client.dart';
import '../service/session_service.dart';
import '../model/session_model.dart';
import '../model/package_model.dart';
import '../model/program_model.dart';
import '../model/category_model.dart';
import '../controller/session_list_controller.dart';

class EditSessionController extends GetxController {
  final service = SessionService(
    NetworkClient(onUnAuthorize: () => EasyLoading.showInfo('Unauthorized')),
  );

  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  var selectedPackageId = RxnString();
  var selectedProgramId = RxnString();
  var selectedCategoryId = RxnString();

  var packages = <PackageModel>[].obs;
  var programs = <ProgramModel>[].obs;
  var categories = <CategoryModel>[].obs;

  String? sessionId;
  var isLoading = false.obs;

  @override
  void onClose() {
    titleCtrl.dispose();
    descCtrl.dispose();
    super.onClose();
  }

  Future<void> init(String id) async {
    sessionId = id;
    isLoading(true);
    try {
      packages.assignAll(await SessionService.fetchPackages());
      programs.assignAll(await SessionService.fetchPrograms());
      categories.assignAll(await SessionService.fetchCategories());

      final res = await service.getSessionById(id);
      if (res.isSuccess && res.responseData != null) {
        final data =
            res.responseData!['data'] as Map<String, dynamic>? ??
            res.responseData! as Map<String, dynamic>?;

        if (data != null) {
          final s = SessionModel.fromJson(data);
          titleCtrl.text = s.title;
          descCtrl.text = s.description;
          selectedCategoryId.value = s.categoryId;
          selectedProgramId.value = s.programId;
          selectedPackageId.value = s.packageId;
        }
      }
    } catch (e) {
      debugPrint('init edit session error: $e');
    } finally {
      isLoading(false);
    }
  }

  // ───────────────────────── UPDATE SESSION ─────────────────────────
  Future<void> updateSession() async {
    if (sessionId == null) return;

    isLoading(true);
    try {
      final body = {
        'title': titleCtrl.text.trim(),
        'description': descCtrl.text.trim(),
        'categoryId': selectedCategoryId.value,
      };

      if (selectedProgramId.value != null) {
        body['programId'] = selectedProgramId.value;
      }
      if (selectedPackageId.value != null) {
        body['packageId'] = selectedPackageId.value;
      }

      final res = await service.updateSession(id: sessionId!, data: body);

      if (res.isSuccess) {
        EasyLoading.showSuccess(
          res.responseData?['message'] ?? 'Session updated',
        );

        // ✅ REFRESH SESSION LIST CONTROLLER
        if (Get.isRegistered<SessionListController>()) {
          final listCtrl = Get.find<SessionListController>();
          await listCtrl.fetchSessions(page: listCtrl.page.value);
        }

        Get.back(); // go back to list screen
      } else {
        Get.snackbar('Error', res.errorMessage ?? 'Update failed');
      }
    } catch (e) {
      Get.snackbar('Exception', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
