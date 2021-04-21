/* --Flutter defaults --*/
import 'package:shared_preferences/shared_preferences.dart';

class LocalPrefs {
  Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('userEmail').toString();
  }

  static Future writeInfoBoxSpecs(
      {String? screenID, required bool expanded}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('infobox_$screenID+_expanded', expanded);
  }

  static Future<bool> getInfoBoxSpecs({String? screenID}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('infobox_$screenID+_expanded') ?? true;
  }

  static Future writeUserAccount(
      {String? firstName,
      String? lastName,
      required String email,
      required String displayName}) async {
    // obtain shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // set value
    if (firstName != null) prefs.setString('userFirstname', firstName);
    if (lastName != null) prefs.setString('userLastname', lastName);
    prefs.setString('userEmail', email);
    prefs.setString('userDisplayname', displayName);
  }

  static Future<String> getUserAccountPrefs({Future<String>? tag}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('$tag') ?? '';
  }
}
