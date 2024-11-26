import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:northstar_app/utils/app_contstants.dart';

class CreateChatScreen extends StatefulWidget {
  const CreateChatScreen({super.key});

  @override
  State<CreateChatScreen> createState() => _CreateChatScreenState();
}

class _CreateChatScreenState extends State<CreateChatScreen> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(createChannelTxt),
          bottom: TabBar(
            indicatorColor: AppColors.primaryColor,
            dividerColor: Colors.transparent,
            labelColor: AppColors.primaryColor,
            unselectedLabelColor: Colors.white,
            tabs: const [
              Tab(text: 'Private Chat'),
              Tab(text: 'Group Chat'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Username',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const TextField(
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8),
                              hintText: 'Username',
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Selected Users',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Search Users',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          channelNameTxt,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const TextField(
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8),
                              hintText: channelNameTxt,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Channel Image',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey,
                              backgroundImage: image != null
                                  ? Image.file(File(image!.path)).image
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    side: BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 2)),
                                onPressed: () {
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                const Text(
                                                  "Select Action",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                const SizedBox(height: 16),
                                                GestureDetector(
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    image =
                                                        await picker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                    );
                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                    "Select photo from gallery",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                GestureDetector(
                                                  onTap: () async {
                                                    Navigator.of(context).pop();
                                                    image =
                                                        await picker.pickImage(
                                                      source:
                                                          ImageSource.camera,
                                                    );
                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                    "Capture photo from camera",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      color: AppColors.primaryColor,
                                    ),
                                    const SizedBox(width: 4),
                                    const Text(
                                      "SELECT",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          usernameHintTxt,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const TextField(
                            cursorColor: Colors.grey,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(8),
                              hintText: usernameHintTxt,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Selected Users',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Search Users',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 0.0)),
                onPressed: () {},
                child: const Text('CREATE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
