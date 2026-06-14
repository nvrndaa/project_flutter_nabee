import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nabee/core/constants/colors.dart';
import 'package:flutter_nabee/data/model/request/transaction_request_model.dart';
import 'package:flutter_nabee/ui/home/bloc/transaction/transaction_bloc.dart';
import 'package:intl/intl.dart';

class HoneySavingDialog extends StatefulWidget {
  final int day;
  final int month;
  final int year;
  final int honeyJarId;
  final VoidCallback onSaved;

  const HoneySavingDialog({
    super.key,
    required this.day,
    required this.month,
    required this.year,
    required this.honeyJarId,
    required this.onSaved,
  });

  @override
  State<HoneySavingDialog> createState() => _HoneySavingDialogState();
}

class _HoneySavingDialogState extends State<HoneySavingDialog> {
  final amountController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final raw = amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final amount = int.tryParse(raw);
    if (amount == null || amount < 1000) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Minimal Rp1.000')),
      );
      return;
    }

    setState(() => isLoading = true);

    final request = CreateTransactionRequestModel(
      honeyJarId: widget.honeyJarId,
      amount: amount,
    );

    context.read<TransactionBloc>().add(
          TransactionEvent.createTransaction(request),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listenWhen: (previous, current) =>
          current.maybeWhen(
            success: (_) => true,
            error: (_) => true,
            orElse: () => false,
          ),
      listener: (context, state) {
        state.maybeWhen(
          success: (_) {
            widget.onSaved();
            if (mounted) Navigator.pop(context);
          },
          error: (message) {
            if (mounted) {
              setState(() => isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            }
          },
          orElse: () {},
        );
      },
      child: Dialog(
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Honey Saving",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.brownText,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "How much honey do you want\nto save on day ${widget.day}?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14, color: AppColors.brownText, height: 1.4),
              ),
              const SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: AppColors.orange, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Row(
                  children: [
                    const Text("Rp",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87)),
                    const SizedBox(width: 6),
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [ThousandsFormatter()],
                        style: const TextStyle(fontWeight: FontWeight.bold),
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
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orange,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
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
                          "Save Changes",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
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
