import 'package:get/get.dart';
import '../model/session_model.dart';
import '../service/session_service.dart';

class SessionListController extends GetxController {
  var sessions = <SessionModel>[].obs;
  var isLoading = false.obs;
  var page = 1.obs;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchSessions();
  }

  Future<void> fetchSessions({int page = 1}) async {
    isLoading(true);
    try {
      final list = await SessionService.fetchSessions(page: page, limit: limit);
      sessions.assignAll(
        list
            .map((e) => SessionModel.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
      this.page.value = page;
    } catch (e) {
      print('fetchSessions error: $e');
    } finally {
      isLoading(false);
    }
  }
}
