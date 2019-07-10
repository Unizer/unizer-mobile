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
                Row(
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
                SizedBox(
                  height: 4.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      '© $kAppName $kCurrentYear',
                      textAlign: TextAlign.center,
                      style: kFooterText,
                    ),
                    Text(' | ', style: kFooterText,),
                    Text(AppLocalizations.of(context).tr('lbl_appversion', args: ['$kAppVersion']),style: kFooterText,)
                  ],
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
                    Padding(
                        padding: const EdgeInsets.only(bottom: kCardMargins,),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).tr('lbl_oneliner'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: kH2TextSize,
                            color: UniColors.h2,
                          ),
                        ),
                      ),
                    ),
                    UniCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context).tr('lbl_login'),
                            textAlign: TextAlign.left,
                            style: kH1,
                          ),
                          SizedBox(
                            height: kH1VerticalSpace,
                          ),
                          TextField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
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
                          RoundedButton(
                            color: UniColors.buttonGreen,
                            label:
                            AppLocalizations.of(context).tr('lbl_login'),
                            onPressed: () {
                              if (userEmail.isNotEmpty) {
                                LocalPrefs.writeUserEmail(email: userEmail);
                              }
                              UniToast.showToast(message: 'Dit is een hele lange melding met best veel tekst daardoor de Toast wellicht best groot zal zijn');
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
                    UniCard(
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).tr('lbl_register'),
                          textAlign: TextAlign.left,
                          style: kH1,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          AppLocalizations.of(context)
                              .tr('msg_no-user-account'),
                          textAlign: TextAlign.left,
                          style: kH2,
                        ),

                        RoundedButton(
                          color: UniColors.buttonWormGreen,
                          topMargin: 15.0,
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

