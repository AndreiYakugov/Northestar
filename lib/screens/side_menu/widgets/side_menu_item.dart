import 'package:flutter/material.dart';

class SideMenuListItem extends StatelessWidget {
  final String itemText;
  final IconData itemIcon;
  final Function() onTap;
  const SideMenuListItem({
    required this.itemText,
    required this.itemIcon,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity(horizontal: 0, vertical: -2),
      // dense: true,
      // contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),
      leading: Icon(
        itemIcon,
        color: Colors.white.withOpacity(0.7),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Text(
          itemText,
          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 15),
        ),
      ),
      onTap: onTap,
    );
  }
}
