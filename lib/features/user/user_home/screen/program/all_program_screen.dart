import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gokul_ramk/features/trainer/program/controller/program_controller.dart';
import 'package:gokul_ramk/features/user/user_home/controller/user_home_controller.dart';
import 'package:gokul_ramk/features/user/user_home/screen/program/program_details_screen.dart';
import 'package:gokul_ramk/features/user/user_home/screen/program_detail_screen.dart';
import 'package:gokul_ramk/features/user/user_home/widget/program_card.dart';
 // Make sure this is your ProgramCard1 widget

class AllProgramsScreenUser extends StatelessWidget {
  AllProgramsScreenUser({super.key});

  final UserHomeController controller = Get.find<UserHomeController>();

  @override
  Widget build(BuildContext context) {
    // Fetch programs when the screen loads
    

    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.white,
        title: const Text('All Programs'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Obx(() {
          // Loading state
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // No programs
          if (controller.programsAll1.isEmpty) {
            return const Center(child: Text('No programs found'));
          }

          // Programs list
          return ListView.builder(
          shrinkWrap: true,
         // physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: controller.programsAll1.length,
            itemBuilder: (context, index) {
              final  program = controller.programsAll1[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: GestureDetector(
                onTap: (){
                
                Get.to(() => ProgramDetailsScreenUser(programId: program.id.toString(),));
                },
                
                child: ProgramCard1(program: program)),
              );
            },
          );
        }),
      ),
    );
  }
}
