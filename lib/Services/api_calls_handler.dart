import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Constants/pref.dart';

class ApiCallHandler {
  var client = http.Client();

  final String appBaseUrl = "https://stacked.com.ng/api/";

  Future<http.Response?>? getRequest({
    required String endPoint,
    Map<String, String>? data,
    bool includeToken = false,
  }) async {
    String url = "$appBaseUrl$endPoint";
    final String? token = CacheHandler.fetchItem(itemName: "token");

    ///Constructing the header data
    Map<String, String> headerData = {
      'Content-type': 'application/json',
    };
    if (includeToken) {
      headerData.addAll({'Authorization': 'Bearer $token'});
    }
    log(":before getRequest Call:::: token::: $token :::: endpoint :: $url :: payload:: $data");

    ///
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: headerData,
      );
      log("getRequest => token::::$token ::$url: ${response.statusCode} ::: body: ${response.body}");
      return response;
    } catch (exception) {
      log("from the error port ::: ${await Future.error(exception.toString())}");
      return null;
    }
    log("from the error port i run oh");
  }

  ///
  Future<http.Response?>? postRequest({
    required String endPoint,
    Map<String, dynamic>? body,
    bool includeToken = false,
  }) async {
    String url = "$appBaseUrl$endPoint";
    final String? token = CacheHandler.fetchItem(itemName: "token");

    ///Constructing the header data
    String? jsonData = body != null ? json.encode(body) : null;
    Map<String, String> headerData = {
      'Content-type': 'application/json',
    };
    if (includeToken) {
      headerData.addAll({'authorization': 'Bearer $token'});
    }
    log(":before postRequest Call:::: token::: $token :::: endpoint :: $url ::: data ::$jsonData");

    ///
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonData,
        headers: headerData,
      );
      log("postRequest => token::::$token ::$url: ${response.statusCode} ::: body: ${response.body}");
      return response;
    } catch (exception) {
      log("from the catch room for $url ::: ${await Future.error(exception.toString())}");
      return null;
    }
  }
}
