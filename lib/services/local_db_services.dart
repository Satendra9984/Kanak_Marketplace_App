import 'package:shared_preferences/shared_preferences.dart';

class LocalDBServices {
  static final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static Future<void> storeGPAccessToken(String token) async {
    await _prefs.then((value) {
      value.setString('gpAccessToken', token);
    });
  }
  static Future<String?> getGPAccessToken() async {
    final pref = await _prefs;
    return pref.getString('gpAccessToken');
  }
  static Future<void> clearGPAccessToken() async {
    final pref = await _prefs;
    pref.remove('gpAccessToken');
  }


  static Future<void> storeGPTokenExpiry(String token) async {
    await _prefs.then((value) {
      value.setString('gpAccessToken', token);
    });
  }
  static Future<String?> getGPTokenExpiry() async {
    final pref = await _prefs;
    return pref.getString('gpTokenExoiry');
  }
  static Future<void> clearGPTokenExpiry() async {
    final pref = await _prefs;
    pref.remove('gpAccessToken');
  }

  
  static Future<void> storeGPMerchantId(String token) async {
    await _prefs.then((value) {
      value.setString('gpAccessToken', token);
    });
  }
  static Future<String?> getGPMerchantId() async {
    final pref = await _prefs;
    return pref.getString('gpMerchantId');
  }
  static Future<void> clearGPMerchantId() async {
    final pref = await _prefs;
    pref.remove('gpAccessToken');
  }
  
}