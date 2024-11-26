import 'package:flutter/material.dart';
import 'package:northstar_app/utils/gaps.dart';

class ContactDetailDialog extends StatefulWidget {
  const ContactDetailDialog({super.key});

  @override
  State<ContactDetailDialog> createState() => _ContactDetailDialogState();
}

class _ContactDetailDialogState extends State<ContactDetailDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      backgroundColor: Colors.white,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                18.ph,
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey,
                ),
                12.ph,
                const Text(
                  "Steven Chan",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                8.ph,
                const Text(
                  "7733",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                // 8.ph,
                const Divider(
                  thickness: 12,
                  color: Colors.grey,
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "PV:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Paid Rank:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Affiliate",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Current Rank:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Affiliate",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Affiliate:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Preffered:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Retail:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Affiliate",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Autoships:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Personally Enrolled:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "Affiliate",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Gv:",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "0",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      8.ph,
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
