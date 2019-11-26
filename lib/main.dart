import 'package:Unizer/connector.dart';

main() => runApp(
      EasyLocalization(
        child: Unizer(),
      ),
    );

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
          RegisterUserScreen.screenID: (BuildContext context) =>
              RegisterUserScreen(),
          HomeScreen.screenID: (BuildContext context) => HomeScreen(),
          ResetPWScreen.screenID: (BuildContext context) => ResetPWScreen(),
          UnizerScreen.screenID: (BuildContext context) => UnizerScreen(),
          AboutScreen.screenID: (BuildContext context) => AboutScreen(),
          OrganisationListScreen.screenID: (BuildContext context) =>
              OrganisationListScreen(),
          RegisterOrgScreen.screenID: (BuildContext context) =>
              RegisterOrgScreen(),
        },
      ),
    );
  }
}
