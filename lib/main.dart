import 'package:Unizer/packages.dart';
import 'package:Unizer/ui/auth/scrn_login.dart';
import 'package:Unizer/ui/auth/scrn_register.dart';
import 'package:Unizer/ui/home/scrn_home.dart';

Future main() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString('appLanguage') ?? 'nl';
  print('Found language: $languageCode');
  runApp(EasyLocalization(child: Unizer(languageCode: languageCode)));
}

/// This Widget is the main application widget.
class Unizer extends StatelessWidget {
  Unizer({this.languageCode});
  final String languageCode;

  @override
  Widget build(BuildContext context) {
    final data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //app-specific localization
          EasylocaLizationDelegate(
              locale: Locale(languageCode) ?? Locale('nl', 'NL'),
              path: 'assets/i18n'),
        ],
        supportedLocales: kLocaleLanguages,
        locale: data.locale,
        theme: ThemeData(
            fontFamily: kGlobalFontFamily,
            inputDecorationTheme: InputDecorationTheme()),
        initialRoute: LoginScreen.screenID,
        routes: <String, WidgetBuilder>{
          LoginScreen.screenID: (BuildContext context) => LoginScreen(),
          RegisterScreen.screenID: (BuildContext context) => RegisterScreen(),
          HomeScreen.screenID: (BuildContext context) => HomeScreen(),
        },
      ),
    );
  }
}
