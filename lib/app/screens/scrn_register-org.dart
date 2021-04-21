import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

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
  String? name;
  String? street;
  String? zip;
  String? city;
  String? country;
  String? category;
  String? description;
}

class _RegisterOrgScreenState extends State<RegisterOrgScreen> {
  final _nameFocus = FocusNode();
  final _streetFocus = FocusNode();
  final _zipFocus = FocusNode();
  final _cityFocus = FocusNode();

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
          tr('lbl_register-organization'),
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
                      tr('msg_insert-fields-below'),
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
                            autovalidateMode: AutovalidateMode.disabled,
                            textInputAction: TextInputAction.next,
                            focusNode: _nameFocus,
                            autofocus: true,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: tr('lbl_organisation-name'),
                                errorStyle: kErrorValidationText),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return tr('msg_required-field', args: [
                                  tr('lbl_organisation-name').toLowerCase()
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
                            autovalidateMode: AutovalidateMode.disabled,
                            textInputAction: TextInputAction.next,
                            focusNode: _streetFocus,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: tr('lbl_street-and-number'),
                                errorStyle: kErrorValidationText),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return tr('msg_required-field', args: [
                                  tr('lbl_street-and-number').toLowerCase()
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
                            autovalidateMode: AutovalidateMode.disabled,
                            textInputAction: TextInputAction.next,
                            focusNode: _zipFocus,
                            decoration: kTextFieldDecoration.copyWith(
                                labelText: tr('lbl_zipcode'),
                                errorStyle: kErrorValidationText),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return tr('msg_required-field',
                                    args: [tr('lbl_zipcode').toLowerCase()]);
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
                                tr('lbl_cancel'),
                                textWidthBasis: TextWidthBasis.parent,
                                style: kLinkText,
                              ),
                            ),
                          ),
                          RoundedButton(
                            color: UniColors.buttonGreen,
                            label: tr('lbl_register'),
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
