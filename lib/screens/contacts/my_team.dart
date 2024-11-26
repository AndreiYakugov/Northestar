import 'package:flutter/material.dart';
import 'package:northstar_app/Models/contact.dart';
import 'package:northstar_app/screens/contacts/contact_detail_screen.dart';
import 'package:northstar_app/utils/app_colors.dart';

import '../../ApiPackage/ApiClient.dart';

class MyTeam extends StatefulWidget {
  final List<Contact> contacts;
  const MyTeam({super.key, required this.contacts});

  @override
  State<MyTeam> createState() => _MyTeamState();
}

class _MyTeamState extends State<MyTeam> {

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (_, index) => GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ContactDetailScreen(
                        contact: widget.contacts[index],
                      ))),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
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
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.contacts[index].name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              widget.contacts[index].phone,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.contacts[index].email,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
        itemCount: widget.contacts.length);
  }
}
