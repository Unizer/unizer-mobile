import 'package:Unizer/packages.dart';
import 'package:Unizer/ui/app/elements/menu_left.dart';

class HomeScreen extends StatefulWidget {
  static const String screenID = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth =
      FirebaseAuth.instance; //intialise Firebase authentication object

  FirebaseUser _loggedInUser;
  String _userDisplayName;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      _loggedInUser = await _auth.currentUser();
      if (_loggedInUser != null) {
        _userDisplayName = _loggedInUser.displayName;
        print('User displayname = ${_loggedInUser.displayName}');
        print('User uid = ${_loggedInUser.uid}');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text(
          AppLocalizations.of(context).tr('lbl_home'),
          style: kTopMenubarTitle,
        ),
        backgroundColor: UniColors.appBarBackground,
      ),
      drawer: LeftMenu(userDisplayName: _userDisplayName),
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
          ),
        ],
      ),
    );
  }
}
