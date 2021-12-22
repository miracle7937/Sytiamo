import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

final String baseUrl = '';

Future<Map> getHeader({bool newDevice = false}) async {
  String token;
  String identifier;

  // await getToken().then((value) => token = value);
  // await getUserIdentifier().then((value) => identifier = value);

  var header = {
    'Authorization': 'Bearer ${token ?? ""}',
    'ch': 'mb',
    'lg': 'en',
    'Content-Type': 'application/json',
  };
  return header;
}

class ServerData {
  String deviceId;

  Future<HttpResponse> getData(
    BuildContext context, {
    String path,
  }) async {
    var header = await getHeader();

    try {
      var response = await http.get(path, headers: header);
      var data = jsonDecode(response.body);
      print("path: $path");
      print("$data  route: $path");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        return HttpData(data);
      }
    } catch (e) {
      print('exception get $e');
      return HttpException('something wrong happened');
    }
  }

  Future<HttpResponse> postData(BuildContext context,
      {String path, Map body, bool saveXCode = false}) async {
    print(path + body.toString());
    var header = await getHeader();

    try {
      var response =
          await http.post(path, body: json.encode(body), headers: header);
      var data = jsonDecode(response.body);

      print("$data  route: $path");

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (saveXCode) {
          // saveUserIdentifier(response.headers['x-cod']);
          print("${response.headers['x-cod']}popo");
        }
        print(response.headers['x-cod']);
        print("cool$data");

        return HttpData(data);
      } else {
        print("oops");
        print(response.statusCode);

        print(data);
        return HttpData(data);

        // return HttpException({"message": data, "error": true});
      }
    } catch (e) {
      print('exception post $e');
      return HttpException(
          {"message": 'something wrong happened', "error": true});
    }
  }

  Future putData(
    BuildContext context, {
    String path,
    Map body,
  }) async {
    var header = await getHeader();

    try {
      var response =
          await http.put('$baseUrl$path', body: body, headers: header);
      var data = jsonDecode(response.body);
      print('$baseUrl$path');
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 401) {}
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        print(data);
        return HttpException(data);
      }
    } catch (e) {
      print('exception post $e');
      // return HttpException('something wrong happened');
    }
  }

  Future uploadNoFile(
    BuildContext context, {
    String path,
    Map body,
  }) async {
    final header = await getHeader();
    var postUri = Uri.parse('$baseUrl$path');
    var request = http.MultipartRequest(
      "POST",
      postUri,
    );
    request.headers.addAll(header);

    body.forEach((key, value) {
      // print('$key $value');
      request.fields['$key'] = value.toString();
    });

    var response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());

    print(response);
    if (response.statusCode == 401) {}
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('successful');
      return HttpData(data["data"]);
      // return true;
    } else {
      print('fails');
      return HttpException(null);
    }
  }
  //

  Future uploadFile(BuildContext context,
      {String path, Map body, File file, imageKey}) async {
    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    final header = await getHeader();
    var postUri = Uri.parse('$baseUrl$path');
    var request = http.MultipartRequest(
      "POST",
      postUri,
    );
    request.headers.addAll(header);

    body.forEach((key, value) {
      request.fields['$key'] = value.toString();
    });
    var multipartFileSign = new http.MultipartFile(imageKey, stream, length,
        filename: basename(file.path));
    request.files.add(multipartFileSign);

    var response = await request.send();

    var data = jsonDecode(await response.stream.bytesToString());
    if (response.statusCode == 401) {}

    print(response);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print('successful');
      return HttpData(data["data"]);
      // return true;
    } else {
      print('fails');
      return HttpException(null);
    }
  }

  Future<HttpResponse> deleteData(
    BuildContext context, {
    String path,
  }) async {
    var header = await getHeader();

    try {
      var response = await http.delete(path, headers: header);
      var data = jsonDecode(response.body);
      print("$data  route: $path");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpData(data);
      } else {
        return HttpData(data);
      }
    } catch (e) {
      print('exception get $e');
      return HttpException('something wrong happened');
    }
  }
}

//request  http request

abstract class HttpResponse {
  dynamic data;
}

class HttpException extends HttpResponse {
  final data;

  HttpException(this.data);
}

class HttpData extends HttpResponse {
  final data;

  HttpData(this.data);
}
