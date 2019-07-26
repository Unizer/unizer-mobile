import 'package:Unizer/packages.dart';

class ResetPWScreen extends StatefulWidget {
  static const String screenID = 'reset-password';

  @override
  _ResetPWScreenState createState() => _ResetPWScreenState();
}

class ResetFormFields {
  ResetFormFields({this.email});
  String email;
}

class _ResetPWScreenState extends State<ResetPWScreen> {
  final _formKey = GlobalKey<FormState>();
  var _formFields = ResetFormFields();
  bool _showSpinner = false;
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    //Clear field focus
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //Set username field
    getEmail();
    super.initState();
  }

  Future getEmail() async {
    final String savedEmail = await LocalPrefs().getUserEmail();
    if (savedEmail != null && savedEmail != 'null') {
      print('Email found in preferences: $savedEmail');
      setState(() {
        _textEditingController.text = savedEmail;
      });
    }
  }

  Future<void> _resetPassword() async {
    final _isValid =
        _formKey.currentState.validate(); //Check if any field has no validation
    if (!_isValid) {
      return false;
    }

    String _email = _textEditingController.text;

    print('Reset password initiated with $_email');
    //Todo: Check if email exists

    //Send reset email
    var _auth = FirebaseAuth.instance;
    await _auth.sendPasswordResetEmail(email: _email);

    //Show dialog and navigate back to loginscreen
    UniToast.showToast(
      message:
          AppLocalizations.of(context).tr('msg_reset-password-email-upcoming'),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: UniColors.black,
        ),
        title: Text(
          AppLocalizations.of(context).tr('lbl_reset-password'),
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
                        AppLocalizations.of(context).tr('msg_reset-password'),
                        style: kH2,
                        textAlign: TextAlign.center,
                      ),
                      screenID: ResetPWScreen.screenID,
                      cardHeight: 150.0,
                    ),
                  ),
                  UniCard(
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
                          //Email
                          TextFormField(
                            style: kDefaultTextField,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: AppLocalizations.of(context)
                                    .tr('lbl_email'),
                                errorStyle: kErrorValidationText),
                            textInputAction: TextInputAction.go,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            autovalidate: false,
                            controller: _textEditingController,
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
                            onFieldSubmitted: (value) {
                              _formFields.email = value;
                            },
                            onSaved: (value) {
                              _formFields.email = value;
                            },
                          ),
                          SizedBox(
                            height: kTextFieldVerticalSpace,
                          ),

                          RoundedButton(
                            color: UniColors.buttonGreen,
                            label: AppLocalizations.of(context)
                                .tr('btn_reset-password'),
                            onPressed: () async {
                              setState(() {
                                _showSpinner = true;
                              });
                              _resetPassword();
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
