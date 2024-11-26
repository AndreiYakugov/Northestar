import 'package:flutter/material.dart';
import 'package:northstar_app/utils/gaps.dart';

class FilterTexts extends StatelessWidget {
  const FilterTexts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blueGrey),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                width: 20,
                height: 20,
              ),
              6.pw,
              const Text(
                "Affiliate",
                style: TextStyle(color: Colors.orange),
              )
            ],
          ),
          4.ph,
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                width: 20,
                height: 20,
              ),
              6.pw,
              const Text(
                "Preffered",
                style: TextStyle(color: Colors.green),
              )
            ],
          ),
          4.ph,
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                width: 20,
                height: 20,
              ),
              6.pw,
              const Text(
                "Retail",
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
