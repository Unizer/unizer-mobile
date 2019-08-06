import 'package:Unizer/connector.dart';

class RegisterOrgScreen extends StatefulWidget {
  static const String screenID = 'register_org';

  @override
  _RegisterOrgScreenState createState() => _RegisterOrgScreenState();
}

class _RegisterOrgScreenState extends State<RegisterOrgScreen> {
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
        child: Wrap(
          direction: Axis.vertical,
          runAlignment: WrapAlignment.center,
          children: <Widget>[
            Container(
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
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    child: ProgressLine(
                      totalSteps: 3,
                      stepIndex: 1,
                    ),
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: kCardMargins,
                  ),
                  Text(
                    AppLocalizations.of(context).tr('lbl_insert-fields-below'),
                    style: kH4,
                  ),
                  SizedBox(
                    height: kH1VerticalSpace,
                  ),
                  Divider(
                    height: 0.0,
                    color: UniColors.dividerLine,
                  ),
                  Padding(
                    padding: EdgeInsets.all(kCardMargins),
                    child: Form(
                      child: TextFormField(
                        decoration: kTextFieldDecoration.copyWith(
                            labelText: AppLocalizations.of(context)
                                .tr('lbl_organisation-name'),
                            errorStyle: kErrorValidationText),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 100.0, left: kCardMargins, right: kCardMargins),
                    child: Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          label: AppLocalizations.of(context).tr('btn_next'),
                          elevation: 1.0,
                          icon: BoxIcons.bx_chevron_right,
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
    );
  }
}
