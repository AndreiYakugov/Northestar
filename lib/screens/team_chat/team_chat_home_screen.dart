import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:northstar_app/screens/team_chat/chat_screen.dart';
import 'package:northstar_app/screens/team_chat/create_chat_screen.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:northstar_app/utils/app_contstants.dart';

class TeamChatHomeScreen extends StatefulWidget {
  const TeamChatHomeScreen({super.key});

  @override
  State<TeamChatHomeScreen> createState() => _TeamChatHomeScreenState();
}

class _TeamChatHomeScreenState extends State<TeamChatHomeScreen> {
  // Example data for the chat list
  final List<Map<String, String>> chatList = [
    {
      'name': 'Development Team',
      'lastMessage': 'Let’s finalize the project today.',
      'date': '2024-09-12',
    },
    {
      'name': 'Marketing Team',
      'lastMessage': 'Please review the campaign results.',
      'date': '2024-08-05',
    },
    {
      'name': 'Design Team',
      'lastMessage': 'The new designs are uploaded.',
      'date': '2024-07-22',
    },
    {
      'name': 'Design Team',
      'lastMessage': 'The new designs are uploaded.',
      'date': '2024-07-22',
    },
  ];

  // Function to format the date in "MMM d" format
  String formatDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    return DateFormat('MMMM d').format(date); // e.g., September 12
  }

  // Simulate fetching new data on refresh
  Future<void> _refreshChatList() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simulate a network call delay

    setState(() {
      // Add new chat data to simulate a refresh
      chatList.add({
        'name': 'New Team',
        'lastMessage': 'This is a newly added chat!',
        'date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(teamChatTxt),
        shadowColor: Colors.black12,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CreateChatScreen()));
        },
        mini: true,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshChatList, // Refresh function
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            height: .5,
            color: Colors.black12,
          ),
          itemCount: chatList.length,
          itemBuilder: (context, index) {
            var chat = chatList[index];

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: AppColors.txtFldFillClr,
                    child: Text(
                      chat['name']![0],
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  chat['name']!,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  chat['lastMessage']!,
                  style: const TextStyle(color: Colors.grey),
                ),
                trailing: Text(
                  formatDate(chat['date']!),
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChatScreen())),
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  "Channel options",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () async {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Leave Channel",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Turn push notification OFF",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
