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
    );
  }
}
