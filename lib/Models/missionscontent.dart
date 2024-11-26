class MissionsContent {
  String mission_content;
  String mission_updated;
  int mission_cnt;
  final List<MissionHistory> missionHistoryModels;

  MissionsContent({required this.mission_content, required this.mission_updated, required this.mission_cnt, required this.missionHistoryModels});
}

class MissionHistory {
  final String history_updated;
  final int history_id;
  final int history_cnt;
  final int history_mission_id;

  MissionHistory({required this.history_updated, required this.history_id,
    required this.history_cnt, required this.history_mission_id});
}