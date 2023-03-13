import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpServices {
  static Future<Map<String, dynamic>?> sendGetReq(String path, {
    Map<String, String>? extraHeaders
  }) async {
    Map<String, dynamic>? result;
    await http.get(
      Uri.parse(path),
      headers: {
        'Content-Type': 'application/json',
        ...?extraHeaders
      }
    ).then((res) {
      if (res.body.isNotEmpty) {
        result = jsonDecode(res.body);
      }
    });
    return result;
  }
  static Future<Map<String, dynamic>?> sendPostReq(String path, {
    Map<String, dynamic>? body,
    Map<String, String>? extraHeaders
  }) async {
    Map<String, dynamic>? result;
    await http.post(
      Uri.parse(path),
      headers: {
        'Content-Type': 'application/json',
        ...?extraHeaders
      },
      body: jsonEncode(body)
    ).then((res) {
      if (res.body.isNotEmpty) {
        result = jsonDecode(res.body);
      }
    });
    return result;
  }
}