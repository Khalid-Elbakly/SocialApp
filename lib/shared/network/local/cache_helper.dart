import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences? sharedPrefrences;

   static init() async {
    sharedPrefrences = await SharedPreferences.getInstance();
  }

  static setData({required String key, required dynamic value}){
     if(value is int)
       sharedPrefrences!.setInt(key, value);
     else if(value is String)
       sharedPrefrences!.setString(key, value);
     else if(value is bool)
       sharedPrefrences!.setBool(key, value);
     else
       sharedPrefrences!.setDouble(key, value);
  }

  static getData({required String key}){
     return sharedPrefrences!.get(key);
  }

  static removeData({required String key}){
     sharedPrefrences!.remove(key);
  }
}