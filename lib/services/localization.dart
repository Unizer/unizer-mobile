import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

/*-- Application language property --*/
const String _kLanguageCode = 'appLanguage';

class Localizer {
  /// Method that saves the user language code
  static Future<bool> writeLanguageCode({required String languageCode}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kLanguageCode, languageCode);
  }

  /// Method that returns the user language code, 'en' if not set
  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLanguageCode) ?? 'en';
  }

  static Locale changeLanguage(BuildContext context) {
    Locale currentLanguage = Locale('nl', 'NL');
    if (Localizations.localeOf(context).languageCode == 'nl') {
      currentLanguage = Locale('en', 'US');
    }
    Localizer.writeLanguageCode(languageCode: currentLanguage.languageCode);
    return currentLanguage;
  }

  static String getFirebaseErrorMessage(
      {BuildContext? context, required String error}) {
    String _errorCode = error;
    String _message = tr('fireb_err_error-unknown');
    if (_errorCode.isNotEmpty) {
      String _i18nKey = 'fireb_err_error-' +
          _errorCode.toLowerCase().replaceAll('_', '-'); //Parse i18n key
      _message = tr(_i18nKey);
    }
    return _message;
  }
}
