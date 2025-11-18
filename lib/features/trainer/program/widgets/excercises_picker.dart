import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/features/trainer/program/controller/program_controller.dart';
import 'package:gokul_ramk/features/trainer/program/model/excercise_model.dart';

Widget exercisePicker(ProgramController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 20),
      Text(
        "Search Exercise",
        style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
      Obx(
        () => DropdownButtonFormField<Exercise>(
          initialValue: controller.selectedExercise.value,
          items: controller.allExercises
              .map((e) => DropdownMenuItem(value: e, child: Text(e.name)))
              .toList(),
          onChanged: controller.selectExercise,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.green, width: 1.5),
            ),
          ),
        ),
      ),
    ],
  );
}
