import 'package:flutter/material.dart';
import 'package:northstar_app/Models/unileveltree.dart';
import 'package:northstar_app/screens/my_team/widgets/filter_texts.dart';
import 'package:northstar_app/screens/my_team/widgets/tree_view.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:northstar_app/utils/gaps.dart';

import '../../ApiPackage/ApiClient.dart';
import '../../utils/SharedPrefUtils.dart';
import '../../utils/helper_methods.dart';

class UnilevelTreeTreeScreen extends StatefulWidget {
  const UnilevelTreeTreeScreen({super.key});

  @override
  State<UnilevelTreeTreeScreen> createState() => _UnilevelTreeTreeScreenState();
}

class _UnilevelTreeTreeScreenState extends State<UnilevelTreeTreeScreen> {
  double scaleValue = 0.8;
  UnilevelTree unilevelTree = UnilevelTree(user_id: "", user_affilates: "", user_autoships: "", user_preferreds: "",
      user_retails: "", user_firstname: "", user_lastname: "", user_level: "", user_hasChildren: "", user_image: "",
      user_status: "", user_type: "", user_uuid: "", user_username: "", user_rankid: "", user_sponsorid: "", user_gv: "",
      user_pe: "", user_pv: "", user_paidRank: "");

  @override
  void initState() {
    super.initState();

    _handleUnilevelTree();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Unilevel Tree View"),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 16,
              left: 16,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "Search Username...",
                                hintStyle: const TextStyle(
                                    fontSize: 12, color: Colors.grey),
                                fillColor: Colors.grey.shade300,
                                contentPadding: const EdgeInsets.only(left: 6),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        8.pw,
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: const Icon(
                            Icons.search,
                            color: Colors.white,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    8.ph,
                    Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade300,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          child: const Text(
                            "UP 1 LEVEL",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        )),
                        8.pw,
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4))),
                          child: const Text(
                            "Top",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
              )),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            top: 130,
            child: // Main profile and tree structure
                Align(
              alignment: Alignment.center,
              child: TreeViewScreen(
                scaleValue: scaleValue,
              ),
            ),
          ),
          const Positioned(bottom: 16, right: 16, child: FilterTexts()),
          Positioned(
            bottom: 26,
            left: 16,
            child: SizedBox(
                width: MediaQuery.of(context).size.width / 2.6,
                child: Row(
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        if (scaleValue >= 0.8) {
                          setState(() {
                            scaleValue -= 0.2;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        child: const Icon(
                          Icons.zoom_out,
                          color: Colors.black87,
                          size: 25,
                        ),
                      ),
                    )),
                    2.pw,
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        if (scaleValue <= 1.5) {
                          setState(() {
                            scaleValue += 0.2;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: const Icon(
                          Icons.zoom_in,
                          color: Colors.black87,
                          size: 25,
                        ),
                      ),
                    ))
                  ],
                )),
          )
        ],
      ),
    );
  }
  Future<dynamic> _handleUnilevelTree() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().unileveltree(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"];
        UnilevelTree ul = UnilevelTree(user_id: tmpdata["id"], user_affilates: tmpdata["affiliates"],
            user_autoships: tmpdata["autoships"], user_preferreds: tmpdata["preferreds"], user_retails: tmpdata["retails"],
            user_firstname: tmpdata["first_name"], user_lastname: tmpdata["last_name"], user_level: tmpdata["level"],
            user_hasChildren: tmpdata["hasChildren"], user_image: tmpdata["image"], user_status: tmpdata["status"],
            user_type: tmpdata["type"], user_uuid: tmpdata["uuid"], user_username: tmpdata["username"], user_rankid: tmpdata["rank_id"],
            user_sponsorid: tmpdata["sponsor_id"], user_gv: tmpdata["qualification"]["gv"], user_pe: tmpdata["qualification"]["pe"],
            user_pv: tmpdata["qualification"]["pv"], user_paidRank: tmpdata["paid_rank"]["name"]);
        setState(() {
          unilevelTree = ul;
        });
      return unilevelTree;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
