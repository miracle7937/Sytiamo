import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/user_response_model.dart';
import 'package:sytiamo/data/model/setModel/model.dart';
import 'package:sytiamo/utils/route_api.dart';

import '../http.dart';

class AuthRepository {
  ServerData _serverData = ServerData();

  Future<UserAuthResponse> login(AuthModel data) async {
    var responseData = await _serverData.postData(null,
        body: data.toJson(), path: Routes.login);
    print(responseData.data);
    if (responseData.data != null) {
      Pref.agentLocations(responseData.data["locations"]);
      Pref.saveUser(responseData.data["user"]);
    }
    return UserAuthResponse.fromJson(responseData.data);
  }
}
