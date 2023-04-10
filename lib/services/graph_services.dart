import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tasvat/services/rest_services.dart';

class GraphServices {
  static const String _baseUrl = 'https://metals-api.com/api/';
  static const String _apiKey =
      '8bsfli0vmr8za0m8bxhp6a1jzo3t20xtk566xtoc4eodkq7ug3h3996puls4';

  static Future<Map<String, dynamic>?> get1WeekData() async {
    DateTime tod = DateTime.now().subtract(const Duration(days: 2));
    String tody = DateFormat('yyyy-MM-dd').format(tod);

    DateTime weekBefore = tod.subtract(const Duration(days: 7));
    String weekBef = DateFormat('yyyy-MM-dd').format(weekBefore);
    debugPrint('startDate: $weekBef, enddate: $tody');
    await HttpServices.sendGetReq(
            '${_baseUrl}carat?access_key=$_apiKey&base=USD&symbols=INR&start_date=$weekBef&end_date=$tody')
        .then((weekData) {
      debugPrint(weekData.toString());
      if (weekData == null ||
          (weekData.containsKey('data') &&
              weekData['data']['success'] == false)) {
        return null;
      }

      Map<String, dynamic> res = weekData['rates'];
      // debugPrint(res.toString());
      for (String key in res.keys) {
        debugPrint('$key: ${res[key]}');
      }
      return res;
    });
    return null;
  }

  static Future<Map<String, dynamic>?> get1YearData() async {
    DateTime tod = DateTime.now().subtract(const Duration(days: 1));
    DateTime weekBefore = tod.subtract(const Duration(days: 365));
    String tody = DateFormat('yyyy-MM-dd').format(tod);
    String weekBef = DateFormat('yyyy-MM-dd').format(weekBefore);
    debugPrint('startDate: $weekBef, enddate: $weekBef');
    await HttpServices.sendGetReq(
            '${_baseUrl}timeseries?access_key=$_apiKey&base=USD&symbols=INR&start_date=$weekBef&end_date=$tody')
        .then((weekData) {
      if (weekData == null) {
        return null;
      }
      Map<String, dynamic> res = weekData['rates'];
      for (String key in res.keys) {
        debugPrint('$key: ${res[key]}');
      }
      return res;
    });
    return null;
  }
}
