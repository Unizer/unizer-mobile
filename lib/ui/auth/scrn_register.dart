import 'package:Unizer/packages.dart';

class RegisterScreen extends StatefulWidget {
  static const String screenID = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _firstNameFocus = FocusNode();
  final _lastNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

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
      body: Container(
        decoration: kBoxScreenDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(
                  left: kCardMargins,
                  right: kCardMargins,
                ),
                child: UniInfoBox(
                  label: AppLocalizations.of(context).tr('msg_register-info'),
                  screenID: RegisterScreen.screenID,
                ),
              ),
            ),
            UniCard(child:
            Form(
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
                  decoration: kTextFieldDecoration.copyWith(labelText: AppLocalizations.of(context).tr('lbl_first-name'),),
                  textInputAction: TextInputAction.next,
                    focusNode: _firstNameFocus,
                    autofocus: true,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_lastNameFocus);
                    },
                ),
                  SizedBox(
                    height: kTextFieldVerticalSpace,
                  ),
                  //Lastname
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(labelText: AppLocalizations.of(context).tr('lbl_last-name'),),
                    textInputAction: TextInputAction.next,
                    focusNode: _lastNameFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocus);
                    },
                  ),
                  SizedBox(
                    height: kTextFieldVerticalSpace,
                  ),
                  //Email
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(labelText: AppLocalizations.of(context).tr('lbl_email'),),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocus,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocus);
                    },
                  ),
                  SizedBox(
                    height: kTextFieldVerticalSpace,
                  ),
                  TextFormField(
                    decoration: kTextFieldDecoration.copyWith(labelText: AppLocalizations.of(context).tr('lbl_password'),),
                    textInputAction: TextInputAction.next,
                    focusNode: _passwordFocus,
                    obscureText: true,
                  ),
                  RoundedButton(color: UniColors.buttonGreen, label: AppLocalizations.of(context).tr('lbl_confirm'),),
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
