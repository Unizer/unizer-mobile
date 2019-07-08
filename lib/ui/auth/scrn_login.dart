import 'package:Unizer/packages.dart';

import 'package:Unizer/ui/auth/scrn_register.dart';

class LoginScreen extends StatefulWidget {
  static const String screenID = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userEmail = '';
  String userPassword;
  String languageCode;
  String languageLabel = kLanguageLabels['en'];

  Future getEmail() async {
    final String savedEmail = await LocalPrefs().getUserEmail();
    if (savedEmail != null && savedEmail != 'null') {
      print('Email found in preferences: $savedEmail');
      setState(() {
        userEmail = savedEmail;
      });
    }
  }

  Future setLocale() async {
    final data = EasyLocalizationProvider.of(context).data;
    final String savedLanguage = await Localizer.getLanguageCode();
    setState(() {
      data.changeLocale(Locale(savedLanguage));
      languageLabel = kLanguageLabels['$savedLanguage'];
    });
  }

  @override
  void initState() {
    super.initState();
    //Set username field
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    //Write device specs
    LocalPrefs.writeDeviceSpecs(context);
    setLocale();

    //Set Locale
    final data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: UniColors.dividerLine,
                  width: 1.0,
                ),
              ),
            ),
            height: kBottomBarHeight,
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).tr('lbl_language') + ':',
                        textAlign: TextAlign.center,
                        style: kLinkText.copyWith(color: UniColors.hintText),
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            final String currentLanguage =
                                Localizer.changeLanguage(context);
                            data.changeLocale(Locale(currentLanguage));
                            languageLabel = kLanguageLabels[currentLanguage];
                          });
                        },
                        child: Text(
                          '$languageLabel ',
                          textAlign: TextAlign.center,
                          style: kLinkText,
                        ),
                      ),
                      Icon(
                        Boxicons.bxChevronDown,
                        color: UniColors.linkText,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Flexible(
                  child: Text(
                    '© $kAppName $kCurrentYear',
                    textAlign: TextAlign.center,
                    style: kFooterText,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Container(
          decoration: kBoxScreenDecoration,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 50.0,
                ),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runSpacing: kCardVerticalSpace,
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/unizer-250x85.png'),
                    ),
                    Center(
                      child: Text(
                        AppLocalizations.of(context).tr('lbl_oneliner'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: kH2TextSize,
                          color: UniColors.h2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kCardMargins,
                        left: kCardMargins,
                        right: kCardMargins,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(kCardMargins),
                        decoration: kCardBox,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).tr('lbl_login'),
                              textAlign: TextAlign.left,
                              style: kH1,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.left,
                              style: kDefaultTextField,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: AppLocalizations.of(context)
                                    .tr('lbl_insert-email'),
                              ),
                              controller: TextEditingController.fromValue(
                                  TextEditingValue(
                                      text: userEmail,
                                      selection: TextSelection.collapsed(
                                          offset: userEmail.length))),
                              onChanged: (value) => userEmail = value,
                            ),
                            SizedBox(
                              height: kTextFieldVerticalSpace,
                            ),
                            TextField(
                              obscureText: true,
                              textAlign: TextAlign.left,
                              style: kDefaultTextField,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: AppLocalizations.of(context)
                                      .tr('lbl_insert-password')),
                              onChanged: (String value) {
                                userPassword = value;
                              },
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                            RoundedButton(
                              color: UniColors.buttonGreen,
                              label:
                                  AppLocalizations.of(context).tr('lbl_login'),
                              onPressed: () {
                                if (userEmail.isNotEmpty) {
                                  LocalPrefs.writeUserEmail(email: userEmail);
                                }
                              },
                            ),
                            SizedBox(
                              height: kLinkTextVerticalSpace,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  AppLocalizations.of(context)
                                      .tr('lbl_forgot-password'),
                                  style: kLinkText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: kCardVerticalSpace,
                        left: kCardMargins,
                        right: kCardMargins,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(kCardMargins),
                        decoration: kCardBox,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).tr('lbl_register'),
                              textAlign: TextAlign.left,
                              style: kH1,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Text(
                              AppLocalizations.of(context)
                                  .tr('msg_no-user-account'),
                              textAlign: TextAlign.left,
                              style: kH2,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RoundedButton(
                              color: UniColors.buttonWormGreen,
                              label: AppLocalizations.of(context)
                                  .tr('lbl_register'),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RegisterScreen.screenID);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
