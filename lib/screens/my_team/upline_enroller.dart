import 'package:flutter/material.dart';
import 'package:northstar_app/Models/upline.dart';

import '../../ApiPackage/ApiClient.dart';
import '../../utils/SharedPrefUtils.dart';
import '../../utils/app_colors.dart';
import '../../utils/helper_methods.dart';

class UplineEnroller extends StatefulWidget {
  const UplineEnroller({super.key});
  @override
  _UplineEnrollerState createState() => _UplineEnrollerState();
}

class _UplineEnrollerState extends State<UplineEnroller> {

  List<Upline> uplineList = [];
  
  @override
  void initState() {
    super.initState();
    _handleUplineEnroller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upline Enrollers"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: ListView.builder(
          itemCount: uplineList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Text(
                    uplineList[index].type,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: uplineList[index].image == null ?
                        CircleAvatar(
                            backgroundColor: AppColors.txtFldFillClr)
                            :
                        CircleAvatar(
                          backgroundImage: NetworkImage(uplineList[index].image!),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Username:",
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                                Spacer(),
                                Text(
                                  uplineList[index].username,
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Name:",
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                                Spacer(),
                                Text(
                                  uplineList[index].name,
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Email:",
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                                Spacer(),
                                Text(
                                  uplineList[index].email,
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Phone:",
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                ),
                                Spacer(),
                                Text(
                                  uplineList[index].phone,
                                  style:
                                  TextStyle(color: Colors.grey, fontSize: 14),
                                )
                              ],
                            ),
                          ],
                        ),
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
  Future<dynamic> _handleUplineEnroller() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().uplineenrollee(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"];
      setState(() {
        for(var element in tmpdata) {
          Upline ul = Upline(username: element["username"], image: element["image"],
              name: "${element["first_name"]} ${element["last_name"]}", email: element["email"], phone: element["phone"], type: "");
          uplineList.add(ul);
        }
        for(var i = 0; i < uplineList.length; i ++) {
          if(i == 0) {
            uplineList[i].type = "My Enroller";
          } else {
            uplineList[i].type = "${uplineList[i - 1].username}'s Enroller";
          }
        }
      });
      return uplineList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}


