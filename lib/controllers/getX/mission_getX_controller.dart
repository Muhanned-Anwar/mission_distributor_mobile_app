import 'package:get/get.dart';
import 'package:mission_distributor/controllers/storage/network/api/controllers/mission_api_controller.dart';
import 'package:mission_distributor/models/missions/mission.dart';

import '../../models/missions/missions_count.dart';

class MissionGetXController extends GetxController {
  RxList<Mission> missions = <Mission>[].obs;
  RxList<Mission> remainingMissions = <Mission>[].obs;
  RxList<Mission> completedMissions = <Mission>[].obs;
  RxInt points = 0.obs;
  Rx<MissionsCount> missionsCount = MissionsCount().obs;
  RxString money = '0'.obs;
  RxDouble rate = 1.0.obs;

  final MissionApiController _missionApiController = MissionApiController();

  static MissionGetXController get to => Get.find();

  @override
  void onInit() {
    read();
    super.onInit();
  }

  Future<void> read() async {
    readRemainingMissions();
    readCompletedMissions();
    getPoints();
    getMissionCounts();
    getMoney();
    getRate();
  }

  Future<void> readRemainingMissions() async {
    remainingMissions.value =
        await _missionApiController.getRemainingMissions();
  }

  Future<void> readCompletedMissions() async {
    completedMissions.value =
        await _missionApiController.getCompletedMissions();
  }

  Future<void> getPoints() async {
    points.value = await _missionApiController.getPoints();
  }

  Future<void> getMissionCounts() async {
    missionsCount.value = await _missionApiController.getMissionsCount();
  }

  Future<void> getMoney() async {
    money.value = await _missionApiController.getMoney();
  }

  void getRate() {
    rate.value = _missionApiController.getRate();
  }
}
