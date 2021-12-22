import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';

class Pref {
  static saveUser(Map user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', jsonEncode(user));
  }

  static geUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = json.decode(prefs.getString('userData'));
    // print(data["id"]);
    return data["id"];
  }

  static Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map data = json.decode(prefs.getString('userData'));
    // print(data["id"]);
    return data["first_name"] + " " + data["last_name"];
  }

  static agentLocations(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('agentLocation', jsonEncode(data));
  }

  static Future<List<LocationModel>> getAgentLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<LocationModel> locations =
        ((jsonDecode(prefs.getString("agentLocation")) ?? []) as List)
            .map((e) => LocationModel.fromJson(e))
            .toList();
    return locations;
  }
}
