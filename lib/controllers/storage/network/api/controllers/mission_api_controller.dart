import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mission_distributor/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:mission_distributor/models/missions/mission.dart';
import 'package:mission_distributor/models/missions/missions_count.dart';
import 'package:mission_distributor/models/missions/points.dart';
import '../../../../../models/authorization_header.dart';
import '../api_settings.dart';

class MissionApiController {
  String token = UserPreferenceController().token;
  late double rate = 1.0;

  Future<List<Mission>> getMissions() async {
    var response = await responseApiGetMissions(ApiSettings.missionURL);
    if (response.statusCode == 200) {
      return getJsonDataMissions(response.body);
    }
    return [];
  }

  Future<List<Mission>> getRemainingMissions() async {
    var response =
        await responseApiGetMissions(ApiSettings.remainingMissionURL);
    if (response.statusCode == 200) {
      return getJsonDataMissions(response.body);
    }
    return [];
  }

  Future<List<Mission>> getCompletedMissions() async {
    var response =
        await responseApiGetMissions(ApiSettings.completedMissionURL);
    if (response.statusCode == 200) {
      return getJsonDataMissions(response.body);
    }
    return [];
  }

  Future<http.Response> responseApiGetMissions(String url) async {
    var link = Uri.parse(url);
    return await http.get(link, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
  }

  List<Mission> getJsonDataMissions(String body) {
    var dataJsonArray = jsonDecode(body);
    Map<String, dynamic> jsonMap = dataJsonArray['data'];
    rate = double.parse(jsonMap['group_rate'] ?? '1');
    Map<String, dynamic> jsonMap2 = jsonMap['missions'];
    late Mission mission;
    List<Mission> missions = [];
    for (var item in jsonMap2['data']) {
      mission = Mission.fromJson(item);
      missions.add(mission);
    }
    return missions;
  }

  Future<int> getPoints() async {
    String token = UserPreferenceController().token;
    var url = Uri.parse(ApiSettings.pointsUrl);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      Points points = Points.fromJson(jsonResponse['data']);
      return points.total;
    } else {
      return 0;
    }
  }

  Future<MissionsCount> getMissionsCount() async {
    String token = UserPreferenceController().token;
    var url = Uri.parse(ApiSettings.missionsCountUrl);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      MissionsCount missionsCount =
          MissionsCount.fromJson(jsonResponse['data']);
      return missionsCount;
    } else {
      return MissionsCount();
    }
  }

  Future<String> getMoney() async {
    String token = UserPreferenceController().token;
    var url = Uri.parse(ApiSettings.moneyUrl);

    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: AuthorizationHeader(token: token).token,
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String money =jsonResponse['data'];
      return money;
    } else {
      return '0';
    }
  }

  double getRate() {
    return rate;
  }
}
