import 'package:flutter/material.dart';
import 'package:northstar_app/Models/chat_member.dart';
import 'package:northstar_app/utils/app_colors.dart';

class MemberInfoScreen extends StatefulWidget {
  final ChatMember member;
  const MemberInfoScreen({super.key, required this.member});

  @override
  State<MemberInfoScreen> createState() => _MemberInfoScreenState();
}

class _MemberInfoScreenState extends State<MemberInfoScreen> {
  bool isBlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info'),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .25,
            color: AppColors.primaryColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.member.name,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                const Text(
                  "Block this member",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const Spacer(),
                Switch(
                    activeColor: Colors.white,
                    value: isBlocked,
                    onChanged: (v) {
                      setState(() {
                        isBlocked = !isBlocked;
                      });
                    })
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Text(
              "When Block this member is enabled, the member will be prohibited from chatting in all channels.",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          )
        ],
      ),
    );
  }
}
