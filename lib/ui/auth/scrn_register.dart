import 'package:Unizer/packages.dart';

class RegisterScreen extends StatefulWidget {
  static const String screenID = 'register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
            UniCard(),
          ],
        ),
      ),
    );
  }
}
