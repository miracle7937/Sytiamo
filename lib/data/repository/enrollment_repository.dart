import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:sytiamo/data/http.dart';
import 'package:sytiamo/data/model/setModel/enrollment_model.dart';
import 'package:sytiamo/utils/route_api.dart';

import '../model/responseModel/all_bank_response.dart';
import '../model/responseModel/bank_verification_response.dart';
import '../model/responseModel/generic_response.dart';

class EnrollmentRepo {
  Future<AllBanksResponse> getBanks() async {
    var responseData = await ServerData().getData(null, path: Routes.getBanks);
    print(responseData.data);
    return AllBanksResponse.fromJson(responseData.data);
  }

  static Future<AccountVerificationResponse> verifyBankAccount(
      Map<String, dynamic> map) async {
    var response = await ServerData()
        .postData(null, path: Routes.verifyAccount, body: map);
    return AccountVerificationResponse.fromJson(response.data);
  }

  static Future<GenericResponse> updateBankAccount(
      Map<String, dynamic> map) async {
    var response =
        await ServerData().postData(null, path: Routes.updateBank, body: map);
    return GenericResponse.fromJson(response.data);
  }

  Future createCustomer(EnrollmentModel enrollmentModel) async {
    try {
      var postUri = Uri.parse(Routes.userAPI);
      http.MultipartRequest request =
          new http.MultipartRequest("POST", postUri);
      if (enrollmentModel.profilePicture != null) {
        var stream = new http.ByteStream(
            DelegatingStream.typed(enrollmentModel.profilePicture.openRead()));
        // get file length
        var length = await enrollmentModel.profilePicture.length();

        var multipartFileSign = new http.MultipartFile(
            'profile_picture', stream, length,
            filename: basename(enrollmentModel.profilePicture.path));
        request.files.add(multipartFileSign);
      }

      //==============================>

      if (enrollmentModel.gpicture != null) {
        var stream2 = new http.ByteStream(
            DelegatingStream.typed(enrollmentModel.gpicture.openRead()));
        // get file length
        var length2 = await enrollmentModel.gpicture.length();

        var multipartFileSign2 = new http.MultipartFile(
            'gpicture', stream2, length2,
            filename: basename(enrollmentModel.gpicture.path));
        request.files.add(multipartFileSign2);
      }

      request.fields['id'] = enrollmentModel.id ?? "";
      request.fields['first_name'] = enrollmentModel.firstName ?? "";
      request.fields['middle_name'] = enrollmentModel.middleName ?? "";
      request.fields['last_name'] = enrollmentModel.lastName ?? "";
      request.fields['email'] = enrollmentModel.email ?? "";
      request.fields['phone'] = enrollmentModel.phone ?? "";
      request.fields['bvn'] = enrollmentModel.bvn ?? "";
      request.fields['address'] = enrollmentModel.address ?? "";
      request.fields['shop_address'] = enrollmentModel.shopAddress ?? "";
      request.fields['dob'] = enrollmentModel.dob ?? "";
      request.fields['gender'] = enrollmentModel.gender ?? "";
      request.fields['user_type'] = enrollmentModel.userType ?? "";
      request.fields['role_id'] = enrollmentModel.roleId ?? "";
      request.fields['branch_id'] = enrollmentModel.branchId ?? "";
      request.fields['status'] = enrollmentModel.status ?? "";
      request.fields['gname'] = enrollmentModel.gname ?? "";
      request.fields['gphone'] = enrollmentModel.gphone ?? "";
      request.fields['gaddress'] = enrollmentModel.gaddress ?? "";
      request.fields['gname2'] = enrollmentModel.gname2 ?? "";
      request.fields['gphone2'] = enrollmentModel.gphone2 ?? "";
      request.fields['gaddress2'] = enrollmentModel.gaddress2 ?? "";
      request.fields['account_no'] = enrollmentModel.accountNo ?? "";
      request.fields['hbus_stop'] = enrollmentModel.houseBusStop ?? "";
      request.fields['sbus_stop'] = enrollmentModel.shopBusStop ?? "";
      request.fields['gbus_stop'] = enrollmentModel.guarantorBusStop1 ?? "";
      request.fields['g2bus_stop'] = enrollmentModel.guarantorBusStop2 ?? "";
      //bank verification
      request.fields['account_number'] = enrollmentModel.accountNumber ?? "";
      request.fields['acc_name'] = enrollmentModel.accName ?? "";
      request.fields['bank_code'] = enrollmentModel.bankName ?? "";

      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      var data = await Response.fromStream(response);
      print(data.body);

      return json.decode(data.body);
    } catch (e) {
      if (e is TimeoutException) {
        throw HttpException({"message": e.message, "error": true});
      }
      if (e is SocketException) {
        throw HttpException(
            {"message": "Network not available", "error": true});
      }
      throw HttpException(
          {"message": 'something wrong happened', "error": true});
    }
  }
}
