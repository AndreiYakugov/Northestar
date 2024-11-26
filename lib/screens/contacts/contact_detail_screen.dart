import 'package:flutter/material.dart';
import 'package:northstar_app/Models/contact.dart';
import 'package:northstar_app/components/app_avatar.dart';

class ContactDetailScreen extends StatefulWidget {
  final Contact contact;
  const ContactDetailScreen({super.key, required this.contact});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Detail"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            const Center(child: AppAvatar(size: 110)),
            const SizedBox(height: 14),
            Text(
              widget.contact.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.contact.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.contact.status,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Email",
                        style: TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      Text(
                        widget.contact.email,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Phone Number",
                        style: TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      Text(
                        widget.contact.phone,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text(
                        "Status",
                        style: TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      Text(
                        widget.contact.status.toString(),
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.contact.email,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        widget.contact.phone,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
