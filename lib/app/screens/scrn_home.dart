import 'package:Unizer/packages.dart';

class HomeScreen extends StatefulWidget {
  static const String screenID = 'home';
  final FirebaseUser currentUser;
  HomeScreen({this.currentUser});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    String _userDisplayName = widget.currentUser.displayName;
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        iconTheme: IconThemeData(color: Colors.black),
        actions: <Widget>[
          IconButton(
              alignment: Alignment.center,
              icon: Icon(Icons.close),
              onPressed: () {
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
      bottomNavigationBar: UniMainBottomBar(),
    );
  }
}
