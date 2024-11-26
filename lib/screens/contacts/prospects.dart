import 'package:flutter/material.dart';
import 'package:northstar_app/screens/contacts/add_contact_screen.dart';
import 'package:northstar_app/utils/app_colors.dart';

class Propects extends StatelessWidget {
  const Propects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Row(
          children: [
            const Spacer(),
            _buildActionButton(context),
          ],
        )
      ],
    );
  }

  GestureDetector _buildActionButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => AddContactScreen()),
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primaryColor,
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
