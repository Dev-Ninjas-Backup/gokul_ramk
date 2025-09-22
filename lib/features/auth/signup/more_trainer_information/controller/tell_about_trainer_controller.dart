import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TellAboutTrainerController extends GetxController {
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  final bioController = TextEditingController();
  final specializeController = TextEditingController();
  final availabialityController = TextEditingController();
  final sessionController = TextEditingController();

  var selectedAreaOfService = RxnString();
}
