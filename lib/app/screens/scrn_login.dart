import 'package:Unizer/connector.dart';

//TODO: Load selected language

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
  final _auth = FirebaseAuth.instance;
  final _textEditingController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _formFields = FormFields();
  bool _showSpinner = false;
  bool _hidePassword = true;

  Future getEmail() async {
    final String savedEmail = await LocalPrefs().getUserEmail();
    if (savedEmail != null && savedEmail != 'null') {
      _textEditingController.text = savedEmail;
    }
  }

  Future<bool> _authCheck(BuildContext context) async {
    _formKey.currentState.save(); //Saves all textfield content
    final _isValid =
        _formKey.currentState.validate(); //Check if any field has no validation
    if (!_isValid) {
      return false;
    }
    try {
      final _authUser = await _auth.signInWithEmailAndPassword(
          email: _formFields.email, password: _formFields.password);
      if (_authUser != null) {
        if (!_authUser.isEmailVerified) {
          UniDialog.showSnackBar(
            context: context,
            message: AppLocalizations.of(context)
                .tr('msg_user-login-email-not-verified'),
            action: SnackBarAction(
              label: AppLocalizations.of(context).tr('lbl_resend'),
              onPressed: () {
                _authUser.sendEmailVerification();
              },
              textColor: UniColors.white,
            ),
          );
          return false;
        }
        LocalPrefs.writeUserAccount(
            email: _formFields.email, displayName: _authUser.displayName);
      }
    } on PlatformException catch (e) {
      String _errorCode = e.code;
      if (_errorCode.isNotEmpty) {
        UniDialog.showSnackBar(
          context: context,
          message: Localizer.getFirebaseErrorMessage(
              error: _errorCode, context: context),
        );
      }
      return false;
    }
    return true;
  }

  void _actionLogin(BuildContext context) async {
    setState(() {
      _showSpinner = true;
    });
    var _loginSucces = await _authCheck(context);
    if (_loginSucces == true) {
      Navigator.pushNamed(context, HomeScreen.screenID);
    }
    setState(() {
      _showSpinner = false;
    });
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
    _auth.signOut();
    getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Set Locale
    final data = EasyLocalizationProvider.of(context).data;
    String languageCode = 'en';
    if (data.savedLocale != null) {
      languageCode = data.savedLocale.languageCode;
    }
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
                          //languageLabel = kLanguageLabels[currentLanguage];
                        });
                      },
                      child: Text(
                        AppLocalizations.of(context)
                            .tr('lst_languages.$languageCode'),
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
            constraints: BoxConstraints.expand(),
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
                      CardWidget(
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
                                style: kBodyText,
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
                                style: kBodyText,
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
                                onFieldSubmitted: (_) => _actionLogin(context),
                              ),
                              Builder(
                                builder: (context) => RoundedButton(
                                  color: UniColors.buttonGreen,
                                  label: AppLocalizations.of(context)
                                      .tr('lbl_login'),
                                  onPressed: () {
                                    _actionLogin(context);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: kLinkTextVerticalSpace,
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, ResetPWScreen.screenID);
                                  },
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
                      CardWidget(
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
                                //TODO: Don't want the user to go back - EVER - emptying completely the navigator stack with: Navigator.pushNamedAndRemoveUntil(context, ## your routename here ##, (_) => false);
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
