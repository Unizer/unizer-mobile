import 'package:Unizer/packages.dart';

Future main() async {
  runApp(
    EasyLocalization(
      child: Unizer(),
    ),
  );
}

/// This Widget is the main application widget.
class Unizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          //app-specific localization
          EasylocaLizationDelegate(
              locale: data.locale ?? Locale('nl', 'NL'), path: 'assets/i18n'),
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
          ResetPWScreen.screenID: (BuildContext context) => ResetPWScreen(),
          UnizerScreen.screenID: (BuildContext context) => UnizerScreen(),
        },
      ),
    );
  }
}
