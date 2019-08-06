import 'package:Unizer/connector.dart';

class RegisterOrgScreen extends StatefulWidget {
  static const String screenID = 'register_org';

  @override
  _RegisterOrgScreenState createState() => _RegisterOrgScreenState();
}

class RegisterOrgFormFields {
  RegisterOrgFormFields(
      {this.name,
      this.street,
      this.zip,
      this.city,
      this.country,
      this.category,
      this.description});
  String name;
  String street;
  String zip;
  String city;
  String country;
  String category;
  String description;
}

class _RegisterOrgScreenState extends State<RegisterOrgScreen> {
  final _nameFocus = FocusNode();
  final _streetFocus = FocusNode();
  final _zipFocus = FocusNode();
  final _cityFocus = FocusNode();
  final _countryFocus = FocusNode();
  final _categoryFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  var _formFields = RegisterOrgFormFields();
  int _stepIndex = 0;

  @override
  void dispose() {
    _nameFocus.dispose();
    _streetFocus.dispose();
    _zipFocus.dispose();
    _cityFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: UniColors.black,
        ),
        title: Text(
          AppLocalizations.of(context).tr('lbl_register-organization'),
          style: kTopMenubarTitle,
        ),
        backgroundColor: UniColors.appBarBackground,
      ),
      body: Container(
        decoration: kBoxScreenDecoration,
        constraints: BoxConstraints.expand(),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: kCardMargins, right: kCardMargins),
              child: Container(
                padding: EdgeInsets.only(bottom: kCardMargins),
                constraints: BoxConstraints(maxWidth: kCardMaxWidth),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    kBoxScreenShadow,
                  ],
                  color: UniColors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(kDefaultBorderRadius),
                    bottomLeft: Radius.circular(kDefaultBorderRadius),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    Align(
                      child: ProgressLine(
                        totalSteps: 7,
                        stepIndex: _stepIndex,
                      ),
                      alignment: Alignment.topLeft,
                    ),
                    SizedBox(
                      height: kCardMargins,
                    ),
                    Text(
                      AppLocalizations.of(context)
                          .tr('msg_insert-fields-below'),
                      style: kH4,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Divider(
                      height: 0.0,
                      color: UniColors.dividerLine,
                    ),
                    Padding(
                      padding: EdgeInsets.all(kCardMargins),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: _nameFocus,
                            autofocus: true,
                            autovalidate: false,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: AppLocalizations.of(context)
                                    .tr('lbl_organisation-name'),
                                errorStyle: kErrorValidationText),
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .tr('msg_required-field', args: [
                                  AppLocalizations.of(context)
                                      .tr('lbl_organisation-name')
                                      .toLowerCase()
                                ]);
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(_streetFocus);
                              setState(() {
                                _stepIndex = 1;
                              });
                            },
                            onSaved: (value) {
                              _formFields.name = value;
                            },
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: _streetFocus,
                            autovalidate: false,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: AppLocalizations.of(context)
                                    .tr('lbl_street-and-number'),
                                errorStyle: kErrorValidationText),
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .tr('msg_required-field', args: [
                                  AppLocalizations.of(context)
                                      .tr('lbl_street-and-number')
                                      .toLowerCase()
                                ]);
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              setState(() {
                                _stepIndex = 2;
                              });
                              FocusScope.of(context).requestFocus(_zipFocus);
                            },
                            onSaved: (value) {
                              _formFields.street = value;
                            },
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            focusNode: _zipFocus,
                            autovalidate: false,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: AppLocalizations.of(context)
                                    .tr('lbl_zipcode'),
                                errorStyle: kErrorValidationText),
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .tr('msg_required-field', args: [
                                  AppLocalizations.of(context)
                                      .tr('lbl_zipcode')
                                      .toLowerCase()
                                ]);
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              setState(() {
                                _stepIndex = 3;
                              });
                              FocusScope.of(context).requestFocus(_cityFocus);
                            },
                            onSaved: (value) {
                              _formFields.zip = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10.0, left: kCardMargins, right: kCardMargins),
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context).tr('lbl_cancel'),
                                textWidthBasis: TextWidthBasis.parent,
                                style: kLinkText,
                              ),
                            ),
                          ),
                          RoundedButton(
                            color: UniColors.buttonGreen,
                            label:
                                AppLocalizations.of(context).tr('lbl_register'),
                            elevation: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
