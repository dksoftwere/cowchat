import 'package:cowchat/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{
  Future<void> setName(String  name)async{
    final prefs=await SharedPreferences.getInstance();
    prefs.setString(AppConstant.NAME, name);
  }

  getName() async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString(AppConstant.NAME);
  }
 Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.EMAIL_ADDRESS,email);
  }

  getEmail()async{
   final prefs=await SharedPreferences.getInstance();
   return prefs.getString(AppConstant.EMAIL_ADDRESS);
  }

  Future<void> setImageUrl(String imageUrl)async{
    final prefs= await SharedPreferences.getInstance();
     prefs.setString(AppConstant.IMAGE_URL, imageUrl);
  }

  getImageUrl()async{
    final pref=await SharedPreferences.getInstance();
    return pref.getString(AppConstant.IMAGE_URL);
  }
}