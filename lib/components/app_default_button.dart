import 'package:flutter/material.dart';

class AppDefaultButton extends StatelessWidget {
  final Function() onPress;
  final String buttonText;
  const AppDefaultButton({
    super.key,
    required this.onPress,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(buttonText),
    );
  }
}
