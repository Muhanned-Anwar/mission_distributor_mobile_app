class MissionsCount {
  int missionsCount = 0;
  int remainingMissionsCount = 0;
  int completedMissionsCount = 0;


  MissionsCount();

  MissionsCount.fromJson(Map<String, dynamic> json) {
    missionsCount = json['missionsCount'];
    remainingMissionsCount = json['remainingMissionsCount'];
    completedMissionsCount = json['completedMissionsCount'];
  }
}
