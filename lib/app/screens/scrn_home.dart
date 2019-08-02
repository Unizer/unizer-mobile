import 'package:Unizer/connector.dart';

class HomeScreen extends StatefulWidget {
  static const String screenID = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<FirebaseUser>(context);
    String _userDisplayName = '';
    if (user != null) {
      if (user.displayName == null) {
        _userDisplayName = '';
      } else {
        _userDisplayName = user.displayName;
      }
    }

    return Scaffold(
      appBar: MainTitleBar(
        title: AppLocalizations.of(context).tr('lbl_home'),
      ),
      drawer: LeftMenu(),
      body: Container(
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
                    widgetContent: ListView(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context).tr(
                              'msg_welcome-username',
                              args: [_userDisplayName]),
                          style: kH1,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: kCardVerticalSpace,
                        ),
                        Text(
                          AppLocalizations.of(context).tr('msg_up-to-date'),
                          style: kH2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    screenID: HomeScreen.screenID,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomBar(
        screenId: HomeScreen.screenID,
      ),
    );
  }
}
