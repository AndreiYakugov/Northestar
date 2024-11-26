import 'package:flutter/material.dart';

import '../ApiPackage/ApiClient.dart';
import '../Models/history.dart';
import '../utils/SharedPrefUtils.dart';
import '../utils/helper_methods.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  List<History> histories = [];

  @override
  void initState() {
    super.initState();

    _handleHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ListView.builder(
          itemCount: histories.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            histories[index].title,
                            softWrap: true,
                            maxLines: 2,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                      Flexible(
                        child: Text(
                          histories[index].content,
                          softWrap: true,
                          maxLines: 5,
                          textAlign: TextAlign.justify,
                          style:
                            TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          "Via: ${histories[index].way}",
                          style:
                          TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          "To: ${histories[index].info}",
                          style:
                          TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Time:",
                          style:
                          TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        Spacer(),
                        Text(
                          histories[index].created,
                          style:
                          TextStyle(color: Colors.grey, fontSize: 14),
                        )
                      ],
                    ),
                  ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> _handleHistory() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().history(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"]["data"];
      setState(() {
        List<History> tmphis = [];
        for(var element in tmpdata) {
          History ht = History(info: element["share_info"], way: element["share_way"],
              title: element["title"], content: element["content"], created: "${element["created_at"].substring(5, 10)} ${element["created_at"].substring(11, 16)}");
          tmphis.add(ht);
        }
        for(var i = tmphis.length - 1; i >= 0; i --) {
          histories.add(tmphis[i]);
        }
      });
      return histories;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
