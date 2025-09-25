import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager{
  static late SharedPreferences preferences ;

  static Future<void> init ()async{
    preferences = await SharedPreferences.getInstance();
  }


}