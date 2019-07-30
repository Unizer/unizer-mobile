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
                    cardHeight: 180.0,
                    widgetContent: Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        Align(
                          child: Image(
                            image: AssetImage(
                              'images/Ula-w-Unizer-phone-70x150.png',
                            ),
                            height: 130.0,
                          ),
                          alignment: Alignment.topRight,
                        ),
                        ListView(
                          scrollDirection: Axis.vertical,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              width: 300.0,
                              child: Text(
                                AppLocalizations.of(context)
                                    .tr('msg_unizer-home-info'),
                                style: kH2,
                                textAlign: TextAlign.left,
                                softWrap: true,
                              ),
                            ),
                            //TODO: Show proper button
                            RoundedButton(
                              color: Colors.white12,
                              label: AppLocalizations.of(context)
                                  .tr('btn_invite-more-friends'),
                              onPressed: () {},
                            ),
                          ],
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
