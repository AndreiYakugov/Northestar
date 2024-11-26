import 'package:flutter/material.dart';
import 'package:northstar_app/utils/app_colors.dart';

class WarningDialog extends StatelessWidget {
  final String warningText;
  final Function() onCancel;
  final Function() onConfirm;
  const WarningDialog({
    super.key,
    required this.warningText,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                "Are you sure you want to $warningText?",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: onCancel,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        child: const Text(
                          "Cancel",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: onConfirm,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            border: Border.all(
                                color: AppColors.primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                        ),
                        child: const Text(
                          "Yes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
