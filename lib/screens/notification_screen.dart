import 'package:flutter/material.dart';
import 'package:northstar_app/utils/app_colors.dart';
import '../ApiPackage/ApiClient.dart';
import '../Models/notification.dart';
import '../utils/SharedPrefUtils.dart';
import '../utils/helper_methods.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // Sample notifications data
  List<Notifications> notificationsList = [];

  // Method to toggle expansion of content
  void _toggleExpansion(int index) {
    setState(() {
      notificationsList[index].isExpanded = !notificationsList[index].isExpanded;
    });
  }

  @override
  void initState() {
    super.initState();

    _handleNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        separatorBuilder: (context, index) => Container(
          height: 0.5,
          color: Colors.white,
        ),
        itemCount: notificationsList.length,
        itemBuilder: (context, index) {
          final notification = notificationsList[index];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.subject,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _buildNotificationContent(notification, index),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      formatDate(DateTime.parse(notification.created)),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget to handle notification content with More/Less button
  Widget _buildNotificationContent(
      Notifications notification, int index) {
    final isExpanded = notification.isExpanded;
    final content = notification.content;

    if (isExpanded) {
      return _buildExpandedContent(content, index);
    } else {
      return _buildTruncatedContent(content, index);
    }
  }

  // Builds truncated content with "More" button inline with ellipsis
  Widget _buildTruncatedContent(String content, int index) {
    // Set max characters or lines for truncated content
    const int maxCharacters = 40;

    String truncatedContent = content.length > maxCharacters
        ? '${content.substring(0, maxCharacters)}... '
        : content;

    return RichText(
      text: TextSpan(
        text: truncatedContent,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        children: [
          if (content.length > maxCharacters)
            WidgetSpan(
              child: GestureDetector(
                onTap: () => _toggleExpansion(index),
                child: Text(
                  'More',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Builds the expanded content with the "Less" button at the end
  Widget _buildExpandedContent(String content, int index) {
    return RichText(
      text: TextSpan(
        text: content,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        children: [
          WidgetSpan(
            child: GestureDetector(
              onTap: () => _toggleExpansion(index),
              child: Text(
                ' Less',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _handleNotification() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().notification(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"]["data"];
      setState(() {
        for(var element in tmpdata) {
          Notifications nt = Notifications(subject: element["subject"], content: element["content"],
              created: element["created_at"], isExpanded: false);
          notificationsList.add(nt);
        }
      });
      return notificationsList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }

}
