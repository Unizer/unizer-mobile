import 'package:Unizer/connector.dart';
import 'package:Unizer/app/elements/wdg_infobox.dart';

class HomeScreen extends StatefulWidget {
  static const String screenID = 'home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userDisplayName = '';

  getUserDisplayname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userDisplayName = prefs.get('userDisplayname');
    });
  }

  @override
  void initState() {
    //Set username field
    getUserDisplayname();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                UniInfoBox(
                  child: Column(
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).tr('msg_welcome-username',
                            args: [userDisplayName]),
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
