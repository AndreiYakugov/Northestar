import 'package:flutter/material.dart';
import 'package:northstar_app/Models/chat_member.dart';
import 'package:northstar_app/screens/team_chat/member_info_screen.dart';
import 'package:northstar_app/utils/app_colors.dart';

class ViewMembersScreen extends StatelessWidget {
  ViewMembersScreen({super.key});
  final List<ChatMember> _members = [
    ChatMember(
      imgUrl: '',
      isBlocked: false,
      name: 'Steven Chan',
    ),
    ChatMember(
      imgUrl: '',
      isBlocked: false,
      name: 'David Jack',
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Members"),
      ),
      body: ListView.separated(
          itemBuilder: (_, index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              title: Text(
                _members[index].name,
                style: TextStyle(color: AppColors.hintColor),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) => MemberInfoScreen(member: _members[index]))),
            );
          },
          separatorBuilder: (_, __) => const Divider(
                height: .5,
                color: Colors.black12,
              ),
          itemCount: _members.length),
    );
  }
}
