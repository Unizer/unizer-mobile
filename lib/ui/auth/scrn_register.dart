import 'package:Unizer/packages.dart';

class RegisterScreen extends StatefulWidget {
  static const String screenID = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class FormFields {
  FormFields({this.firstName,this.lastName, this.email, this.password });
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
  var _formFields = FormFields();
  bool _showSpinner = false;
  String _errorCode = '';
  String _errorMessage = 'An error occured';
  String _i18nKey;

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
    var _auth = FirebaseAuth.instance; //intialise Firebase authentication object

    final _firestore =
        Firestore.instance; //intialise Firestore Cloud authentication object
    _formKey.currentState.save(); //Saves all textfield content

    final _isValid = _formKey.currentState.validate(); //Check if any field has no validation
    if(!_isValid){
      return false;
    }
    //print(_formFields.firstName);
    try {
      final _newUser = await _auth.createUserWithEmailAndPassword(
          email: _formFields.email, password: _formFields.password);
      if(_newUser != null){
        String _uid = _newUser.uid; //get user uid
        print('New user created with uid: $_uid');

        //Set displayname
        UserUpdateInfo _info = UserUpdateInfo();
        _info.displayName = _formFields.firstName + ' ' + _formFields.lastName;
        _newUser.updateProfile(_info);

        //Create Unizer record
        _firestore.collection('unizers').add({
          'email': _formFields.email,
          'firstname': _formFields.firstName,
          'lastname': _formFields.lastName,
          'user_uid': _uid,
        });
        //TODO: Login and go to homepage?
      }
    } on PlatformException catch(e){
      _errorCode = e.code;
      if(_errorCode.isNotEmpty){
        _i18nKey = 'fireb_err_' + _errorCode.toLowerCase().replaceAll('_', '-');
        _errorMessage = AppLocalizations.of(context).tr(_i18nKey);
      }
      UniToast.showToast(message: _errorMessage);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).tr('lbl_register'),
          style: kTopMenubarTitle,
        ),
        backgroundColor: Colors.white,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _showSpinner,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              decoration: kBoxScreenDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: kCardMargins,
                      right: kCardMargins,
                    ),
                    child: UniInfoBox(
                      label: AppLocalizations.of(context).tr('msg_register-info'),
                      screenID: RegisterScreen.screenID,
                    ),
                  ),
                  UniCard(child:
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(AppLocalizations.of(context)
                            .tr('lbl_keep-connected'),
                          style: kH1,
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: kH1VerticalSpace,),
                        //Firstname
                        TextFormField(
                          style: kDefaultTextField,
                          decoration: kTextFieldDecoration.copyWith(labelText: AppLocalizations.of(context).tr('lbl_first-name'), errorStyle: kErrorValidationText),
                          textInputAction: TextInputAction.next,
                          focusNode: _firstNameFocus,
                          autofocus: true,
                          autovalidate: false,
                          validator: (value){
                            if(value.isEmpty){
                                return AppLocalizations.of(context).tr('msg_required-field', args: [AppLocalizations.of(context).tr('lbl_first-name').toLowerCase()]);
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_lastNameFocus);
                          },
                          onSaved: (value){
                            _formFields.firstName = value;
                          },
                        ),
                        SizedBox(
                          height: kTextFieldVerticalSpace,
                        ),
                        //Lastname
                        TextFormField(
                          style: kDefaultTextField,
                          decoration: kTextFieldDecoration.copyWith(labelText: AppLocalizations.of(context).tr('lbl_last-name'),errorStyle: kErrorValidationText),
                          textInputAction: TextInputAction.next,
                          focusNode: _lastNameFocus,
                          autovalidate: false,
                          validator: (value){
                            if(value.isEmpty){
                              return AppLocalizations.of(context).tr('msg_required-field', args: [AppLocalizations.of(context).tr('lbl_last-name').toLowerCase()]);
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_emailFocus);
                          },
                          onSaved: (value){
                            _formFields.lastName = value;
                          },
                        ),
                        SizedBox(
                          height: kTextFieldVerticalSpace,
                        ),
                        //Email
                        TextFormField(
                          style: kDefaultTextField,
                          decoration: kTextFieldDecoration.copyWith(labelText: AppLocalizations.of(context).tr('lbl_email'),errorStyle: kErrorValidationText),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _emailFocus,
                          autovalidate: false,
                          validator: (value){
                            if(value.isEmpty){
                              return AppLocalizations.of(context).tr('msg_required-field', args: [AppLocalizations.of(context).tr('lbl_email').toLowerCase()]);
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).requestFocus(_passwordFocus);
                          },
                          onSaved: (value){
                            _formFields.email = value;
                          },
                        ),
                        SizedBox(
                          height: kTextFieldVerticalSpace,
                        ),
                        TextFormField(
                          style: kDefaultTextField,
                          decoration: kTextFieldDecoration.copyWith(labelText: AppLocalizations.of(context).tr('lbl_password'),errorStyle: kErrorValidationText),
                          textInputAction: TextInputAction.next,
                          focusNode: _passwordFocus,
                          obscureText: true,
                          autovalidate: false,
                          validator: (value){
                            if(value.isEmpty){
                              return AppLocalizations.of(context).tr('msg_required-field', args: [AppLocalizations.of(context).tr('lbl_password').toLowerCase()]);
                            }
                            return null;
                          },
                          onSaved: (value){
                            _formFields.password = value;
                          },
                        ),
                        RoundedButton(color: UniColors.buttonGreen,
                          label: AppLocalizations.of(context).tr('lbl_confirm'),
                          onPressed: () async {
                              setState(() {
                                _showSpinner = true;
                              });
                              bool _registrationResult = await _submitRegistration();
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
                              AppLocalizations.of(context)
                                  .tr('lbl_cancel'),
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
            ),
          ],
        ),
      ),
    );
  }
}
