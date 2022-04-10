import 'package:sytiamo/data/model/responseModel/notification_response.dart';
import 'package:sytiamo/utils/route_api.dart';

import '../http.dart';

class NotificationRepo {
  ServerData _serverData = ServerData();
  Future<NotificationResponse> getMessage(Map map) async {
    var responseData = await _serverData.postData(null,
        body: map, path: Routes.notificationURL);
    print(responseData.data);

    return NotificationResponse.fromJson(responseData.data);
  }

  Future<NotificationResponse> upDateMessage(Map map) async {
    var responseData = await _serverData.postData(null,
        body: map, path: Routes.notificationUpdate);
    print(responseData.data);

    return NotificationResponse.fromJson(responseData.data);
  }
}
