import 'package:Unizer/packages.dart';

class UnizerScreen extends StatefulWidget {
  static const String screenID = 'unizers';
  final FirebaseUser currentUser;
  UnizerScreen({this.currentUser});

  @override
  _UnizerScreenState createState() => _UnizerScreenState();
}

class _UnizerScreenState extends State<UnizerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainTitleBar(
        title: AppLocalizations.of(context).tr('lbl_unizers'),
      ),
      drawer: LeftMenu(currentUser: widget.currentUser),
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
                    cardHeight: 100.0,
                    widgetContent: ListView(
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)
                              .tr('msg_unizer-home-info'),
                          style: kH2,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    screenID: UnizerScreen.screenID,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: MainBottomBar(),
    );
  }
}
