import 'package:flutter/material.dart';
import 'package:northstar_app/screens/training_videos/video_screen.dart';
import 'package:northstar_app/utils/app_colors.dart';

import '../../ApiPackage/ApiClient.dart';
import '../../Models/video.dart';
import '../../utils/SharedPrefUtils.dart';
import '../../utils/helper_methods.dart';

class TrainingVideosScreen extends StatefulWidget {
  const TrainingVideosScreen({super.key});

  @override
  _TrainingVideosScreenState createState() => _TrainingVideosScreenState();
}

class _TrainingVideosScreenState extends State<TrainingVideosScreen> {
  final List<Video> trainingVideos = [];

  @override
  void initState() {
    super.initState();

    _handleTraining();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training Videos')),
      body: ListView.builder(
        itemCount: trainingVideos.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the video player screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VideoScreen(videoData: trainingVideos[index]),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                padding: EdgeInsets.only(bottom: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(children: [
                        Image.network(
                          trainingVideos[index].video_thumbnail,
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.play_circle_outline,
                              size: 80,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        )
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            trainingVideos[index].video_title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            trainingVideos[index].video_description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Future<dynamic> _handleTraining() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().training(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"];
      for(var element in tmpdata) {
        Video vd = Video(video_title: element["title"], video_description: element["description"],
            video_thumbnail: element["thumbnail"], video_video: element["file"],
            video_type: element["type_string"]);
        setState(() {
          trainingVideos.add(vd);
        });
      }
      return trainingVideos;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
