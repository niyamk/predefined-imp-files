import 'package:shared_preferences/shared_preferences.dart';
import 'package:surat_weavers_new/library.dart';
class SharedPrefService {
  static Future setUser({required username}) async{
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setString('username', username);
  }

  static Future getUsername() async{
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString('username');
  }

  static Future
  logOut() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.remove('username');
  }
  static Future setOtpCheck({required OTP , required currentUsername}) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.setString('${currentUsername}', OTP);
  }

  static Future getOtpCheck({required currentUsername}) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    return sharedPref.getString('${currentUsername}');
  }

/*SharedPreferences sharedPref = SharedPreferences.getInstance() as SharedPreferences;
  Future setUser({required username }) async{
    return sharedPref.setString('username', username);
  }*/

}