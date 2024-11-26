import 'package:flutter/material.dart';
import 'package:northstar_app/utils/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isNext;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Function? suffixIconOnPress;
  final bool? hideText;
  final bool? enabled;
  final bool isText;
  const AppTextField({
    required this.controller,
    required this.hintText,
    required this.isNext,
    this.suffixIcon,
    this.prefix,
    this.suffixIconOnPress,
    this.hideText,
    this.enabled,
    this.isText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled ?? true,
      keyboardType: isText ? TextInputType.text : null,
      textInputAction: isNext ? TextInputAction.next : TextInputAction.done,
      cursorColor: Colors.white.withOpacity(0.7),
      obscureText: hideText ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.txtFldFillClr,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefix,
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Input correctly';
        }
        return null;
      },
    );
  }
}
