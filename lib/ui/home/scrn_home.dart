import 'package:Unizer/packages.dart';

final _auth = FirebaseAuth.instance; //intialise Firebase authentication object
final _firestore =
    Firestore.instance; //intialise Firestore Cloud authentication object
FirebaseUser _loggedInUser;

class HomeScreen extends StatefulWidget {
  static const String screenID = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getCurrentUser() async {
    try {
      final _currentUser = await _auth.currentUser();
      if (_currentUser != null) {
        _loggedInUser = _currentUser;
        print(_loggedInUser.displayName);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        automaticallyImplyLeading: false, //remove back button arrow
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
                    widgetContent: Text(
                      AppLocalizations.of(context).tr('msg_welcome-username',
                          args: [_loggedInUser.displayName]),
                      style: kH2,
                      textAlign: TextAlign.center,
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
