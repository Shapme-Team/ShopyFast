import 'dart:convert';

import 'package:ShopyFast/data/core/apiConstant.dart';
import 'package:http/http.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path) async {
    // print('final Path : ${ApiConstants.BASE_URL}$path');
    final response =
        await _client.get('${ApiConstants.BASE_URL}$path', headers: {
      'Content-Type': 'application/json',
    }).timeout(Duration(seconds: 20));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      print('response status : ${response.statusCode}');
      return responseBody;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic patch(String path) async {
    final response = await _client.patch('${ApiConstants.BASE_URL}$path');
    if (response.statusCode == 200) {
      return response.body;
    } else
      throw Exception(response.reasonPhrase);
  }

  dynamic put(String path, dynamic body) async {
    var header = {
      'Content-Type': 'application/json',
    };

    final response = await _client.put(
      '${ApiConstants.BASE_URL}$path',
      headers: header,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else
      throw Exception(response.reasonPhrase);
  }

  dynamic post(String path, dynamic body) async {
    var header = {
      'Content-Type': 'application/json',
    };
    print('api call is: ${ApiConstants.BASE_URL}$path');
    final response = await _client.post(
      '${ApiConstants.BASE_URL}$path',
      headers: header,
      body: jsonEncode(body),
    );
    print('response : ${response.body}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else
      throw Exception(response.body);
  }
}
