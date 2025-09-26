import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';
import 'package:gokul_ramk/features/trainer/bottom_navbar/controller/navbar_controller.dart';
import 'package:gokul_ramk/routes/app_routes.dart';

class OrderConfirmationScreen extends StatelessWidget {
  OrderConfirmationScreen({super.key});

  final NavBarController navBarController = Get.put(NavBarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              CustomAppBarTitle(title: 'Order Confirmation'),
              const SizedBox(height: 80),
              Column(
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.done, color: Colors.white, size: 32),
                  ),
                  Text(
                    'Your order has been placed!',
                    style: getTextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text('Order ID: #FITX20250901'),
                  Text('Delivery Estimate: Expected by Aug 20'),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Get.offAllNamed(AppRoute.userNavBarScreen);
                    },
                    child: Text('Back to Shop'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
