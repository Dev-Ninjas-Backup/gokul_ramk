import 'package:get/get.dart';
import 'package:gokul_ramk/features/user/shop/model/shop_product_model.dart';


class ShopController extends GetxController {
  var categories = [
    {"icon": "https://nutritionsource.hsph.harvard.edu/wp-content/uploads/2021/11/shutterstock_719023027-768x512.jpg", "title": "Supplements"},
    {"icon": "https://katiecouric.com/wp-content/uploads/2022/02/MealKit.jpg", "title": "Meal Kits"},
    {"icon": "https://classpass.com/blog/wp-content/uploads/2019/09/shutterstock_1085127563.jpg", "title": "Gear & Apparel"},
    {"icon": "https://libapps-au.s3-ap-southeast-2.amazonaws.com/accounts/1591/images/FAVPNG_educational-technology-smartphone-school-higher-education_WsiwsJxV.png", "title": "Guides & E-Books"},
  ].obs;

  var products = <ShopProductModel>[
    ShopProductModel(
      title: "Whey Protein Isolate (2lbs)",
      description: "Vanilla, 25g protein per scoop.",
      price: 39.99,
      image: "https://www.teamcp.co.nz/wp-content/uploads/2021/07/protiencpowder-600x433.png",
      rating: 4.8,
      reviews: 320,
    ),
    ShopProductModel(
      title: "Whey Protein Isolate (2lbs)",
      description: "Vanilla, 25g protein per scoop.",
      price: 39.99,
      image: "https://www.teamcp.co.nz/wp-content/uploads/2021/07/protiencpowder-600x433.png",
      rating: 4.8,
      reviews: 320,
    ),
  ].obs;
}
