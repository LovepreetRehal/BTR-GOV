import 'dart:async';
import 'dart:convert';
import 'package:btr_gov/retrofit/utils.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final int timeoutInSeconds = 15;
  Map<String, String> _mainHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final String appBaseUrl = Utils.baseURL;
  static final String noInternetMessage =
      'Connection to API server failed due to internet connection';

  Future<http.Response> getData(String uri, bool header, dynamic bdy) async {
    http.Response _response;
    try {
      if (header) {
        await updateHeader();
      }
      final URI;
      if (bdy.toString().isEmpty) {
        URI = Uri.https(appBaseUrl, uri);
      } else {
        URI = Uri.https(appBaseUrl, uri, bdy);
      }

      print('====> API Call:' + URI.toString());

      _response = await http
          .get(URI, headers: _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));
      print(_response.body);
    } catch (e) {
      print("catech" + e.toString());
      final res = {
        "message": e.toString(),
      };
      _response = http.Response(jsonEncode(res), 400);
    }
    return _response;
  }


  Future<http.Response> homeCategoryFilter(String uri, Map<String, String> queryParams, bool header) async {
    http.Response _response;

    try {
      if (header) {
        await updateHeader(); // Make sure this function is defined elsewhere to update headers if needed.
      }

      Uri URI = Uri.https(appBaseUrl, uri, queryParams);

      print('====> API Call: ' + URI.toString());

      _response = await http
          .get(URI, headers: _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));

      print(_response.body);
    } catch (e) {
      print("Error: " + e.toString());
      final res = {
        "message": e.toString(),
      };
      _response = http.Response(jsonEncode(res), 400);
    }

    return _response;
  }



  Future<http.Response> deleteData(String uri, bool header) async {
    http.Response _response;
    try {
      if (header) {
        await updateHeader();
      }

      Uri URI;
      URI = Uri.https(appBaseUrl, uri);

      // if (bdy.toString().isEmpty) {
      //   URI = Uri.https(appBaseUrl, uri);
      // } else {
      //   URI = Uri.https(appBaseUrl, uri, bdy);
      // }

      print('====> API Call:' + URI.toString());

      _response = await http
          .post(URI, headers: _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));
      print(_response.body);
    } catch (e) {
      print("catch: " + e.toString());
      final res = {
        "message": e.toString(),
      };
      _response = http.Response(jsonEncode(res), 400);
    }
    return _response;
  }



  Future<http.Response> postData(
    String uri,
    dynamic body,
  ) async {
    http.Response _response;
    try {
      await updateHeader();
      print('body -- > ' + jsonEncode(body).toString());

      final URI = Uri.https(appBaseUrl, uri);
      // final uri=Uri.parse(appBaseUrl + uri);
      print("login-----" + URI.toString());
      //   print("Header-----"+_mainHeaders.toString());

      final b1 = jsonEncode(body);
      _response = await http
          .post(URI, body: b1, headers: _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));

      print(_response.body);
    } catch (e) {
      print(e.toString());
      final res = {
        "message": noInternetMessage + e.toString(),
      };
      _response = http.Response(jsonEncode(res), 400);
    }
    return _response;
  }

  Future<http.Response> postMultipartData(
    String uri,
    Map<String, String> body,
    List<MultipartBody> multipartBody,
  ) async {
    http.Response _response;
    try {
      await updateHeader();

      final URI = Uri.https(appBaseUrl, uri);
      print('====> API Body: $URI with ${multipartBody.length} files');

      http.MultipartRequest _request = http.MultipartRequest('POST', URI);

      if (multipartBody.length > 0) {
        for (MultipartBody multipart in multipartBody) {
          Uint8List _list = await multipart.file.readAsBytes();
          _request.files.add(http.MultipartFile(
            multipart.key,
            multipart.file.readAsBytes().asStream(),
            _list.length,
            filename: '${multipart.file.name.toString()}.png',
          ));
        }
      }

      _request.fields.addAll(body);
      _request.headers.addAll(_mainHeaders);
      _response = await http.Response.fromStream(await _request.send());
      print(_response.body);
    } catch (e) {
      final res = {
        "message": noInternetMessage + e.toString(),
      };
      _response = http.Response(jsonEncode(res), 401);
    }
    return _response;
  }

  //update header
  Future<void> updateHeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token') ?? "";
    print("Tokenr  $token");

    _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
      // 'x-real-ip':"122.176.76.143",
    };
    //print("Token---  " + token.toString());
  }

  Future<http.Response> postData_Second(
    String uri,
    dynamic body,
  ) async {
    http.Response _response;
    try {
      await updateHeader();
      print('body -- > ' + jsonEncode(body).toString());

      final URI = Uri.parse("https://" + appBaseUrl + uri);
      // final uri=Uri.parse(appBaseUrl + uri);
      print("login-----" + URI.toString());
      //   print("Header-----"+_mainHeaders.toString());

      final b1 = jsonEncode(body);
      _response = await http
          .post(URI, body: b1, headers: _mainHeaders)
          .timeout(Duration(seconds: timeoutInSeconds));

      print(_response.body);
    } catch (e) {
      print(e.toString());
      final res = {
        "message": noInternetMessage + e.toString(),
      };
      _response = http.Response(jsonEncode(res), 400);
    }
    return _response;
  }
}







class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}

enum ApiResponse { loading, Done, Nodata, Error }
