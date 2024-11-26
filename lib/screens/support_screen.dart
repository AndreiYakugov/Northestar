import 'package:flutter/material.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.headset_mic,
              size: 100,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Customer Support",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              "Customer Phone Support:",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "+1 (844) 904-3872 | Monday - Firday, 9AM - 5PM",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 16),
            Text(
              "Support@NorthStar.com",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
