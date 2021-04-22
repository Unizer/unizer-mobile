import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

class LoginScreen extends StatefulWidget {
  static const String screenID = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class FormFields {
  FormFields({this.email, this.password});
  String? email;
  String? password;
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
  GlobalKey globalScaffoldKey = GlobalKey<ScaffoldState>();

  Future getEmail() async {
    final String savedEmail = await LocalPrefs().getUserEmail();
    if (savedEmail != 'null') {
      _textEditingController.text = savedEmail;
    }
  }

  Future<bool> _authCheck(BuildContext context) async {
    _formKey.currentState!.save(); //Saves all textfield content
    final _isValid = _formKey.currentState!
        .validate(); //Check if any field has no validation
    if (!_isValid) {
      return false;
    }
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _formFields.email!, password: _formFields.password!);

      if (!userCredential.user!.emailVerified) {
        UniDialog.showSnackBar(
          context: context,
          message: tr('msg_user-login-email-not-verified'),
          action: SnackBarAction(
            label: tr('lbl_resend'),
            onPressed: () async {
              await userCredential.user!.sendEmailVerification();
            },
            textColor: UniColors.white,
          ),
        );
        return false;
      }

      await LocalPrefs.writeUserAccount(
          email: _formFields.email!,
          displayName: userCredential.user!.displayName!);
    } on FirebaseAuthException catch (e) {
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
    setState(() {
      _showSpinner = false;
    });
    if (_loginSucces == true) {
      Navigator.pushNamed(context, HomeScreen.screenID);
    }
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
    String languageCode = 'en';

    return Scaffold(
      key: globalScaffoldKey,
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
                    tr('lbl_language') + ':',
                    textAlign: TextAlign.center,
                    style: kLinkText.copyWith(color: UniColors.hintText),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        final Locale currentLanguage =
                            Localizer.changeLanguage(context);
                        context.setLocale(currentLanguage);
                        //languageLabel = kLanguageLabels[currentLanguage];
                      });
                    },
                    child: Text(
                      tr('lst_languages.$languageCode'),
                      textAlign: TextAlign.center,
                      style: kLinkText,
                    ),
                  ),
                  Icon(
                    BoxIcons.bx_chevron_down,
                    color: UniColors.linkText,
                    size: 20.0,
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
                    tr('lbl_appversion', args: ['$kAppVersion']),
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
                  crossAxisAlignment: WrapCrossAlignment.start,
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
                      padding: EdgeInsets.only(
                        bottom: kCardMargins,
                      ),
                      child: Center(
                        child: Text(
                          tr('lbl_oneliner'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: kH2TextSize,
                            color: UniColors.h2,
                          ),
                        ),
                      ),
                    ),
                    CardWidget(
                      child: Builder(
                        builder: (context) => Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                tr('lbl_login'),
                                textAlign: TextAlign.left,
                                style: kH1,
                              ),
                              SizedBox(
                                height: kH1VerticalSpace,
                              ),
                              TextFormField(
                                autovalidateMode: AutovalidateMode.disabled,
                                controller: _textEditingController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                focusNode: _emailFocus,
                                style: kBodyText,
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: tr('lbl_insert-email'),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return tr('msg_required-field',
                                        args: [tr('lbl_email').toLowerCase()]);
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
                                autovalidateMode: AutovalidateMode.disabled,
                                obscureText: _hidePassword,
                                focusNode: _passwordFocus,
                                textInputAction: TextInputAction.done,
                                style: kBodyText,
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: tr('lbl_insert-password'),
                                  suffixIcon: IconButton(
                                      icon: Icon(_hidePassword
                                          ? BoxIcons.bx_hide
                                          : BoxIcons.bx_show),
                                      color: UniColors.hintText,
                                      iconSize: kTextFormFieldIconSize,
                                      onPressed: () {
                                        setState(() {
                                          _hidePassword = !_hidePassword;
                                        });
                                      }),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return tr('msg_required-field', args: [
                                      tr('lbl_password').toLowerCase()
                                    ]);
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _formFields.password = value;
                                },
                                onFieldSubmitted: (_) => _actionLogin(
                                    globalScaffoldKey.currentContext!),
                              ),
                              RoundedButton(
                                color: UniColors.buttonGreen,
                                label: tr('lbl_login'),
                                onPressed: () {
                                  _actionLogin(
                                      globalScaffoldKey.currentContext!);
                                },
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
                                    tr('lbl_forgot-password'),
                                    style: kLinkText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    CardWidget(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            tr('lbl_register'),
                            textAlign: TextAlign.left,
                            style: kH1,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            tr('msg_no-user-account'),
                            textAlign: TextAlign.left,
                            style: kH2,
                          ),
                          RoundedButton(
                            color: UniColors.buttonWormGreen,
                            topMargin: 15.0,
                            label: tr('lbl_register'),
                            onPressed: () {
                              //TODO: Don't want the user to go back - EVER - emptying completely the navigator stack with: Navigator.pushNamedAndRemoveUntil(context, ## your routename here ##, (_) => false);
                              Navigator.pushNamed(
                                  context, RegisterUserScreen.screenID);
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
