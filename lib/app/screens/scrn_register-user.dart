import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

class RegisterUserScreen extends StatefulWidget {
  static const String screenID = 'register_user';

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class RegisterUserFormFields {
  RegisterUserFormFields(
      {this.firstName, this.lastName, this.email, this.password});
  String? firstName;
  String? lastName;
  String? email;
  String? password;
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore
      .instance; //intialise Firestore Cloud authentication object
  var _formFields = RegisterUserFormFields();
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
    _formKey.currentState!.save(); //Saves all textfield content
    final _isValid = _formKey.currentState!
        .validate(); //Check if any field has no validation
    if (!_isValid) {
      return false;
    }
    try {
      final _newUser = await _auth.createUserWithEmailAndPassword(
          email: _formFields.email!, password: _formFields.password!);
      await _newUser.user!.sendEmailVerification();
      String _uid = _newUser.user!.uid; //get user uid
      print('New user created with uid: $_uid');

      //Set displayname
      _newUser.user!.updateProfile(
          displayName: _formFields.firstName! + ' ' + _formFields.lastName!);

      //Create Unizer record
      _firestore.collection('unizers').add({
        'user_uid': _uid,
        'created': DateTime.now(),
        'email': _formFields.email,
        'firstname': _formFields.firstName,
        'lastname': _formFields.lastName,
        'displayname': _formFields.firstName! + ' ' + _formFields.lastName!,
      });
      UniDialog.showToast(
        message:
            tr('msg_user-registered-succes', args: [_formFields.firstName!]),
      );

      LocalPrefs.writeUserAccount(
          email: _formFields.email!, displayName: _newUser.user!.displayName!);

      //Show loginscreen after 5 secs
      Future.delayed(Duration(seconds: 5), () {
        Navigator.popUntil(context, ModalRoute.withName(LoginScreen.screenID));
      });
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
          tr('lbl_register'),
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
                  UniInfoBox(
                    screenID: RegisterUserScreen.screenID,
                    child: Text(
                      tr('msg_register-info'),
                      style: kH2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CardWidget(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            tr('lbl_keep-connected'),
                            style: kH1,
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: kH1VerticalSpace,
                          ),
                          //Firstname
                          TextFormField(
                            autovalidateMode: AutovalidateMode.disabled,
                            style: kBodyText,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: tr('lbl_first-name'),
                                errorStyle: kErrorValidationText),
                            textInputAction: TextInputAction.next,
                            focusNode: _firstNameFocus,
                            autofocus: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return tr('msg_required-field',
                                    args: [tr('lbl_first-name').toLowerCase()]);
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
                            autovalidateMode: AutovalidateMode.disabled,
                            style: kBodyText,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: tr('lbl_last-name'),
                                errorStyle: kErrorValidationText),
                            textInputAction: TextInputAction.next,
                            focusNode: _lastNameFocus,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return tr('msg_required-field',
                                    args: [tr('lbl_last-name').toLowerCase()]);
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
                            autovalidateMode: AutovalidateMode.disabled,
                            style: kBodyText,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: tr('lbl_email'),
                                errorStyle: kErrorValidationText),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFocus,
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
                            style: kBodyText,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: tr('lbl_password'),
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return tr('msg_required-field',
                                    args: [tr('lbl_password').toLowerCase()]);
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _formFields.password = value;
                            },
                          ),
                          RoundedButton(
                            color: UniColors.buttonGreen,
                            label: tr('lbl_confirm'),
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
                                tr('lbl_cancel'),
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
