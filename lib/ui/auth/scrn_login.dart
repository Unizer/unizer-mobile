import 'package:Unizer/packages.dart';

import 'package:Unizer/ui/auth/scrn_register.dart';

class LoginScreen extends StatefulWidget {
  static const String screenID = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class FormFields {
  FormFields({this.email, this.password});
  String email;
  String password;
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _formFields = FormFields();
  bool _showSpinner = false;
  bool _hidePassword = true;

  String emailAddress = '';
  String languageCode;
  String languageLabel = kLanguageLabels['en'];

  final _textEditingController = TextEditingController();

  Future getEmail() async {
    final String savedEmail = await LocalPrefs().getUserEmail();
    if (savedEmail != null && savedEmail != 'null') {
      print('Email found in preferences: $savedEmail');
      setState(() {
        _textEditingController.text = savedEmail;
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

  Future<bool> _actionLogin() async {
    _formKey.currentState.save(); //Saves all textfield content
    final _isValid =
        _formKey.currentState.validate(); //Check if any field has no validation
    if (!_isValid) {
      return false;
    }
    final _auth =
        FirebaseAuth.instance; //intialise Firebase authentication object
    try {
      final _currentUser = await _auth.signInWithEmailAndPassword(
          email: _formFields.email, password: _formFields.password);
      if (_currentUser != null) {
        LocalPrefs.writeUserEmail(email: _formFields.email);
        UniToast.showToast(
          message: AppLocalizations.of(context)
              .tr('msg_user-login-succes-as', args: [_formFields.email]),
        );
      }
    } on PlatformException catch (e) {
      String _errorCode = e.code;
      if (_errorCode.isNotEmpty) {
        UniToast.showToast(
          message: Localizer.getFirebaseErrorMessage(
              error: _errorCode, context: context),
        );
      }
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    //Clear field focus
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //Set username field
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Write device specs
    //LocalPrefs.writeDeviceSpecs(context);
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
                    Text(
                      ' | ',
                      style: kFooterText,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .tr('lbl_appversion', args: ['$kAppVersion']),
                      style: kFooterText,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _showSpinner,
          child: Container(
            decoration: kBoxScreenDecoration,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 30.0,
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    runSpacing: kCardVerticalSpace,
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          'images/unizer-250x85.png',
                        ),
                        width: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: kCardMargins,
                        ),
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
                        child: Form(
                          key: _formKey,
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
                              TextFormField(
                                controller: _textEditingController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                focusNode: _emailFocus,
                                style: kDefaultTextField,
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: AppLocalizations.of(context)
                                      .tr('lbl_insert-email'),
                                ),
                                autovalidate: false,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .tr('msg_required-field', args: [
                                      AppLocalizations.of(context)
                                          .tr('lbl_email')
                                          .toLowerCase()
                                    ]);
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordFocus);
                                },
                                onSaved: (value) {
                                  _formFields.email = value;
                                },
                              ),
                              SizedBox(
                                height: kTextFieldVerticalSpace,
                              ),
                              TextFormField(
                                obscureText: _hidePassword,
                                focusNode: _passwordFocus,
                                textInputAction: TextInputAction.done,
                                style: kDefaultTextField,
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: AppLocalizations.of(context)
                                      .tr('lbl_insert-password'),
                                  suffixIcon: IconButton(
                                      icon: Icon(_hidePassword
                                          ? Icons.visibility_off
                                          : Icons.visibility),
                                      color: UniColors.hintText,
                                      iconSize: kTextFormFieldIconSize,
                                      onPressed: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      }),
                                ),
                                autovalidate: false,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return AppLocalizations.of(context)
                                        .tr('msg_required-field', args: [
                                      AppLocalizations.of(context)
                                          .tr('lbl_password')
                                          .toLowerCase()
                                    ]);
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _formFields.password = value;
                                },
                              ),
                              RoundedButton(
                                color: UniColors.buttonGreen,
                                label: AppLocalizations.of(context)
                                    .tr('lbl_login'),
                                onPressed: () {
                                  setState(() {
                                    _showSpinner = true;
                                  });
                                  _actionLogin();
                                  setState(() {
                                    _showSpinner = false;
                                  });
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
      ),
    );
  }
}
