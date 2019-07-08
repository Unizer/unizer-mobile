import 'package:Unizer/packages.dart';

/*-- Application language property --*/
const String _kLanguageCode = 'appLanguage';

class Localizer {
  /// Method that saves the user language code
  static Future<bool> writeLanguageCode({@required String languageCode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kLanguageCode, languageCode);
  }

  /// Method that returns the user language code, 'en' if not set
  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLanguageCode) ?? 'en';
  }

  static String changeLanguage(BuildContext context) {
    String currentLanguage = 'nl';
    if (Localizations.localeOf(context).languageCode == 'nl') {
      currentLanguage = 'en';
    }
    Localizer.writeLanguageCode(languageCode: currentLanguage);
    return currentLanguage;
  }
}
