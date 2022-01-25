import 'package:sytiamo/data/model/responseModel/customer_search_response.dart';
import 'package:sytiamo/data/model/responseModel/loan_product_response.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/data/model/responseModel/simple_response.dart';
import 'package:sytiamo/data/model/responseModel/ticket_response.dart';
import 'package:sytiamo/utils/route_api.dart';

import '../http.dart';

class SettingRepo {
  ServerData _serverData = ServerData();

  Future<CustomerResponse> searchUserByMarketID(Map map) async {
    var responseData = await _serverData.postData(null,
        path: Routes.userByMarketID, body: map);
    print(responseData.data);
    return CustomerResponse.fromJson(responseData.data);
  }

  Future<CustomerResponse> customer(String name) async {
    var responseData =
        await _serverData.getData(null, path: Routes.getCustomer(name));
    print(responseData.data);
    return CustomerResponse.fromJson(responseData.data);
  }

  Future<LoanProduct> getLoanProduct() async {
    var responseData =
        await _serverData.getData(null, path: Routes.loanProduct);
    print(responseData.data);

    return LoanProduct.fromJson(responseData.data);
  }

  Future<LocationResponse> getLocation() async {
    var responseData = await _serverData.getData(null, path: Routes.location);
    print(responseData.data);

    return LocationResponse.fromJson(responseData.data);
  }

  Future<SimpleResponse> smsMessage(Map map) async {
    var responseData =
        await _serverData.postData(null, body: map, path: Routes.smsRoute);
    print(responseData.data);

    return SimpleResponse.fromJson(responseData.data);
  }

  Future<TicketResponse> summitTicket(Map map) async {
    var responseData =
        await _serverData.postData(null, body: map, path: Routes.ticket);
    print(responseData.data);

    return TicketResponse.fromJson(responseData.data);
  }
}
