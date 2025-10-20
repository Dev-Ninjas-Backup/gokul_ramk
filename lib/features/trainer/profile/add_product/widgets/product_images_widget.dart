// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import '../controller/add_product_controller.dart';

// class ProductImagesSection extends StatelessWidget {
//   final AddProductController controller;

//   const ProductImagesSection({super.key, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Main product image
//         Container(
//           height: 200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(12),
//             color: Colors.grey.shade200,
//           ),
//           clipBehavior: Clip.hardEdge,
//           child: Obx(
//             () => controller.images.isNotEmpty
//                 ? Image.asset(controller.images.first, fit: BoxFit.cover)
//                 : Center(
//                     child: Icon(Icons.image, size: 50, color: Colors.grey),
//                   ),
//           ),
//         ),
//         SizedBox(height: 10),

//         /// Thumbnails + Add button
//         SizedBox(
//           height: 80,
//           child: Obx(
//             () => ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: controller.selectedImage.length + 1,
//               separatorBuilder: (_, __) => SizedBox(width: 10),
//               itemBuilder: (context, index) {
//                 final image = controller.selectedImage.value;

//                 if (index < controller.images.length) {
//                   return Container(
//                     width: 80,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.grey.shade200,
//                     ),
//                     clipBehavior: Clip.hardEdge,
//                     child: Image.asset(
//                       controller.images[index],
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 } else {
//                   /// Add new image button
//                   return GestureDetector(
//                     onTap: () => controller.pickImage(ImageSource.gallery),
//                     child: Container(
//                       width: 80,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         border: Border.all(color: Colors.grey.shade400),
//                       ),
//                       child: Icon(Icons.add, size: 30, color: Colors.grey),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controller/add_product_controller.dart';

class ProductImagesSection extends StatelessWidget {
  final AddProductController controller;

  const ProductImagesSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade200,
          ),
          clipBehavior: Clip.hardEdge,
          child: Obx(() {
            if (controller.selectedImages.isNotEmpty) {
              return Image.file(
          
                controller.selectedImages[controller.index.value],
                fit: BoxFit.cover,
                width: double.infinity,
              );
            } else {
              return const Center(
                child: Icon(Icons.image, size: 50, color: Colors.grey),
              );
            }
          }),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 80,
          child: Obx(() {
            return ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: controller.selectedImages.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                if (index == controller.selectedImages.length) {
                  return GestureDetector(
                    onTap: () => controller.pickImage(ImageSource.gallery),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: const Icon(Icons.add, size: 30, color: Colors.grey),
                    ),
                  );
                }

                // ✅ Show picked image thumbnail
                final File imageFile = controller.selectedImages[index];
                return Stack(
                  children: [
                    GestureDetector(

                    onTap: (){
                    controller.index.value=index;

                    },
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey.shade200,
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Image.file(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      right: 4,
                      top: 4,
                      child: GestureDetector(
                        onTap: () => controller.removeImage(index),
                        child: Container(
                          decoration:  BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          padding:  EdgeInsets.all(3),
                          child:  Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
