// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../core/common/styles/global_text_style.dart';
// import '../../../../core/utils/constants/icon_path.dart';
// import '../../../../core/utils/constants/imagepath.dart';
// import '../controller/program_controller.dart';

// class ProgramDetailsScreen extends StatelessWidget {
//   const ProgramDetailsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<ProgramController>();
//     final program = controller.currentProgram.value!;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: BackButton(),
//         title: Text(
//           program.name,
//           style: getTextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Image.asset(IconPath.shareIcon, height: 30, width: 30),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.asset(Imagepath.programDetailImg),
//             SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Duration: ${program.duration}",
//                   style: getTextStyle(
//                     color: Colors.grey,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "Type: ${program.category}",
//                   style: getTextStyle(
//                     color: Colors.grey,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),
//             Text(
//               "Description-",
//               style: getTextStyle(fontWeight: FontWeight.bold),
//             ),
//             Text(
//               program.description,
//               style: getTextStyle(
//                 color: Colors.grey,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 30),
//             Text(
//               "Workout Schedule-",
//               style: getTextStyle(fontWeight: FontWeight.bold),
//             ),
//             ...program.sessions.map(
//               (s) => Card(
//                 color: Colors.white,
//                 child: ListTile(
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         s.exercise,
//                         style: getTextStyle(
//                           color: Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Obx(
//                         () => Text(
//                           "Day ${controller.selectedDay.value + 1}",
//                           style: getTextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   subtitle: Text(
//                     "${s.sets} sets • ${s.reps} reps • ${s.duration}",
//                     style: getTextStyle(
//                       color: Colors.grey,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Align(
//               alignment: Alignment.center,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.lightBlue[50],
//                   foregroundColor: Colors.blue,
//                   minimumSize: Size(0, 40),
//                 ),
//                 child: Text(
//                   'View More',
//                   style: getTextStyle(
//                     color: Colors.blue,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 30),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(onPressed: () {}, child: Text("Continue")),
//             ),
//             SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }
