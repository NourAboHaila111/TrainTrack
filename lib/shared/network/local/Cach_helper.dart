// import 'package:shared_preferences/shared_preferences.dart';
//
// class CachHelper
// {
//   static late SharedPreferences sharedPreferences;
//   static init()async
//   {
//     sharedPreferences=await SharedPreferences.getInstance();
//   }
//   static Future<bool> putData({
//     required String key,
//     required bool value,
//   })async
//   {
//     return await sharedPreferences.setBool(key, value);
//   }
//
//   static dynamic getData({
//     required String ? key,
//   })
//   {
//     return sharedPreferences.get(key!);
//   }
//
//
//   static Future<bool>SaveData(
//       {
//         required dynamic ?key,
//         required dynamic ?value,
//       })async
//   {
//     if(value is String)return await sharedPreferences.setString(key!, value);
//     if(value is int)return await sharedPreferences.setInt(key!, value);
//     if(value is bool)return await sharedPreferences.setBool(key!, value);
//     return await sharedPreferences.setDouble(key!, value);
//   }
//
//   static Future<bool> RemoveData(
//       {
//         required String key,
//
//       })async
//   {
//     return await sharedPreferences.remove(key);
//   }
//   static Future<bool> clear()async
//   {
//     return await sharedPreferences.clear();
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> SaveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return false;
  }

  static dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }
}
