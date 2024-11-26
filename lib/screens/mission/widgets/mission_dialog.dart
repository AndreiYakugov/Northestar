import 'package:flutter/material.dart';
import 'package:northstar_app/utils/app_colors.dart';

import '../../../ApiPackage/ApiClient.dart';
import '../../../utils/SharedPrefUtils.dart';
import '../../../utils/helper_methods.dart';

class MissionDialog extends StatefulWidget {
  final int flag;
  final String type;
  final String missionId;

  const MissionDialog({
    super.key,
    required this.flag,
    required this.type,
    required this.missionId
  });

  @override
  State<MissionDialog> createState() => _MissionDialogState();
}

class _MissionDialogState extends State<MissionDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mission Details",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      hintText: "Description",
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    maxLines: 10,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: _handleSubmit,
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor,
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      String ustoken = await SharedPrefUtils.readPrefStr("token");
      showLoadingDialog(context);
      dynamic res;
      if(widget.flag == 1) {
        res = await ApiClient().missionsCreate(ustoken, contentController.text,
            titleController.text, widget.type);
      } else if(widget.flag == 2) {
        res = await ApiClient().missionsEdit(ustoken, widget.missionId, contentController.text,
            titleController.text);
      }
      Navigator.pop(context);

      if (res["success"]) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res["message"]}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }
}
