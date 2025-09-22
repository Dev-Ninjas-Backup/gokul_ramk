import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/common/styles/global_text_style.dart';
import '../controller/program_controller.dart';

class ProgramDetailsScreen extends StatelessWidget {
  const ProgramDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProgramController>();
    final program = controller.currentProgram.value!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,

        leading: BackButton(),
        title: Text(
          program.name,

          style: getTextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [Icon(Icons.share, color: Colors.green)],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (program.thumbnail != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(program.thumbnail!),
              ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Duration: ${program.duration}",
                  style: getTextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Type: ${program.category}",
                  style: getTextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "Description-",
              style: getTextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              program.description,
              style: getTextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Workout Schedule-",
              style: getTextStyle(fontWeight: FontWeight.bold),
            ),
            ...program.sessions.map(
              (s) => Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(
                    s.exercise,
                    style: getTextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${s.sets} sets • ${s.reps} reps • ${s.duration}",
                    style: getTextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {}, child: Text("Continue")),
            ),
          ],
        ),
      ),
    );
  }
}
