import 'package:flutter/material.dart';
import 'package:northstar_app/utils/app_colors.dart';

class AppAvatar extends StatelessWidget {
  final double size;
  const AppAvatar({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: AppColors.txtFldFillClr,
      ),
    );
  }
}
