import 'package:Unizer/connector.dart';

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

  static String getFirebaseErrorMessage({BuildContext context, String error}) {
    String _errorCode = error;
    String _message =
        AppLocalizations.of(context).tr('fireb_err_error-unknown');
    if (_errorCode.isNotEmpty) {
      String _i18nKey = 'fireb_err_' +
          _errorCode.toLowerCase().replaceAll('_', '-'); //Parse i18n key
      _message = AppLocalizations.of(context).tr(_i18nKey);
    }
    return _message;
  }
}
