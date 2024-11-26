import 'package:flutter/material.dart';
import 'package:northstar_app/Models/video.dart';
import 'package:northstar_app/utils/app_contstants.dart';
import '../ApiPackage/ApiClient.dart';
import '../utils/SharedPrefUtils.dart';
import '../utils/helper_methods.dart';
import 'pdf_screen.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {

  List<Video> video_list = [];

  @override
  void initState() {
    super.initState();

    _handleResources();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = size.height / 4;
    final double itemWidth = size.width / 3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resources'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: GridView.count(
          childAspectRatio: (itemWidth / itemHeight),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(15),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 3,
          children: List.generate(video_list.length, (index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        PDFScreen(title: video_list[index].video_title,
                          file: video_list[index].video_video)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Material(
                      child: Image.network(
                        video_list[index].video_thumbnail,
                        fit: BoxFit.fill,
                        height: 100,
                        width: itemWidth,
                      ),
                    ),
                    Text(video_list[index].video_title),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
  Future<dynamic> _handleResources() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().resource(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"]["data"];
      for(var element in tmpdata) {
        Video vd = Video(video_title: element["title"], video_description: element["description"],
            video_thumbnail: element["thumbnail"], video_video: element["file"],
            video_type: element["type_string"]);
        setState(() {
          video_list.add(vd);
        });
      }
      return video_list;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
