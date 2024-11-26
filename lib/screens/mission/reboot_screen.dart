import 'package:flutter/material.dart';
import 'package:northstar_app/Models/missionscontent.dart';
import 'package:northstar_app/Models/missionslist.dart';
import 'package:northstar_app/components/warning_dialog.dart';
import 'package:northstar_app/screens/mission/widgets/mission_dialog.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../ApiPackage/ApiClient.dart';
import '../../utils/SharedPrefUtils.dart';
import '../../utils/helper_methods.dart';

class RebootScreen extends StatefulWidget {
  const RebootScreen({super.key});

  @override
  State<RebootScreen> createState() => _RebootScreenState();
}

class _RebootScreenState extends State<RebootScreen> {
  MissionsList selectedMission = MissionsList(id: 0, title: "");
  MissionsContent missionsContent = MissionsContent(mission_content: "", mission_updated: "", mission_cnt: 0, missionHistoryModels: []);
  int total_days = 0, total_missions = 0;
  String type = "1";
  TextEditingController descriptionController = TextEditingController();
  List<MissionsList> missonsList = [];

  @override
  void initState() {
    super.initState();
    _handleMissionsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Reboot"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              // Row of Buttons (Create, Edit, Reset, Delete)
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _createMission,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const Text(
                        "CREATE",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _editMission,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const Text(
                        "EDIT",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: _resetMission,
                      child: const Text(
                        "RESET",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      onPressed: _deleteMission,
                      child: const Text(
                        "DELETE",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Select Mission Dropdown
              const Text(
                "Select Mission",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButton<MissionsList>(
                  isExpanded: true,
                  iconSize: 40,
                  iconEnabledColor: Colors.black,
                  underline: const SizedBox(),
                  value: selectedMission,
                  onChanged: (MissionsList? newValue) {
                    setState(() {
                      selectedMission = newValue!;
                      var selectedIndex = missonsList.indexOf(selectedMission);
                      _handleMissionsContent(missonsList[selectedIndex].id);
                    });
                  },
                  items: missonsList.map((MissionsList value) {
                    return new DropdownMenuItem<MissionsList>(
                      value: value,
                      child: Text(
                        value.title,
                        // style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Description TextField
              const Text(
                "Description",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: descriptionController,
                maxLines: 6,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  hintText: 'Enter description',
                ),
                style: TextStyle(
                    color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 12),

              // Progress Indicator
              const Text(
                "Progress",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 24),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.width / 1.8,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: SleekCircularSlider(
                        min: 0,
                        max: total_missions.toDouble(),
                        initialValue: total_days.toDouble(),
                        appearance: CircularSliderAppearance(
                            startAngle: 270,
                            angleRange: 360,
                            customWidths: CustomSliderWidths(
                              trackWidth: 3,
                              progressBarWidth: 4,
                              handlerSize: 10,
                            ),
                            customColors: CustomSliderColors(
                                trackColor: Colors.white,
                                progressBarColor: AppColors.primaryColor,
                                dotColor: AppColors.primaryColor)),
                        innerWidget: (v) => Center(
                          child: Text(
                            "$total_days / $total_missions",
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Center(
                child: Text(
                  "Day $total_days",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: const Text(
                        "COMPLETE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      child: const Text(
                        "INCOMPLETE",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Button Functions
  void _createMission() {
    showDialog(context: context, builder: (c) => MissionDialog(flag: 1, type: type, missionId: ""));
  }

  void _editMission() {
    showDialog(context: context, builder: (c) => MissionDialog(flag: 2, type: type, missionId: selectedMission.id.toString()));
  }

  void _resetMission() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) => WarningDialog(
            warningText: "Reset",
            onCancel: () {
              Navigator.of(context).pop();
            },
            onConfirm: _handleMissionsReset
        ));
  }

  void _deleteMission() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) => WarningDialog(
            warningText: "Delete",
            onCancel: () {
              Navigator.of(context).pop();
            },
            onConfirm: _handleMissionsDelete,
        ));
  }

  Future<dynamic> _handleMissionsList() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().missionsList(ustoken, type);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"];
      setState(() {
        for(var element in tmpdata) {
          MissionsList ml = MissionsList(id: element["id"], title: element["title"]);
          missonsList.add(ml);
        }
        selectedMission = missonsList[0];
        _handleMissionsContent(selectedMission.id);
      });
      return missonsList;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
  Future<dynamic> _handleMissionsContent(int index) async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().missionsContent(ustoken, index.toString(), type);
    Navigator.pop(context);

    if (res["success"]) {
      var tmpdata = res["data"];
      setState(() {
        missionsContent.mission_content = tmpdata["content"];
        missionsContent.mission_updated = tmpdata["updated_at"];
        missionsContent.mission_cnt = tmpdata["completed_cnt"];
        for(var element in tmpdata["histories"]) {
          missionsContent.missionHistoryModels.add(
              MissionHistory(history_updated: element["updated_at"],
                  history_id: element["id"], history_cnt: element["completed_cnt"],
                  history_mission_id: element["mission_id"]));
        }
        descriptionController.text = missionsContent.mission_content;
        total_days = missionsContent.missionHistoryModels.isEmpty ? 1 : missionsContent.missionHistoryModels.length;
        total_missions = missionsContent.mission_cnt;
      });
      return missionsContent;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
  Future<void> _handleMissionsReset() async {
      String ustoken = await SharedPrefUtils.readPrefStr("token");
      showLoadingDialog(context);
      dynamic res = await ApiClient().missionsReset(ustoken, selectedMission.id.toString());
      Navigator.pop(context);

      if (res["success"]) {
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res["message"]}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
  }
  Future<void> _handleMissionsDelete() async {
    String ustoken = await SharedPrefUtils.readPrefStr("token");
    showLoadingDialog(context);
    dynamic res = await ApiClient().missionsDelete(ustoken, selectedMission.id.toString());
    Navigator.pop(context);

    if (res["success"]) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: ${res["message"]}'),
        backgroundColor: Colors.red.shade300,
      ));
    }
  }
}
