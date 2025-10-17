import 'package:flutter_easyloading/flutter_easyloading.dart';

void showEasyLoadingError(String s, {String message = 'Fill up all fields'}) async {
  EasyLoading.showError(message);
  await Future.delayed(Duration(seconds: 1));
  EasyLoading.dismiss();
}
