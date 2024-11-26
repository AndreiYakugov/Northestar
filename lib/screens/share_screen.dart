import 'package:flutter/material.dart';

class ShareScreen extends StatelessWidget {
  const ShareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Share'),
        ),
        body: Container(
          color: Colors.white,
          child: const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.folder),
                Text(
                  'No Data',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        ));
  }
}
