import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/core/services/local_notification_service.dart';
import 'package:flutter_nabee/data/datasources/honey_jar_remote_datasource.dart';
import 'package:flutter_nabee/data/model/request/honey_jar_request_model.dart';
import 'package:flutter_nabee/ui/models/jar_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

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
  String notification = "3x";
  bool isLoading = false;

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

  InputDecoration get dropdownDecoration => InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        isDense: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.orange, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: AppColors.orange, width: 2)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
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

  Widget buildField(String hint, TextEditingController controller,
          {TextInputType keyboardType = TextInputType.text}) =>
      TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: inputDecoration(hint),
        style: const TextStyle(fontSize: 15),
      );

  @override
  void dispose() {
    nameController.dispose();
    startController.dispose();
    endController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = nameController.text.trim();
    final rawPrice = priceController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final startDate = startController.text.trim();
    final endDate = endController.text.trim();

    if (name.isEmpty || rawPrice.isEmpty || endDate.isEmpty) return;

    final targetAmount = int.tryParse(rawPrice);
    if (targetAmount == null || targetAmount < 5000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimal target Rp5.000')),
      );
      return;
    }

    setState(() => isLoading = true);

    final request = CreateHoneyJarRequestModel(
      jarName: name,
      targetAmount: targetAmount,
      deadline: endDate,
    );

    final result =
        await HoneyJarRemoteDatasource().createHoneyJar(request);

    if (!mounted) return;

    result.fold(
      (error) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      },
      (response) {
        widget.onSave(JarModel(
          id: response.id,
          name: response.jarName,
          startDate: startDate,
          endDate: response.deadline,
          price: response.targetAmount,
          currentAmount: response.currentAmount,
          notification: notification,
        ));
        final times = int.tryParse(notification.replaceAll('x', '')) ?? 3;
        LocalNotificationService().scheduleJarReminders(
          jarId: response.id,
          jarName: response.jarName,
          timesPerDay: times,
        );
        Navigator.pop(context);
      },
    );
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
              buildFormGroup(
                "Target Amount",
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.orange, width: 1.5),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      const Text("Rp",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black87)),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [ThousandsFormatter()],
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              buildFormGroup(
                "Notification",
                DropdownButtonFormField<String>(
                    initialValue: notification,
                    isExpanded: false,
                    hint: const Text(
                      "Choose",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    decoration: dropdownDecoration,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.orange, size: 22),
                    items: const [
                      DropdownMenuItem(
                          value: "3x",
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text("3x",
                                style: TextStyle(fontSize: 12)),
                          )),
                      DropdownMenuItem(
                          value: "5x",
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text("5x",
                                style: TextStyle(fontSize: 12)),
                          )),
                      DropdownMenuItem(
                          value: "7x",
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text("7x",
                                style: TextStyle(fontSize: 12)),
                          )),
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
                  onPressed: isLoading ? null : _save,
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : const Text(
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
            controller.text =
                "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
          }
        },
      );
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return newValue.copyWith(text: '');
    }
    final number = int.parse(digits);
    final formatted = NumberFormat('#,###', 'id').format(number);
    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
