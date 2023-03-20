import 'dart:convert';
import 'dart:html';
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
  static Future<Map<String, dynamic>?> sendMultipartRequest(
    String path, {
    Map<String, dynamic>? body,
    required List<Map<String, dynamic>> files
  }) async {
    Map<String, dynamic>? result;
    var req = http.MultipartRequest('POST', Uri.parse(path));
    body?.forEach((key, value) {
      req.fields[key] = value;
    });
    for (var element in files) {
      req.files.add(await http.MultipartFile.fromPath(
        element['name'], element['path']
      ));
    }
    await req.send().then((res) async {
      if (res.statusCode != 200) {
        return;
      }
      final body = await res.stream.bytesToString();
      if (body == '') {
        result = jsonDecode(body);
      }
    });
    return result;
  }
}