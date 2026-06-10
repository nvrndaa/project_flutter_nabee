import 'package:flutter/material.dart';

class EditNameDialog extends StatelessWidget {
  final String currentName;

  const EditNameDialog({super.key, required this.currentName});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: currentName);

    return Dialog(
      backgroundColor: Colors.transparent, // Transparan biar border melengkungnya rapi
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: 260, // Lebar kotak kapsul dialog
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: const Color(0xFFF1B71C), // Border kuning emas khas Nabee
              width: 3,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                autofocus: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4E1F0F),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Nama",
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    Navigator.pop(context, value.trim()); // Kirim nama baru pas di-enter
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}