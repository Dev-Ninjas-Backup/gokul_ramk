// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
// import 'package:gokul_ramk/core/utils/constants/colors.dart';
// import 'package:gokul_ramk/features/trainer/my_clients/client_profile/controller/progress_filter_controller.dart';

// class ProgressHeaderWidget extends StatelessWidget {
//   final ProgressFilterController controller = Get.put(
//     ProgressFilterController(),
//   );

//   ProgressHeaderWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           "Progress",
//           style: getTextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//             color: AppColors.primaryFontColor,
//           ),
//         ),
//         Spacer(),
//         Flexible(
//           child: ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.white,
//               foregroundColor: Colors.black87,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               elevation: 0,
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             ),
//             onPressed: () {
//               _showFilterDialog();
//             },
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   controller.selectedFilter.value,
//                   style: getTextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.fontColor,
//                   ),
//                 ),
//                 Icon(Icons.arrow_drop_down, size: 18),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _showFilterDialog() {
//     Get.dialog(
//       barrierDismissible: false,
//       Dialog(
//         backgroundColor: AppColors.background,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: controller.filters.map((filter) {
//             return ListTile(
//               title: Text(
//                 filter,
//                 style: getTextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.primaryFontColor,
//                 ),
//               ),
//               onTap: () => controller.updateFilter(filter),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/utils/constants/colors.dart';
import 'package:gokul_ramk/features/trainer/my_clients/client_profile/controller/progress_filter_controller.dart';

class ProgressHeaderWidget extends StatelessWidget {
  final ProgressFilterController controller = Get.put(
    ProgressFilterController(),
  );

  ProgressHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "Progress",
          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryFontColor,
          ),
        ),
        Spacer(),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: DropdownButton<String>(
              value: controller.selectedFilter.value,
              underline: SizedBox.shrink(),
              icon: Icon(Icons.arrow_drop_down, size: 18),
              items: controller.filters
                  .map(
                    (filter) => DropdownMenuItem(
                      value: filter,
                      child: Text(
                        filter,
                        style: getTextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.fontColor,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) controller.updateFilter(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}
