import 'package:flutter/material.dart';
import 'package:northstar_app/Models/unilevellist.dart';
import 'package:northstar_app/utils/app_colors.dart';

import '../../ApiPackage/ApiClient.dart';
import '../../utils/SharedPrefUtils.dart';
import '../../utils/helper_methods.dart';

class UnilevelTreeListScreen extends StatefulWidget {
  const UnilevelTreeListScreen({super.key});

  @override
  State<UnilevelTreeListScreen> createState() => _UnilevelTreeListScreenState();
}

class _UnilevelTreeListScreenState extends State<UnilevelTreeListScreen> {
  bool detailView = false;
  TextEditingController searchFieldController = TextEditingController();
  List<UnilevelList> unilevelList = [];
  List<UnilevelList> unilevelListOnSearchResult = [];
  String userFullName = "";

  @override
  void initState() {
    super.initState();

    _handleUnilevelList();
    _init();
  }
  Future<void> _init() async {
    var uf = await SharedPrefUtils.readPrefStr("fullname");
    setState(() {
      userFullName = uf;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Unilevel List View")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 16),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      detailView = false;
                    });
                  },
                  child: Text(
                    userFullName,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                detailView
                    ? const Text(
                        "  >  Test test",
                        style: TextStyle(color: Colors.grey),
                      )
                    : Container()
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: (detailView || (searchFieldController.text.isNotEmpty &&
                  unilevelListOnSearchResult.isEmpty))
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        color: Colors.white,
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [Icon(Icons.folder), Text("No Data")],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.separated(
                        separatorBuilder: (_, __) => Container(
                          height: 0.5,
                          color: Colors.white,
                        ),
                        itemCount: searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult.length : unilevelList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                detailView = true;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey,
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult[index].userid : unilevelList[index].userid,
                                        style: TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult[index].name : unilevelList[index].name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          "Preffered",
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Join Date:",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            // Spacer(),
                                            Text(
                                                searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult[index].joindate : unilevelList[index].joindate,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Paid Rank:",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            // Spacer(),
                                            Text(
                                                searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult[index].paidrank : unilevelList[index].paidrank,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "Current Rank:",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 10),
                                              ),
                                            ),
                                            // Spacer(),
                                            Text(
                                              searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult[index].rank : unilevelList[index].rank,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "PV:",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult[index].pv : unilevelList[index].pv,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "GV:",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult[index].gv : unilevelList[index].gv,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 4),
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "QV:",
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    searchFieldController.text.isNotEmpty ? unilevelListOnSearchResult[index].qv : unilevelList[index].qv,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: searchFieldController,
              textInputAction: TextInputAction.done,
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Id/Username",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 8,
                ),
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              onChanged: (value) {
                setState(() {
                  unilevelListOnSearchResult = unilevelList
                      .where((element) =>
                      element.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(4)),
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
  Future<dynamic> _handleUnilevelList() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().unilevellist(ustoken);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"]["childrenData"]["data"];
      for(var element in tmpdata) {
        UnilevelList ul = UnilevelList(userid: element["uuid"], id: element["id"],
            image: element["image"], name: "${element["first_name"]} ${element["last_name"]}",
            type: element["type"], joindate: element["created_at"], rank: element["rank"]["name"],
            pv: element["qualification"]["pv"], gv: element["qualification"]["gv"],
            qv: element["qualification"]["adj_gv"], lastpage: res["data"]["childrenData"]["last_page"],
            paidrank: element["paid_rank"]["name"]);
        setState(() {
          unilevelList.add(ul);
        });
      }
      return unilevelList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
