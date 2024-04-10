import 'package:shared_preferences/shared_preferences.dart';

class CacheHandler {
  static SharedPreferences? pref;

  CacheHandler() {
    init();
  }

 static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static storeItem({required String itemName, required String value}) {
    pref!.setString( itemName, value);
  }

 static String? fetchItem({required String itemName}) {
    return pref!.getString(itemName);
  }



  // static saveToken(String token) {
  //   pref!.setString('TOKEN', token);
  // }

  // static String? getToken() {
  //   return pref!.getString('TOKEN');
  // }


}
