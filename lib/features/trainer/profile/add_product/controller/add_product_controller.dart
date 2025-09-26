import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  var images = <String>[].obs;

  var categories = ["Nutrition", "Fitness", "Supplements", "Accessories"].obs;
  var selectedCategory = "Nutrition".obs;

  var deliveryOptions = [
    "Both Shipping & Pickup",
    "Shipping Only",
    "Pickup Only",
  ].obs;
  var selectedDelivery = "Both Shipping & Pickup".obs;

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descriptionController = TextEditingController();

  void addImage() {
    // for demo, just add sample image
    images.add("assets/images/productSample.png");
  }
}
