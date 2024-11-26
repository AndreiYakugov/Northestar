import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:northstar_app/screens/team_chat/view_members_screen.dart';

import 'package:northstar_app/utils/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [
    {
      'user': 'John',
      'text': 'Hello!',
      'timestamp': DateTime.now().subtract(const Duration(minutes: 5)),
      'isMe': false
    },
    {
      'user': 'Me',
      'text': 'Hi there!',
      'timestamp': DateTime.now(),
      'isMe': true
    },
  ];
  final TextEditingController _controller = TextEditingController();
  final ImagePicker picker = ImagePicker();
  XFile? image;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({
          'user': 'Me',
          'text': _controller.text,
          'timestamp': DateTime.now(),
          'isMe': true,
        });
        _controller.clear(); // Clear the input field after sending
      });
    }
  }

  void _openMedia() async {
    image = await picker.pickImage(source: ImageSource.gallery);
  }

  // Function to format the date
  String _formatDate(DateTime date) {
    return DateFormat('MMMM d').format(date); // e.g., September 19
  }

  // Function to format the time
  String _formatTime(DateTime time) {
    return DateFormat('HH:mm').format(time); // e.g., 12:30 PM
  }

  // Function to group messages by date
  Map<String, List<Map<String, dynamic>>> _groupMessagesByDate(
      List<Map<String, dynamic>> messages) {
    Map<String, List<Map<String, dynamic>>> groupedMessages = {};
    for (var message in messages) {
      String formattedDate = _formatDate(message['timestamp']);
      if (groupedMessages[formattedDate] == null) {
        groupedMessages[formattedDate] = [];
      }
      groupedMessages[formattedDate]!.add(message);
    }
    return groupedMessages;
  }

  @override
  Widget build(BuildContext context) {
    var groupedMessages = _groupMessagesByDate(messages);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Team Chat",
        ),
        actions: [
          PopupMenuButton<String>(
            color: AppColors.backgroundColor,
            padding: EdgeInsets.zero,
            onSelected: (value) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ViewMembersScreen()));
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'Item 1',
                  child: Text(
                    'View Members',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Display messages in a ListView
          Expanded(
            child: ListView.builder(
              reverse: true, // To keep the most recent message at the bottom
              itemCount: groupedMessages.keys.length,
              itemBuilder: (context, index) {
                String date = groupedMessages.keys
                    .elementAt(groupedMessages.keys.length - 1 - index);
                List<Map<String, dynamic>> dailyMessages =
                    groupedMessages[date]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date heading
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Text(
                          date,
                          style: TextStyle(
                              fontSize: 16, color: AppColors.hintColor),
                        ),
                      ),
                    ),
                    for (var message in dailyMessages)
                      Align(
                        alignment: message['isMe']
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: message['isMe']
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if (!message['isMe'])
                                CircleAvatar(
                                  child: Text(message['user'][0]),
                                ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: message['isMe']
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (!message['isMe'])
                                    Text(
                                      message['user'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.hintColor,
                                      ),
                                    ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if (message[
                                          'isMe']) // Time on the left when isMe is true
                                        Text(
                                          _formatTime(message['timestamp']),
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      const SizedBox(width: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 12),
                                        decoration: BoxDecoration(
                                          color: message['isMe']
                                              ? Colors.deepPurple
                                              : Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          message['text'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: message['isMe']
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      if (!message[
                                          'isMe']) // Time on the right when isMe is false
                                        Text(
                                          _formatTime(message['timestamp']),
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),

          // Input field to send messages
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.add_box_outlined,
                    size: 35,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: _openMedia,
                ),
                // Text field to type the message
                Expanded(
                  child: TextField(
                    controller: _controller,
                    cursorColor: Colors.grey,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter message',
                      filled: true,
                      fillColor: AppColors.txtFldFillClr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                    ),
                  ),
                ),
                // Send button
                IconButton(
                  icon: Icon(
                    Icons.send_rounded,
                    size: 35,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: _sendMessage, // Send the message
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
