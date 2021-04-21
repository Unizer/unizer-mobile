import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en', 'US'), Locale('nl', 'NL')],
      path: 'assets/i18n',
      saveLocale: true,
      child: Unizer(),
    ),
  );
}

/// This Widget is the main application widget.
class Unizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: kLocaleLanguages,
      locale: context.locale,
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
    );
  }
}
