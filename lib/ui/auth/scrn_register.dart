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

  @override
  void dispose() {

    //Clear field focus
    _firstNameFocus.dispose();
    _lastNameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submitRegistration(){
    _formKey.currentState.save(); //Saves all textfield content

    final _isValid = _formKey.currentState.validate(); //Check if any field has no validation
    if(!_isValid){
      return;
    }
    print(_formFields.firstName);
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
      body: ListView(
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
                      onPressed: _submitRegistration,
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
    );
  }
}
