import 'package:flutter/material.dart';
import 'package:gokul_ramk/core/common/styles/global_text_style.dart';
import 'package:gokul_ramk/core/common/widgets/custom_app_bar_title.dart';

class UserCreateGroupScreen extends StatelessWidget {
  UserCreateGroupScreen({super.key});

  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBarTitle(title: 'Create Group'),
              const SizedBox(height: 16),
              Text(
                "Thumbnail",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.image, size: 40, color: Colors.grey),
                      SizedBox(height: 6),
                      Text(
                        "Click here to upload thumbnail image",
                        style: getTextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 30),

              // ✅ Program Info
              Text(
                "Group Info",
                style: getTextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              SizedBox(height: 20),
              Text(
                "Group Name",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Program Name
              buildTextField(
                "Add program name",
                textController: groupNameController,
              ),

              SizedBox(height: 12),
              SizedBox(height: 20),
              Text(
                "Description",
                style: getTextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Description
              buildTextField(
                "Write a description about this program",
                maxLines: 3,
                textController: descriptionController,
              ),

              SizedBox(height: 30),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue[50],
                      ),

                      onPressed: () {},
                      child: Text(
                        "Cancel",
                        style: getTextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // spacing
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF148CBB),
                      ),
                      onPressed: () {},
                      child: Text("Send Request"),
                    ),
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

Widget buildTextField(
  String hint, {
  IconData? suffixIcon,
  int maxLines = 1,
  required TextEditingController textController,
}) {
  return TextField(
    controller: textController,
    maxLines: maxLines,
    decoration: InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: Colors.grey)
          : null,
    ),
  );
}
