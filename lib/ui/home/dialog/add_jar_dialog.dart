import 'package:flutter/material.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/ui/models/jar_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddJarDialog extends StatefulWidget {
  final Function(JarModel) onSave;

  const AddJarDialog({super.key, required this.onSave});

  @override
  State<AddJarDialog> createState() => _AddJarDialogState();
}

class _AddJarDialogState extends State<AddJarDialog> {
  final nameController = TextEditingController();
  final startController = TextEditingController();
  final endController = TextEditingController();
  final priceController = TextEditingController();
  String notification = "Choose";

  InputDecoration inputDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.orange, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: AppColors.orange, width: 2)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      );

  Widget buildFormGroup(String label, Widget child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.brownText,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      );

  Widget buildField(String hint, TextEditingController controller) => TextField(
        controller: controller,
        decoration: inputDecoration(hint),
        style: const TextStyle(fontSize: 15),
      );

  Widget buildDateField({
    required TextEditingController controller,
    required String hint,
  }) =>
      TextField(
        controller: controller,
        readOnly: true,
        style: const TextStyle(fontSize: 15),
        decoration: inputDecoration(hint).copyWith(
          suffixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              "assets/icons/calender.svg",
              width: 18,
              height: 18,
              colorFilter:
                  const ColorFilter.mode(AppColors.orange, BlendMode.srcIn),
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.orange,
                size: 18,
              ),
            ),
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2024),
            lastDate: DateTime(2035),
          );
          if (pickedDate != null) {
            setState(() {
              controller.text =
                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
            });
          }
        },
      );

  @override
  void dispose() {
    nameController.dispose();
    startController.dispose();
    endController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Make New Jar",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.brownText,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildFormGroup("Nama", buildField("", nameController)),
              const SizedBox(height: 12),
              buildFormGroup(
                "Date",
                Column(
                  children: [
                    buildDateField(controller: startController, hint: "Start"),
                    const SizedBox(height: 8),
                    buildDateField(controller: endController, hint: "End"),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              buildFormGroup("Price", buildField("Rp.", priceController)),
              const SizedBox(height: 12),
              buildFormGroup(
                "Notification",
                DropdownButtonFormField<String>(
                  value: notification == "Choose" ? null : notification,
                  hint: const Text(
                    "Choose",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  decoration: inputDecoration(""),
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: AppColors.orange),
                  items: const [
                    DropdownMenuItem(value: "3x", child: Text("3 times")),
                    DropdownMenuItem(value: "5x", child: Text("5 times")),
                    DropdownMenuItem(value: "7x", child: Text("7 times")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      notification = value!;
                    });
                  },
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    final newJar = JarModel(
                      name: nameController.text.isEmpty
                          ? "Jar"
                          : nameController.text,
                      startDate: startController.text,
                      endDate: endController.text,
                      price: priceController.text,
                      notification: notification,
                    );
                    widget.onSave(newJar);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
