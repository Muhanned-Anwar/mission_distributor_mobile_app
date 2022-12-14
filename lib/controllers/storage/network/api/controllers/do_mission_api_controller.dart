import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mission_distributor/controllers/storage/local/prefs/user_preference_controller.dart';
import 'package:mission_distributor/core/utils/helpers.dart';
import 'package:mission_distributor/models/missions/do_mission.dart';
import '../../../../../models/authorization_header.dart';
import '../api_settings.dart';
import 'package:http/http.dart' as http;

typedef ImageUploadResponse = void Function({
  required bool status,
  DoMission? doMission,
  required String message,
});

class DoMissionApiController with Helpers {
  String token = UserPreferenceController().token;

  Future<List<DoMission>> getDoMissions() async {
    var url = Uri.parse(ApiSettings.getDoMissionURL);

    var response = await http.get(url);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print('Success Do Missions');
      var dataJsonArray = jsonDecode(response.body)['data'] as List;
      return dataJsonArray.map((e) => DoMission.fromJson(e)).toList();
    }
    print('Failed DpMissions');
    return [];
  }

  Future<bool> storeDoMission(
      {required int missionId, required BuildContext context}) async {
    var url = Uri.parse(ApiSettings.storeDoMissionURL);

    var response = await http.post(url, body: {
      'user_id': UserPreferenceController().userInformation.id,
      'mission_id': missionId.toString(),
      'date': DateTime.now().toString(),
    });
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      print('Success store Missions');
      showSnackBar(context: context, message: 'Mission completed successfully');

      return true;
      // var dataJsonArray = jsonDecode(response.body)['data'] as List;
      // return dataJsonArray.map((e) => DoMission.fromJson(e)).toList();
    } else {
      showSnackBar(context: context, message: 'Mission completed Failed!');
      print('Failed store DoMissions');
      return false;
    }
    // return [];
  }

  Future<void> store({
    required String filePath,
    required ImageUploadResponse imageUploadResponse,
    required DoMission doMission,
  }) async {
    var url = Uri.parse(ApiSettings.storeDoMissionURL);
    var request = http.MultipartRequest('POST', url);
    var file = await http.MultipartFile.fromPath('screen_shot', filePath);
    request.files.add(file);
    request.headers[HttpHeaders.authorizationHeader] =
        AuthorizationHeader(token: token).token;
    request.fields['date'] = doMission.date.toString();
    request.fields['mission_id'] = doMission.missionId;
    // request.fields['name'] = ''; //This if you need send another data to api

    var response = await request.send();

    response.stream.transform(utf8.decoder).listen((String event) {
      if (response.statusCode == 201 || response.statusCode == 200) {
        var jsonResponse = jsonDecode(event);
        DoMission doMission = DoMission.fromJson(jsonResponse['data']);
        imageUploadResponse(
          status: true,
          doMission: doMission,
          message: jsonResponse['message'],
        );
      } else {
        imageUploadResponse(
          status: false,
          message: 'Something went wrong!, try again',
        );
      }
    });
  }
}
