// trainer_profile_controller.dart
import 'package:get/get.dart';
import 'package:gokul_ramk/core/utils/constants/icon_path.dart';
import 'package:gokul_ramk/core/utils/constants/imagepath.dart';
import 'package:gokul_ramk/features/trainer/profile/trainer_profile/model/product_model.dart';

class Program {
  final String title;
  final String description;
  final String icon;

  Program({required this.title, required this.description, required this.icon});
}

class TrainerProfileController extends GetxController {
  // Basic Info
  var name = "Sarah Johnson".obs;
  var email = "sarah.johnson@fitcoach.com".obs;
  var phone = "+1 (555) 123-4567".obs;
  var image = "assets/images/trainer.png".obs;

  // About Me
  var tags = ["Weight Loss", "Strength Training", "Yoga"].obs;
  var description =
      "Certified personal trainer with over 8 years of experience helping clients achieve their fitness goals. "
              "Specialized in weight management, strength building, and functional movement. "
              "NASM certified with additional certifications in yoga and nutrition coaching."
          .obs;

  var rating = 4.5.obs;
  var isCertifiedTrainer = true.obs;
  var yearsExperience = "5+ Years Experience".obs;
  var clientsCount = "200+ Clients".obs;

  // Programs Offered
  var programs = <Program>[
    Program(
      title: "Weight Loss Program",
      description: "Comprehensive fat burning and nutrition plan",
      icon: IconPath.weightLoss,
    ),
    Program(
      title: "Muscle Gain",
      description: "Strength building and muscle development",
      icon: IconPath.musclGain,
    ),
    Program(
      title: "Cardio Routine",
      description: "High-intensity cardiovascular training",
      icon: IconPath.cardio,
    ),
    Program(
      title: "Yoga Sessions",
      description: "Flexibility and mindfulness practice",
      icon: IconPath.yoga,
    ),
  ].obs;

  // ✅ Products
  var products = <Product>[
    Product(
      name: "Whey Protein - Chocolate 1kg",
      price: 45,
      unitsSold: 0,
      earnings: 0,
      image: Imagepath.proteinBottle,
      status: "Pending Review",
    ),
    Product(
      name: "Premium Grip Training Gloves",
      price: 25,
      unitsSold: 32,
      earnings: 640,
      image: Imagepath.gloves,
      status: "Approved (Live in Store)",
    ),
  ].obs;

  var totalRevenue = 5700.0.obs;
  var totalProductsSold = 120.obs;

  var balance = 15590.0.obs;
}
