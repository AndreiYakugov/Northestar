import 'package:flutter/material.dart';

class SideMenuHeader extends StatefulWidget {
  final String userFullName, username, useruuid;
  const SideMenuHeader({
    super.key,
    required this.userFullName,
    required this.username,
    required this.useruuid
  });

  @override
  State<SideMenuHeader> createState() => _SideMenuHeaderState();
}

class _SideMenuHeaderState extends State<SideMenuHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.black87,
      child: Stack(
        children: [
          Positioned(
            left: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(radius: 30),
                const SizedBox(height: 16),
                Text(
                  widget.userFullName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  '${widget.username} | ${widget.useruuid}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
