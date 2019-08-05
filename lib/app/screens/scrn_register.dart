import 'package:Unizer/connector.dart';

class RegisterScreen extends StatefulWidget {
  static const String screenID = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class RegisterFormFields {
  RegisterFormFields(
      {this.firstName, this.lastName, this.email, this.password});
  String firstName;
  String lastName;
  String email;
  String password;
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  final _firestore =
      Firestore.instance; //intialise Firestore Cloud authentication object
  var _formFields = RegisterFormFields();
  bool _showSpinner = false;
  String _errorCode = '';
  bool _hidePassword = true;

  @override
  void dispose() {
    //Clear field focus
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<bool> _submitRegistration() async {
    _formKey.currentState.save(); //Saves all textfield content
    final _isValid =
        _formKey.currentState.validate(); //Check if any field has no validation
    if (!_isValid) {
      return false;
    }
    try {
      final _newUser = await _auth.createUserWithEmailAndPassword(
          email: _formFields.email, password: _formFields.password);
      if (_newUser != null) {
        await _newUser.sendEmailVerification();
        String _uid = _newUser.uid; //get user uid
        print('New user created with uid: $_uid');

        //Set displayname
        UserUpdateInfo _info = UserUpdateInfo();
        _info.displayName = _formFields.firstName + ' ' + _formFields.lastName;
        _newUser.updateProfile(_info);

        //Create Unizer record
        _firestore.collection('unizers').add({
          'user_uid': _uid,
          'registration_date': DateTime.now(),
          'email': _formFields.email,
          'firstname': _formFields.firstName,
          'lastname': _formFields.lastName,
          'displayname': _formFields.firstName + ' ' + _formFields.lastName,
        });
        UniDialog.showToast(
          message: AppLocalizations.of(context)
              .tr('msg_user-registered-succes', args: [_formFields.firstName]),
        );

        LocalPrefs.writeUserAccount(
            email: _formFields.email, displayName: _newUser.displayName);

        //Show loginscreen after 5 secs
        Future.delayed(Duration(seconds: 5), () {
          Navigator.popUntil(
              context, ModalRoute.withName(LoginScreen.screenID));
        });
      }
    } on PlatformException catch (e) {
      _errorCode = e.code;
      if (_errorCode.isNotEmpty) {
        UniDialog.showToast(
          message: Localizer.getFirebaseErrorMessage(
              error: _errorCode, context: context),
        );
      }
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: UniColors.black,
        ),
        title: Text(
          AppLocalizations.of(context).tr('lbl_register'),
          style: kTopMenubarTitle,
        ),
        backgroundColor: UniColors.appBarBackground,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: Container(
          decoration: kBoxScreenDecoration,
          constraints: BoxConstraints.expand(),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: kCardMargins,
                      right: kCardMargins,
                    ),
                    child: UniInfoBox(
                      widgetContent: Text(
                        AppLocalizations.of(context).tr('msg_register-info'),
                        style: kH2,
                        textAlign: TextAlign.center,
                      ),
                      screenID: RegisterScreen.screenID,
                    ),
                  ),
                  CardWidget(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)
                                .tr('lbl_keep-connected'),
                            style: kH1,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: kH1VerticalSpace,
                          ),
                          //Firstname
                          TextFormField(
                            style: kBodyText,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: AppLocalizations.of(context)
                                    .tr('lbl_first-name'),
                                errorStyle: kErrorValidationText),
                            textInputAction: TextInputAction.next,
                            focusNode: _firstNameFocus,
                            autofocus: true,
                            autovalidate: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .tr('msg_required-field', args: [
                                  AppLocalizations.of(context)
                                      .tr('lbl_first-name')
                                      .toLowerCase()
                                ]);
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_lastNameFocus);
                            },
                            onSaved: (value) {
                              _formFields.firstName = value;
                            },
                          ),
                          SizedBox(
                            height: kTextFieldVerticalSpace,
                          ),
                          //Lastname
                          TextFormField(
                            style: kBodyText,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: AppLocalizations.of(context)
                                    .tr('lbl_last-name'),
                                errorStyle: kErrorValidationText),
                            textInputAction: TextInputAction.next,
                            focusNode: _lastNameFocus,
                            autovalidate: false,
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .tr('msg_required-field', args: [
                                  AppLocalizations.of(context)
                                      .tr('lbl_last-name')
                                      .toLowerCase()
                                ]);
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_emailFocus);
                            },
                            onSaved: (value) {
                              _formFields.lastName = value;
                            },
                          ),
                          SizedBox(
                            height: kTextFieldVerticalSpace,
                          ),
                          //Email
                          TextFormField(
                            style: kBodyText,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: AppLocalizations.of(context)
                                    .tr('lbl_email'),
                                errorStyle: kErrorValidationText),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFocus,
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
                            style: kBodyText,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: AppLocalizations.of(context)
                                    .tr('lbl_password'),
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
                                errorStyle: kErrorValidationText),
                            textInputAction: TextInputAction.done,
                            focusNode: _passwordFocus,
                            obscureText: _hidePassword,
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
                            label:
                                AppLocalizations.of(context).tr('lbl_confirm'),
                            onPressed: () async {
                              setState(() {
                                _showSpinner = true;
                              });
                              _submitRegistration();
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
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context).tr('lbl_cancel'),
                                style: kLinkText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
